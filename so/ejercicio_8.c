#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MAX_CARACTERES 1024

/*
/ Muestra el contenido del fichero que se le pasa como parámetro.
*/

int main (int argc, char ** argv)
{	
	if (argc != 2)
	{
		fprintf(stderr, "Uso: %s <fichero>\n", argv[0]);
		exit(-1);
	}

	// obtener información del fichero
	char* fichero = argv[1];
	struct stat info_fichero;
	if (stat(fichero, &info_fichero) == -1)
	{
		perror("Error al obtener información del fichero");
		exit(-2);
	}
	
	// chequear el tipo de fichero y mostrarlo
	if (S_ISREG(info_fichero.st_mode))
	{
		// abrir fichero en modo lectura
		int descriptor = open(fichero, O_RDONLY);
		if (descriptor == -1)
		{
			perror("Error al abrir el fichero");
			exit(-3);
		}
		
		// escribir su contenido
		char buf[MAX_CARACTERES];
		int bytes_leidos = read(descriptor, buf, MAX_CARACTERES);
		while (bytes_leidos > 0)
		{
			printf("%s", buf);
			bytes_leidos = read(descriptor, buf, MAX_CARACTERES);
		}
	}
	else
	{
		perror("El parámetro no es un fichero regular");
		exit(-4);
	}	
	exit(0);
}