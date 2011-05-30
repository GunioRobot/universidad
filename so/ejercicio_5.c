#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

/*
/ Dado un fichero, muestra su tamaño en bytes utilizando open,
/ lseek y close.
*/

int main (int argc, char ** argv)
{	
	if (argc == 1 || argc > 2)
	{
		fprintf(stderr, "Uso: %s <fichero>\n", argv[0]);
		exit(-1);
	}
	
	char* fichero = argv[1];
	int descriptor = open(fichero, O_RDONLY);
	if (descriptor == -1)
	{
		perror("Error al abrir el fichero");
		exit(-2);
	}
	
	// posicionar cursor al final del fichero
	int bytes = lseek(descriptor, 0, SEEK_END);
	if (bytes == -1)
	{
		perror("Error al comprobar tamaño del fichero");
		exit(-3);
	}
	
	if (close(descriptor) == -1)
	{
		perror("Error al cerrar el fichero");
		exit(-4);
	}
	
	printf("%s tiene %d bytes\n", fichero, bytes);
	
	exit(0);
}