
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
     int sockfd, newsockfd, portno;
     socklen_t clilen;
     char buffer[256];
     struct sockaddr_in serv_addr, cli_addr;
     int n;

     if (argc < 2) {
         fprintf(stderr,"ERROR, no port provided\n");
         exit(1);
     }

     // Crea el file descriptor del socket para la conexion
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     
     if (sockfd < 0) 
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     
     // Asigna el puerto pasado por argumento
     // Asigna la ip en donde escucha (su propia ip)
     portno = atoi(argv[1]);
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);

     // Vincula el file descriptor con la direccion y el puerto 
     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");

     // Setea la cantidad que pueden esperar mientras se maneja una conexion
     listen(sockfd,5);

     // Se bloquea a esperar una conexion
     clilen = sizeof(cli_addr);
     newsockfd = accept(sockfd, 
                 (struct sockaddr *) &cli_addr, 
                 &clilen);

     // Devuelve un nuevo descriptor por el cual se van a realizar las comunicaciones            
     if (newsockfd < 0) 
          error("ERROR on accept");
     bzero(buffer,256);

     // Lee el mensaje del cliente
     n = read(newsockfd,buffer,255);

     if (n < 0) error("ERROR reading from socket");
     printf("Here is the message: %s\n",buffer);

     // Espera 1 segundo
     sleep(1);

     n = write(newsockfd,"I got your message",18);

     if (n < 0) error("ERROR writing to socket");

     close(newsockfd);
     close(sockfd);

     return 0; 
}