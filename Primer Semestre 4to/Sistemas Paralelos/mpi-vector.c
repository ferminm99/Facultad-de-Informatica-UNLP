#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define COORDINATOR 0

int main(int argc, char* argv[]){
	int i, j, k, numProcs, rank, n, stripSize;
	double * v, * r, min;
	double minParcial = 99;
	double maxParcial = -1;
	double sumatoriaParcial = 0;
	double minTotal, maxTotal, sumatoriaTotal;
	MPI_Status status;

	/* Lee par�metros de la l�nea de comando */
	if ((argc != 2) || ((n = atoi(argv[1])) <= 0) ) {
	    printf("\nUsar: %s size \n  size: Dimension de la matriz y el vector\n", argv[0]);
		exit(1);
	}

	MPI_Init(&argc,&argv);

	MPI_Comm_size(MPI_COMM_WORLD,&numProcs);
	MPI_Comm_rank(MPI_COMM_WORLD,&rank);

	if (n % numProcs != 0) {
		printf("El tama�o de la matriz debe ser multiplo del numero de procesos.\n");
		exit(1);
	}

	// calcular porcion de cada worker
	stripSize = n / numProcs;

	// Reservar memoria
	if (rank == COORDINATOR) {
		v = (double*) malloc(sizeof(double)*n);
	}
	else  {
		v = (double*) malloc(sizeof(double)*stripSize);
	}

	r = (double*) malloc(sizeof(double)*stripSize);

	// inicializar datos
	if (rank == COORDINATOR) {
		for (i=0; i<n ; i++)
			v[i] = i+1;
	}

	MPI_Barrier(MPI_COMM_WORLD);

	/* distribuir datos*/
	MPI_Scatter(v, stripSize, MPI_DOUBLE, v, stripSize, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	for (i=0; i<stripSize ; i++){
		if(v[i] < minParcial){
			minParcial = v[i];
		}
		
		if(v[i] > maxParcial){
			maxParcial = v[i];
		}
		
		sumatoriaParcial+= v[i];
	}

	MPI_Reduce(&minParcial, &minTotal, 1, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(&maxParcial, &maxTotal, 1, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(&sumatoriaParcial, &sumatoriaTotal, 1, MPI_DOUBLE, MPI_SUM, COORDINATOR, MPI_COMM_WORLD);
	
	
	MPI_Finalize();

	if (rank == COORDINATOR) {
		printf("El mínimo es: %f\n", minTotal);
		printf("El máximo es: %f\n", maxTotal);
		printf("El promedio es: %f\n", (sumatoriaTotal/n));
	}


	// MPI_Reduce(v, minCommTimes, 4, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);



	free(v);

	return 0;
}