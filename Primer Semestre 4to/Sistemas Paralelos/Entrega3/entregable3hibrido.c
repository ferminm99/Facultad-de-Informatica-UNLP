#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include<time.h>
#include<math.h>
#include<omp.h>
#define PI 3.14159265358979323846

#define COORDINATOR 0

int bs;

void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs);

double randFP(double a, double b) {
    double random = ((double)rand())/(double)RAND_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

int main(int argc, char* argv[]){
	int i, j, k, numProcs, rank, n, stripSize;
	double *r1, *r2, *a, *b, *r1a, *r2b, *t, *c, *m, promedioR1, promedioR2, promedioR1R2;
	double sumatoriaR1, sumatoriaR2 = 0;
	double totalSumatoriaR1, totalSumatoriaR2;
	MPI_Status status;
	int provided, threads;
	double commTimes[6], maxCommTimes[6], minCommTimes[6], commTime, totalTime;
	time_t T;
    srand((unsigned) time(&T));

	/* Lee par�metros de la l�nea de comando */
	if ((argc != 4) || ((n = atoi(argv[1])) <= 0) || ((threads = atoi(argv[2])) < 2) ) {
	    printf("\nUsar: %s size \n  size: Dimension de la matriz\n", argv[0]);
		printf("La cantidad de hilos tiene que ser mínimo 2\n");
		exit(1);
	}

	bs = atoi(argv[3]);

	MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &provided);

	MPI_Comm_size(MPI_COMM_WORLD,&numProcs);
	MPI_Comm_rank(MPI_COMM_WORLD,&rank);

	// calcular porcion de cada worker
	stripSize = n / numProcs;

	if (rank == COORDINATOR){
		if (n % numProcs != 0) {
			printf("El tama�o de la matriz debe ser multiplo del numero de procesos.\n");
			exit(1);
		}
		if (bs > stripSize){
			printf("El tamaño de bloque es muy alto\n");
			exit(1);
		}	
	}

	// Reservar memoria
	if (rank == COORDINATOR) {
		c = (double*) malloc(sizeof(double)*n*n);
		t = (double*) malloc(sizeof(double)*n*n);
		m = (double*) malloc(sizeof(double)*n*n);

	} else  {
		c = (double*) malloc(sizeof(double)*n*stripSize);
		t = (double*) malloc(sizeof(double)*n*stripSize);
		m = (double*) malloc(sizeof(double)*n*stripSize);
	}

	r1 = (double*) malloc(sizeof(double)*n*stripSize);
	r2 = (double*) malloc(sizeof(double)*n*stripSize);
	r1a = (double*) malloc(sizeof(double)*n*stripSize);
	r2b = (double*) malloc(sizeof(double)*n*stripSize);
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
			}   
    	}
	}

	MPI_Barrier(MPI_COMM_WORLD);

	commTimes[0] = MPI_Wtime();

	#pragma omp parallel num_threads(threads)
	{
		/* distribuir datos*/
		#pragma omp single
		{
			MPI_Scatter(m, stripSize*n, MPI_DOUBLE, m, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
			MPI_Scatter(t, stripSize*n, MPI_DOUBLE, t, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

			MPI_Bcast(a, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
			MPI_Bcast(b, n*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

			commTimes[1] = MPI_Wtime();
		}


		//Inicialización de matrices r1 y r2
		#pragma omp for reduction(+:sumatoriaR1, sumatoriaR2) schedule(static)
		for (i = 0; i < stripSize; i++) {
			for (j = 0; j < n; j++) {
				r1[i*n+j] = (1 - t[i*n+j])*(1- cos(m[i*n+j])) + t[i*n+j]*sin(m[i*n+j]);
				r2[i*n+j] = (1 - t[i*n+j])*(1- sin(m[i*n+j])) + t[i*n+j]*cos(m[i*n+j]);
				sumatoriaR1 = r1[i*n+j] + sumatoriaR1; // Calculo utilizado posteriormente para el promedio de R1
				sumatoriaR2 = r2[i*n+j] + sumatoriaR2; // Calculo utilizado posteriormente para el promedio de R2
			}
		}
		

		#pragma omp single
		{
			commTimes[2] = MPI_Wtime();
			
			MPI_Allreduce(&sumatoriaR1, &totalSumatoriaR1, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
			MPI_Allreduce(&sumatoriaR2, &totalSumatoriaR2, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
		
			promedioR1 = totalSumatoriaR1 / (n*n);
			promedioR2 = totalSumatoriaR2 / (n*n); 
			promedioR1R2 = promedioR1 * promedioR2;
			
			commTimes[3] = MPI_Wtime();
		}
		

		#pragma omp for schedule(static) nowait
		for (i = 0; i < stripSize; i += bs) {
			for (j = 0; j < n; j += bs) {
				for (int k = 0; k < n; k += bs) {
					blkmul(&r1[i*n + k], &a[j*n + k], &r1a[i*n + j], n, bs);
				}
			}
		}

		#pragma omp for schedule(static) nowait
		for (i = 0; i < stripSize; i += bs) {
			for (j = 0; j < n; j += bs) {
				for (int k = 0; k < n; k += bs) {
					blkmul(&r2[i*n + k], &b[j*n + k], &r2b[i*n + j], n, bs);
				}
			}
		}

		#pragma omp for schedule(static)
		for (i = 0; i < stripSize; i++) {
			for (j = 0; j < n; j++) {
				c[i*n+j] = t[i*n+j] + ((r1a[i*n+j] + r2b[i*n+j]) * promedioR1R2);
			}
		}

		
		#pragma omp single
		{
			commTimes[4] = MPI_Wtime();
			
			MPI_Gather(c, stripSize*n, MPI_DOUBLE, c, stripSize*n, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);
		
			commTimes[5] = MPI_Wtime();
		}

	
	}
	
	MPI_Reduce(commTimes, minCommTimes, 6, MPI_DOUBLE, MPI_MIN, COORDINATOR, MPI_COMM_WORLD);
	MPI_Reduce(commTimes, maxCommTimes, 6, MPI_DOUBLE, MPI_MAX, COORDINATOR, MPI_COMM_WORLD);


	MPI_Finalize();
	
	if (rank==COORDINATOR) {

		totalTime = maxCommTimes[5] - minCommTimes[0];
		commTime = (maxCommTimes[1] - minCommTimes[0]) + (maxCommTimes[3] - minCommTimes[2]) + (maxCommTimes[5] - minCommTimes[4]);		

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