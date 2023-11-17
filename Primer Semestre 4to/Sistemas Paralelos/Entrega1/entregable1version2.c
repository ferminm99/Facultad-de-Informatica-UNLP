#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define PI 3.14159265358979323846

//Definimos valores por defecto para el tamaño de la matriz (N) y el tamaño de bloque (bs)
//El tamaño de N debe ser múltiplo de bs
int N=32;
int bs=32;

/* Funciones para calcular el tiempo en segundos desde algun punto del pasado */
double dwalltime();
double gettimeofday();

//Funcion para generar numeros aleatorios brindada por el ayudante
double randFP(double a, double b) {
    double random = ((double)rand())/(double)RAND_MAX;
    double diff = b - a;
    double r = random * diff;
    return a + r;
}

int main(int argc,char*argv[]){
    double *A, *B, *C, *T, *R, *M, *RA, *RB;
    double promedioR, timetick; 
    double sumatoria = 0;
    time_t t;
    srand((unsigned) time(&t));

    //Chequeo de los argumentos del programa
    if ((argc != 3) || ((N = atoi(argv[1])) <= 0) || ((bs = atoi(argv[2])) <= 0) || ((N % bs) != 0)) {
        printf("\nError en los parametros. Usage: ./%s N BS (N debe ser multiplo de BS)\n", argv[0]);
        exit(1);
    }

    //Alocacion del espacio de memoria siguiendo la tecnica "arreglo dinamico como vector de elementos"
    A=(double *) malloc(N*N*sizeof(double));
    B=(double *) malloc(N*N*sizeof(double));
    C=(double *) malloc(N*N*sizeof(double));
    T=(double *) malloc(N*N*sizeof(double));
    R=(double *) malloc(N*N*sizeof(double));
    M=(double *) malloc(N*N*sizeof(double));
    RA=(double *) malloc(N*N*sizeof(double));
    RB=(double *) malloc(N*N*sizeof(double));

    //Inicializacion de las matrices M, A, B y T con numeros random, y en 0 RA y RB
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            M[i*N+j] = randFP(0, 2*PI);
            A[i+j*N] = randFP(1, 100);
            B[i+j*N] = randFP(1, 100);
            T[i*N+j] = randFP(1, 100);
            RA[i*N+j] = 0;
            RB[i*N+j] = 0;
        }   
    }

    timetick = dwalltime();

    //Calculo de la matriz R
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            R[i*N+j] = (1 - T[i*N+j])*(1- cos(M[i*N+j])) + T[i*N+j]*sin(M[i*N+j]);
            sumatoria = R[i*N+j] + sumatoria; // Calculo utilizado posteriormente para el promedio de R
        }  
    }

    //Calculo del promedio de R
    promedioR = sumatoria / (N*N);
    
    // Multiplicacion de R con A y R con B
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                RA[i*N+j] += R[i*N+k] * A[j*N+k];
                RB[i*N+j] += R[i*N+k] * B[j*N+k];
            }
        }
    }

    //Calculo de C
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i*N+j] = T[i*N+j] + ((RA[i*N+j] + RB[i*N+j]) * promedioR);
        }
    }

    printf("Calculo de ecuacion con matrices de %dx%d. Tiempo en segundos %f\n",N,N, dwalltime() - timetick);
    
    //Liberacion de la memoria reservada para las matrices
    free(A);
    free(B);
    free(C);
    free(T);
    free(R);
    free(M);
    free(RA);
    free(RB);

    return(0);  
}

double dwalltime(){
    double sec;
    struct timeval tv;

    gettimeofday(&tv,NULL);
    sec = tv.tv_sec + tv.tv_usec/1000000.0;
    return sec;
}
