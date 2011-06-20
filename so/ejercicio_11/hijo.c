#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_BUFFER 1024

/*
/ Copia el contenido de la entrada estándar en el fichero pasado como
/ parámetro.
*/

int main (int argc, char ** argv)
{	
	if (argc != 2)
	{
		fprintf(stderr, "Uso: %s <fichero-destino>\n", argv[0]);
		exit(-1);
	}
	
	int fichero_destino = open(argv[1], O_CREAT | O_TRUNC | O_WRONLY, 022);
	if (fichero_destino == -1)
	{
		perror("error al abrir el fichero");
		exit(-1);
	}
	
	char buffer[MAX_BUFFER];
	int bytes_leidos;
	while ((bytes_leidos = read(0, buffer, MAX_BUFFER)) > 0)
		write(fichero_destino, buffer, bytes_leidos);
		
	close(fichero_destino);
}