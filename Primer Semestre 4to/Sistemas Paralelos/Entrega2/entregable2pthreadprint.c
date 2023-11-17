#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include <pthread.h>
#include<math.h>
#define PI 3.14159265358979323846

int N=32;
int NUM_THREADS;
int bs = 2;
int block_size;
double *A, *B, *C, *T, *R1, *R2, *M, *R1A, *R2B, *vectorSumatoriaR1, *vectorSumatoriaR2, promedioR1R2;
pthread_barrier_t avrgBarrierMaster;
pthread_barrier_t avrgBarrierThreads;

double dwalltime();
double gettimeofday();

double randFP(double a, double b) {
    double random = ((double)rand())/(double)RAND_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

void* inicializarR1R2(int id, int start, int end){
  int i,j;
  double sumatoriaR1, sumatoriaR2 = 0;
  for(i=start;i<end;i++){
    for (int j = 0; j < N; j++) {
        R1[i*N+j] = (1 - T[i*N+j])*(1- cos(M[i*N+j])) + T[i*N+j]*sin(M[i*N+j]);
        R2[i*N+j] = (1 - T[i*N+j])*(1- sin(M[i*N+j])) + T[i*N+j]*cos(M[i*N+j]);
        sumatoriaR1 = R1[i*N+j] + sumatoriaR1; // Calculo utilizado posteriormente para el promedio de R1
        sumatoriaR2 = R2[i*N+j] + sumatoriaR2; // Calculo utilizado posteriormente para el promedio de R2
    }  
  }
  vectorSumatoriaR1[id] = sumatoriaR1;
  vectorSumatoriaR2[id] = sumatoriaR2;
}

void blkmul(double *ablk, double *bblk, double *cblk, int N, int bs) {
    int i, j, k;  

    for (i = 0; i < bs; i++) {
        for (j = 0; j < bs; j++) {
            for  (k = 0; k < bs; k++) {
                cblk[i*N + j] += ablk[i*N + k] * bblk[j*N + k];
            }
        }
    }
}

void* matmulblks(int startBlock, int endBlock, double *A, double *B, double *C) {
    int i, j, k;  

    for (i = startBlock; i < endBlock; i += bs) {
        for (j = 0; j < N; j += bs) {
            for  (k = 0; k < N; k += bs) {
                blkmul(&A[i*N + k], &B[j*N + k], &C[i*N + j], N, bs);
            }
        }
    }
}

void* calculoDeC(int startBlock, int endBlock){
    int i, j;

    for (i = startBlock; i < endBlock; i++) {
        for (j = 0; j < N; j++) {
            C[i*N+j] = T[i*N+j] + ((R1A[i*N+j] + R2B[i*N+j]) * promedioR1R2);
        }
    }
}

void* f(void* id){
    int block = *((int*)id);
    int start = block*block_size;
    int end = start+block_size;
    
    inicializarR1R2(block, start, end);
    pthread_barrier_wait(&avrgBarrierMaster);
    
    matmulblks(start, end, R1, A, R1A);
    matmulblks(start, end, R2, B, R2B);
    pthread_barrier_wait(&avrgBarrierThreads);
    
    calculoDeC(start, end);

    pthread_exit(0);
}

int main(int argc,char*argv[]){
    double sumatoriaR1, sumatoriaR2 = 0;
    double promedioR1, promedioR2, timetick;
    time_t t;
    srand((unsigned) time(&t));

    //Chequeo de los argumentos del programa
    if ((argc != 3) || ((N = atoi(argv[1])) <= 0) || ((NUM_THREADS = atoi(argv[2])) <= 0) || ((N % bs) != 0)) {
        printf("\n Tiene que haber por lo menos 1 hilo, N ser múltiplo de 2.");
        printf("\nError en los parametros. Usage: ./%s N BS (N debe ser multiplo de BS)\n", argv[0]);
        exit(1);
    }

    block_size = N/NUM_THREADS;

    // Inicializacion de threads
    int ids[NUM_THREADS]; 
    pthread_attr_t attr;
    pthread_t threads[NUM_THREADS];
    pthread_attr_init(&attr);

    // Inicializacion de puntos de sincronización
    pthread_barrier_init (&avrgBarrierMaster, NULL, NUM_THREADS+1);
    pthread_barrier_init (&avrgBarrierThreads, NULL, NUM_THREADS+1);

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
    vectorSumatoriaR1=(double *) malloc(NUM_THREADS*sizeof(double));
    vectorSumatoriaR2=(double *) malloc(NUM_THREADS*sizeof(double));

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

    //Inicializacion de las matrices M, A, B y T con numeros random, y en 0 R1A y R2B
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            R1A[i*N+j] = 0;
            R2B[i*N+j] = 0;
        }   
    }

    timetick = dwalltime();


    for(int i=0;i<NUM_THREADS;i++){
        ids[i]= i;
        pthread_create(&threads[i], &attr, f, &ids[i]);
    }
    
    pthread_barrier_wait(&avrgBarrierMaster);
    //calcular promedio R1 y R2
    for (int i = 0; i < NUM_THREADS; i++){
        sumatoriaR1 += vectorSumatoriaR1[i];
        sumatoriaR2 += vectorSumatoriaR2[i]; 
    }
    promedioR1 = sumatoriaR1 / (N*N);
    promedioR2 = sumatoriaR2 / (N*N);
    promedioR1R2 = promedioR1 * promedioR2;
    pthread_barrier_wait(&avrgBarrierThreads);

    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i], NULL);
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

    int pthread_barrier_destroy(pthread_barrier_t *avrgBarrierMaster);
    int pthread_barrier_destroy(pthread_barrier_t *avrgBarrierThreads);

    return(0);  
}

double dwalltime(){
    double sec;
    struct timeval tv;

    gettimeofday(&tv,NULL);
    sec = tv.tv_sec + tv.tv_usec/1000000.0;
    return sec;
}