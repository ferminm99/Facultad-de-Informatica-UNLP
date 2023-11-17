#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define COORDINATOR 0

int bs = 2;

void matmulblks(int stripSize, double *a, double *b, double *c, int n, int bs);
void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs);

double randFP(double a, double b) {
    double random = ((double)rand())/(double)RAND_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

int main(int argc, char* argv[]){
	int i, j, k, numProcs, rank, n, stripSize, check = 1;
	double * a, * b, * c, * d, * ab, * cd, *r;
	MPI_Status status;
	double commTimes[4], maxCommTimes[4], minCommTimes[4], commTime, totalTime;

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
		a = (double*) malloc(sizeof(double)*n*n);
		c = (double*) malloc(sizeof(double)*n*n);
		r = (double*) malloc(sizeof(double)*n*n);
	} else  {
		a = (double*) malloc(sizeof(double)*n*stripSize);
		c = (double*) malloc(sizeof(double)*n*stripSize);
		r = (double*) malloc(sizeof(double)*n*stripSize);
	}
	ab = (double*) malloc(sizeof(double)*n*stripSize);
	cd = (double*) malloc(sizeof(double)*n*stripSize);
	b = (double*) malloc(sizeof(double)*n*n);
	d = (double*) malloc(sizeof(double)*n*n);


	// // Reservar memoria
	// a = (double*) malloc(sizeof(double)*n*n);
	// b = (double*) malloc(sizeof(double)*n*n);
	// ab = (double*) malloc(sizeof(double)*n*n);
	// c = (double*) malloc(sizeof(double)*n*n);
	// d = (double*) malloc(sizeof(double)*n*n);
	// cd = (double*) malloc(sizeof(double)*n*n);
	// r = (double*) malloc(sizeof(double)*n*n);


	// inicializar datos
	// if (rank == COORDINATOR) {
	// 	for (int i = 0; i < N; i++) {
	// 		for (int j = 0; j < N; j++) {
	// 			a[i*N+j] = randFP(1, 100);
	// 			b[i*N+j] = randFP(1, 100);
	// 			c[i*N+j] = randFP(1, 100);
	// 			d[i*N+j] = randFP(1, 100);
	// 			ab[i*N+j] = 0;
	// 			cd[i*N+j] = 0;
	// 			r[i*N+j] = 0;
	// 		}   
    // 	}
	// }

	if (rank == COORDINATOR) {
		for (i = 0; i < n ; i++)
			for (j = 0; j < n ; j++)
				a[i * n + j] = 1;
		for (i = 0; i < n ; i++)
			for (j = 0; j < n ; j++)
				b[j * n + i] = 1;
		for (i = 0; i < n ; i++)
			for (j = 0; j < n ; j++)
				c[i * n + j] = 1;
		for (i = 0; i < n ; i++)
			for (j = 0; j < n ; j++)
				d[j * n + i] = 1;
	}

	MPI_Barrier(MPI_COMM_WORLD);

	commTimes[0] = MPI_Wtime();

	/* distribuir datos*/
	MPI_Scatter(a, stripSize*n, MPI_DOUBLE, a, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Scatter(c, stripSize*n, MPI_DOUBLE, c, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	MPI_Bcast(b, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Bcast(d, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);


	commTimes[1] = MPI_Wtime();

	matmulblks(stripSize, a, b, ab, n, bs);
	matmulblks(stripSize, c, d, cd, n, bs);

	for (int i = 0; i < stripSize*n; i++) {
			r[i] = ab[i] + cd[i];
	}
	
	commTimes[2] = MPI_Wtime();

	// recolectar resultados parciales

	MPI_Gather(r, stripSize*n, MPI_DOUBLE, r, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	commTimes[3] = MPI_Wtime();

	MPI_Reduce(commTimes, minCommTimes, 4, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(commTimes, maxCommTimes, 4, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);

	MPI_Finalize();

	if (rank==COORDINATOR) {

		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				check = check && (r[i * n + j] == 2*n);
			}
		}

		if (check) {
			printf("Multiplicacion de matrices resultado correcto\n");
		} else {
			printf("Multiplicacion de matrices resultado erroneo\n");
		}
		
		totalTime = maxCommTimes[3] - minCommTimes[0];
		commTime = (maxCommTimes[1] - minCommTimes[0]) + (maxCommTimes[3] - minCommTimes[2]);		

		printf("Multiplicacion de matrices (N=%d)\tTiempo total=%lf\tTiempo comunicacion=%lf\n",n,totalTime,commTime);
	}
	
	free(a);
	free(b);
	free(c);
	free(d);
	if(rank != COORDINATOR){
		free(ab);
		free(cd);
	}
	free(r);

	return 0;
}

void matmulblks(int stripSize, double *a, double *b, double *c, int n, int bs) {
    int i, j, k;  
    for (i = 0; i < stripSize; i += bs) {
    // for (i = stripSize*n*rank; i < stripSize*n*rank+stripSize*n; i += bs) {
        for (j = 0; j < n; j += bs) {
            for (k = 0; k < n; k += bs) {
                blkmul(&a[i*n + k], &b[j*n + k], &c[i*n + j], n, bs);
            }
        }
    }
}

void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs) {
    int i, j, k;  
    for (i = 0; i < bs; i++) {
        for (j = 0; j < bs; j++) {
            for  (k = 0; k < bs; k++) {
                cblk[i*n + j] += ablk[i*n + k] * bblk[j*n + k];
            }
        }
    }
}