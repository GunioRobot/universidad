#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


/*
/ Ejecuta la orden que se le pasa como primer parámetro y redirige su salida
/ estándar a un fichero especificado como segundo parámetro.
*/

int main (int argc, char ** argv)
{	
	if (argc != 3)
	{
		fprintf(stderr, "Uso: %s <orden> <fichero-destino>\n", argv[0]);
		exit(-1);
	}
	
	int fichero_destino = open(argv[2], O_CREAT | O_TRUNC | O_WRONLY, 022);
	if (fichero_destino == -1)
	{
		perror("error al abrir el fichero destino");
		exit(-1);
	}
	
	// cerrar salida estándar y cambiarla por el fichero destino
	close(1);
	dup(fichero_destino);
	close(fichero_destino);
	
	if (execl(argv[1], "redirigir", NULL) == -1)
	{
		perror("error al ejecutar la orden");
		exit(-1);
	}	
	
	exit(0);
}