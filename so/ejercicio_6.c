#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define OFFSET 2

/*
/ Crea un nuevo fichero y escribe en una posición no inicial.
/ Después comprueba el tamaño del fichero creado.
*/

// TODO : el fichero de salida tiene caracteres basura

int main (int argc, char ** argv)
{	
	if (argc == 1 || argc > 2)
	{
		fprintf(stderr, "Uso: %s <fichero>\n", argv[0]);
		exit(-1);
	}
	
	char* fichero = argv[1];
	int descriptor = open(fichero, O_CREAT | O_TRUNC | O_RDWR, 0640);
	if (descriptor == -1)
	{
		perror("Error al crear el fichero");
		exit(-2);
	}
	
	// posicionar cursor y escribir mensaje
	lseek(descriptor, OFFSET, SEEK_SET);
	char* mensaje = "\nHola mundo\n";
	int tam_mensaje = sizeof(char) * (int) strlen(mensaje);
	int escribir = write(descriptor, mensaje, tam_mensaje);
	if (escribir == -1)
	{
		perror("Error al escribir fichero");
		exit(-3);
	}
	
	// comprobar tamaño
	int bytes = lseek(descriptor, 0, SEEK_END);
	if (bytes == -1)
	{
		perror("Error al comprobar tamaño del fichero");
		exit(-4);
	}
	
	if (close(descriptor) == -1)
	{
		perror("Error al cerrar el fichero");
		exit(-5);
	}
	
	printf("%s tiene %d bytes\n", fichero, bytes);
	
	exit(0);
}