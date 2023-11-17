#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#include<omp.h>
#define PI 3.14159265358979323846

//Definimos valores por defecto para el tamaño de la matriz (N) y el tamaño de bloque (bs)
//El tamaño de N debe ser múltiplo de bs
int N=32;
int NUM_THREADS;
int bs = 64;

/* Funciones para calcular el tiempo en segundos desde algun punto del pasado */
double dwalltime();
double gettimeofday();

//Funciones para realizar la multiplicacion de matrices por bloques
/* Multiply square matrices, blocked version */
void matmulblks(double *a, double *b, double *c, int n, int bs);
/* Multiply (block) submatrices */
void blkmul(double *ablk, double *bblk, double *cblk, int n, int bs);

//Funcion para generar numeros aleatorios brindada por el ayudante
double randFP(double a, double b) {
    double random = ((double)rand())/(double)RAND_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

int main(int argc,char*argv[]){
    double *A, *B, *C, *T, *R1, *R2, *M, *R1A, *R2B;
    double promedioR1, promedioR2, promedioR1R2, timetick; 
    double sumatoriaR1 = 0;
    double sumatoriaR2 = 0;
    time_t t;
    srand((unsigned) time(&t));

    //Chequeo de los argumentos del programa
    if ((argc != 3) || ((N = atoi(argv[1])) <= 0) || ((NUM_THREADS = atoi(argv[2])) <= 0) || ((N % bs) != 0)) {
        printf("\n Tiene que haber por lo menos 1 hilo, N ser múltiplo de 2.");
        printf("\nError en los parametros. Usage: ./%s N BS (N debe ser multiplo de BS)\n", argv[0]);
        exit(1);
    }
    
    omp_set_num_threads(NUM_THREADS);

    //Alocacion del espacio de memoria siguiendo la tecnica arreglo dinamico como vector de elementos
    A=(double *) malloc(N*N*sizeof(double));
    B=(double *) malloc(N*N*sizeof(double));
    C=(double *) malloc(N*N*sizeof(double));
    T=(double *) malloc(N*N*sizeof(double));
    R1=(double *) malloc(N*N*sizeof(double));
    R2=(double *) malloc(N*N*sizeof(double));
    M=(double *) malloc(N*N*sizeof(double));
    R1A=(double *) malloc(N*N*sizeof(double));
    R2B=(double *) malloc(N*N*sizeof(double));

    //Inicializacion de las matrices M, A, B y T con numeros random, y en 0 RA y RB
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            M[i*N+j] = randFP(0, 2*PI);
            A[i+j*N] = randFP(1, 100);
            B[i+j*N] = randFP(1, 100);
            T[i*N+j] = randFP(1, 100);
            R1A[i*N+j] = 0;
            R2B[i*N+j] = 0;
        }   
    }

    timetick = dwalltime();

    #pragma omp parallel
    {
        //Calculo de la matriz R
        int i, j;
        #pragma omp for private(i, j) reduction(+:sumatoriaR1, sumatoriaR2) 
        for (i = 0; i < N; i++) {
            for (j = 0; j < N; j++) {
                R1[i*N+j] = (1 - T[i*N+j])*(1- cos(M[i*N+j])) + T[i*N+j]*sin(M[i*N+j]);
                R2[i*N+j] = (1 - T[i*N+j])*(1- sin(M[i*N+j])) + T[i*N+j]*cos(M[i*N+j]);
                sumatoriaR1 = R1[i*N+j] + sumatoriaR1; // Calculo utilizado posteriormente para el promedio de R1
                sumatoriaR2 = R2[i*N+j] + sumatoriaR2; // Calculo utilizado posteriormente para el promedio de R2
            }  
        }

        //Calculo del promedio de R
        #pragma omp single nowait
        {
            promedioR1 = sumatoriaR1 / (N*N);
            promedioR2 = sumatoriaR2 / (N*N);
            promedioR1R2 = promedioR1 * promedioR2;
        }     

        //Multiplicacion de R con A
        matmulblks(R1, A, R1A, N, bs);
        //Multiplicacion de R con B
        matmulblks(R2, B, R2B, N, bs);
        
                
        //Calculo de C
        #pragma omp for private (i, j)
        for (i = 0; i < N; i++) {
            for (j = 0; j < N; j++) {
                C[i*N+j] = T[i*N+j] + ((R1A[i*N+j] + R2B[i*N+j]) * promedioR1R2);
            }
        }
    }
    printf("Calculo de ecuacion con matrices de %dx%d. Tiempo en segundos %f\n",N,N, dwalltime() - timetick);

    // printf("\nMatriz R1\n");
    // for (int i = 0; i < N; i++) {
    //     for (int j = 0; j < N; j++) {
    //         printf("[%d,%d] = %f\n", i, j, R1[i*N+j]);
    //     }
    // }

    // printf("\nMatriz A\n");
    // for (int i = 0; i < N; i++) {
    //     for (int j = 0; j < N; j++) {
    //         printf("[%d,%d] = %f\n", i, j, A[i+j*N]);
    //     }
    // }

    // printf("\nMatriz R1A\n");
    // for (int i = 0; i < N; i++) {
    //     for (int j = 0; j < N; j++) {
    //         printf("[%d,%d] = %f\n", i, j, R1A[i*N+j]);
    //     }
    // }

    //Liberacion de la memoria reservada para las matrices
    free(A);
    free(B);
    free(C);
    free(T);
    free(R1);
    free(R2);
    free(M);
    free(R1A);
    free(R2B);

    return(0);  
}

double dwalltime(){
    double sec;
    struct timeval tv;

    gettimeofday(&tv,NULL);
    sec = tv.tv_sec + tv.tv_usec/1000000.0;
    return sec;
}

void matmulblks(double *a, double *b, double *c, int n, int bs) {
    int i, j, k;  

    #pragma omp for private (i, j, k)
    for (i = 0; i < n; i += bs) {
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