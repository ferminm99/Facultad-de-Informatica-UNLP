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
int bs = 2;

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

    M[0*N+0] = 1.849267;
    M[0*N+1] = 1.880657;
    M[0*N+2] = 2.602202;
    M[0*N+3] = 3.200894;
    M[1*N+0] = 1.322647;
    M[1*N+1] = 1.695682;
    M[1*N+2] = 2.207362;
    M[1*N+3] = 1.885152;
    M[2*N+0] = 0.369521;
    M[2*N+1] = 5.444304;
    M[2*N+2] = 1.489501;
    M[2*N+3] = 2.788930;
    M[3*N+0] = 4.134537;
    M[3*N+1] = 3.693435;
    M[3*N+2] = 5.419336;
    M[3*N+3] = 0.957360;

    A[0+N*0] = 44.919447;
    A[0+N*1] = 98.381286;
    A[0+N*2] = 11.605420;
    A[0+N*3] = 23.060870;
    A[1+N*0] = 22.533610;
    A[1+N*1] = 25.007298;
    A[1+N*2] = 59.790682;
    A[1+N*3] = 61.902849;
    A[2+N*0] = 88.401016;
    A[2+N*1] = 13.863665;
    A[2+N*2] = 22.882454;
    A[2+N*3] = 44.611562;
    A[3+N*0] = 35.187721;
    A[3+N*1] = 27.598218;
    A[3+N*2] = 54.181643;
    A[3+N*3] = 27.377421;   

    B[0+N*0] = 6.154822;
    B[0+N*1] = 98.238501;
    B[0+N*2] = 83.896403;
    B[0+N*3] = 69.790850;
    B[1+N*0] = 96.628351;
    B[1+N*1] = 54.513603;
    B[1+N*2] = 10.466182;
    B[1+N*3] = 83.246194;
    B[2+N*0] = 15.625164;
    B[2+N*1] = 38.986050;
    B[2+N*2] = 74.820711;
    B[2+N*3] = 38.559370;
    B[3+N*0] = 73.084614;
    B[3+N*1] = 44.715461;
    B[3+N*2] = 44.131227;
    B[3+N*3] = 75.932759;

    T[0*N+0] = 55.784399;
    T[0*N+1] = 3.531480;
    T[0*N+2] = 47.037230;
    T[0*N+3] = 63.655909;
    T[1*N+0] = 8.301220;
    T[1*N+1] = 51.852553;
    T[1*N+2] = 50.156271;
    T[1*N+3] = 59.840766;
    T[2*N+0] = 36.454570;
    T[2*N+1] = 28.783482;
    T[2*N+2] = 74.903460;
    T[2*N+3] = 65.783394;
    T[3*N+0] = 92.862907;
    T[3*N+1] = 93.974956;
    T[3*N+2] = 17.091994;
    T[3*N+3] = 21.906788;

    //Inicializacion de las matrices M, A, B y T con numeros random, y en 0 RA y RB
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
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

    printf("\nMatriz C\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("[%d,%d] = %f\n", i, j, C[i*N+j]);
        }
    }

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