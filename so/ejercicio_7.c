#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

/*
/ Programa para borrar uno o más ficheros.
*/

#define MAX_DESCRIPTORES 50

int main (int argc, char ** argv)
{	
	int arg, i;
	int* descriptores;
	
	// comprobar si el número de parámetros es correcto
	if (argc < 2)
	{
		fprintf(stderr, "Uso: %s <fichero> [<fichero>, ...]\n", argv[0]);
		exit(-1);
	}
	else if (argc > MAX_DESCRIPTORES + 2)
	{
		perror("Se pueden borrar 51 fichero como máximo");
		exit(-2);
	}
	
	// iterar sobre los ficheros e ir borrándolos
	int num_ficheros = argc - 1;
	for (i = 1; i <= num_ficheros; ++i)
	{
		char* ruta = argv[i];
		int borrar = remove(ruta);
		if (borrar == -1)
			printf("El fichero %s no se ha podido borrar.\n", ruta);
	}	
		
	exit(0);
}