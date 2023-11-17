#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include<time.h>
#include<math.h>
#include<omp.h>
#define PI 3.14159265358979323846

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
	int i, j, k, numProcs, rank, n, stripSize;
	double * r1, * r2, * a, * b, * r1a, * r2b, * t, * c, * m, promedioR1, promedioR2, promedioR1R2;
	double sumatoriaR1, sumatoriaR2 = 0;
	double totalSumatoriaR1, totalSumatoriaR2;
	MPI_Status status;
	double commTimes[8], maxCommTimes[8], minCommTimes[8], commTime, totalTime;
	time_t T;
    srand((unsigned) time(&T));

	/* Lee par�metros de la l�nea de comando */
	if ((argc != 2) || ((n = atoi(argv[1])) <= 0) ) {
	    printf("\nUsar: %s size \n  size: Dimension de la matriz\n", argv[0]);
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
		c = (double*) malloc(sizeof(double)*n*n);
		t = (double*) malloc(sizeof(double)*n*n);
		m = (double*) malloc(sizeof(double)*n*n);
		//Codigo para complobar salida
		r1 = (double*) malloc(sizeof(double)*n*n);
		r2 = (double*) malloc(sizeof(double)*n*n);
		r1a = (double*) malloc(sizeof(double)*n*n);
		r2b = (double*) malloc(sizeof(double)*n*n);
	} else  {
		c = (double*) malloc(sizeof(double)*n*stripSize);
		t = (double*) malloc(sizeof(double)*n*stripSize);
		m = (double*) malloc(sizeof(double)*n*stripSize);
		//Codigo para complobar salida
		r1 = (double*) malloc(sizeof(double)*n*stripSize);
		r2 = (double*) malloc(sizeof(double)*n*stripSize);
		r1a = (double*) malloc(sizeof(double)*n*stripSize);
		r2b = (double*) malloc(sizeof(double)*n*stripSize);
	}
	// r1 = (double*) malloc(sizeof(double)*n*stripSize);
	// r2 = (double*) malloc(sizeof(double)*n*stripSize);
	// r1a = (double*) malloc(sizeof(double)*n*stripSize);
	// r2b = (double*) malloc(sizeof(double)*n*stripSize);
	a = (double*) malloc(sizeof(double)*n*n);
	b = (double*) malloc(sizeof(double)*n*n);
	
	// inicializar datos
	if (rank == COORDINATOR) {
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n; j++) {
	            m[i*n+j] = randFP(0, 2*PI);
				a[i+j*n] = randFP(1, 100);
				b[i+j*n] = randFP(1, 100);
				t[i*n+j] = randFP(1, 100);
				r1a[i*n+j] = 0;
				r2b[i*n+j] = 0;
			}   
    	}
	}

	MPI_Barrier(MPI_COMM_WORLD);

	commTimes[0] = MPI_Wtime();

	/* distribuir datos*/
	MPI_Scatter(m, stripSize*n, MPI_DOUBLE, m, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Scatter(t, stripSize*n, MPI_DOUBLE, t, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	MPI_Bcast(a, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Bcast(b, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	commTimes[1] = MPI_Wtime();

	//Inicialización de matrices r1 y r2
	for (i = 0; i < stripSize; i++) {
        for (j = 0; j < n; j++) {
            r1[i*n+j] = (1 - t[i*n+j])*(1- cos(m[i*n+j])) + t[i*n+j]*sin(m[i*n+j]);
            r2[i*n+j] = (1 - t[i*n+j])*(1- sin(m[i*n+j])) + t[i*n+j]*cos(m[i*n+j]);
            sumatoriaR1 = r1[i*n+j] + sumatoriaR1; // Calculo utilizado posteriormente para el promedio de R1
            sumatoriaR2 = r2[i*n+j] + sumatoriaR2; // Calculo utilizado posteriormente para el promedio de R2
        }
    }

	//Codigo para complobar salida
	if (rank == COORDINATOR){
		printf("\nMatriz a\n");
		for (i = 0; i < n; i++) {
			for (j = 0; j < n; j++) {
				printf("a[%d][%d]=%f\n", i, j, a[i+j*n]);
			}
		}
		printf("\nMatriz b\n");
		for (i = 0; i < n; i++) {
			for (j = 0; j < n; j++) {
				printf("b[%d][%d]=%f\n", i, j, b[i+j*n]);
			}
		}
	}
	

	commTimes[2] = MPI_Wtime();

	MPI_Reduce(&sumatoriaR1, &totalSumatoriaR1, 1, MPI_DOUBLE, MPI_SUM, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(&sumatoriaR2, &totalSumatoriaR2, 1, MPI_DOUBLE, MPI_SUM, COORDINATOR, MPI_COMM_WORLD);

	commTimes[3] = MPI_Wtime();

	if (rank == COORDINATOR) {
		promedioR1 = totalSumatoriaR1 / (n*n);
		promedioR2 = totalSumatoriaR2 / (n*n); 
		promedioR1R2 = promedioR1 * promedioR2;
	}

	commTimes[4] = MPI_Wtime();

	MPI_Bcast(&promedioR1R2, 1, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	commTimes[5] = MPI_Wtime();

	matmulblks(stripSize, r1, a, r1a, n, bs);
	matmulblks(stripSize, r2, b, r2b, n, bs);

	// MPI_Barrier(MPI_COMM_WORLD); 

	for (i = 0; i < stripSize; i++) {
		for (j = 0; j < n; j++) {
			c[i*n+j] = t[i*n+j] + ((r1a[i*n+j] + r2b[i*n+j]) * promedioR1R2);
    	}
    }

	commTimes[6] = MPI_Wtime();

	MPI_Gather(c, stripSize*n, MPI_DOUBLE, c, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	commTimes[7] = MPI_Wtime();

	MPI_Reduce(commTimes, minCommTimes, 8, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(commTimes, maxCommTimes, 8, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);

	//Codigo para complobar salida
	MPI_Gather(r1, stripSize*n, MPI_DOUBLE, r1, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Gather(r2, stripSize*n, MPI_DOUBLE, r2, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Gather(r1a, stripSize*n, MPI_DOUBLE, r1a, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
	MPI_Gather(r2b, stripSize*n, MPI_DOUBLE, r2b, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);


	MPI_Finalize();

	if (rank==COORDINATOR) {

		//Codigo para complobar salida
		printf("\nMatriz r1\n");
		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				printf("r1[%d][%d] = %f\n", i, j, r1[i*n+j]);
			}
		}

		printf("\nMatriz r2\n");
		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				printf("r2[%d][%d] = %f\n", i, j, r2[i*n+j]);
			}
		}

		printf("\nMatriz r1a\n");
		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				printf("r1a[%d][%d] = %f\n", i, j, r1a[i*n+j]);
			}
		}

		printf("\nMatriz r2b\n");
		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				printf("r2b[%d][%d] = %f\n", i, j, r2b[i*n+j]);
			}
		}

		printf("\nMatriz c\n");
		for (i = 0; i < n; i++){
			for (j = 0; j < n; j++) {
				printf("c[%d][%d] = %f\n", i, j, c[i*n+j]);
			}
		}

		totalTime = maxCommTimes[7] - minCommTimes[0];
		commTime = (maxCommTimes[1] - minCommTimes[0]) + (maxCommTimes[3] - minCommTimes[2]) + (maxCommTimes[5] - minCommTimes[4]) + (maxCommTimes[7] - minCommTimes[6]);		

		printf("Multiplicacion de matrices (n=%d)\tTiempo total=%lf\tTiempo comunicacion=%lf\n",n,totalTime,commTime);

	}
	
	free(r1);
	free(r2);
	free(a);
	free(b);
	free(r1a);
	free(r2b);
	free(t);
	free(c);
	free(m);

	return 0;
}

void matmulblks(int stripSize, double *a, double *b, double *c, int n, int bs) {
    int i, j, k;  
    for (i = 0; i < stripSize; i += bs) {
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