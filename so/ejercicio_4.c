#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

/*
/ Programa para hacer una o más copias de un fichero.
*/

#define MAX_CARACTERES 1024
#define MAX_DESCRIPTORES 50

int main (int argc, char ** argv)
{	
	int arg, i;
	int* descriptores;
	
	// comprobar si el número de parámetros es correcto
	if (argc < 3)
	{
		fprintf(stderr, "Uso: %s <fichero-origen> <fichero-destino> [<fichero-destino>]\n", argv[0]);
		exit(-1);
	}
	else if (argc > MAX_DESCRIPTORES + 3)
	{
		perror("Se pueden 51 copias como máximo");
		exit(-2);
	}
	
	// obtener descriptor de fichero origen y abrirlo en sólo lectura
	char * origen = argv[1];
	int descriptor_origen = open(origen, O_RDONLY);
	if (descriptor_origen == -1)
	{
		perror("No se ha podido abrir el fichero origen");
		exit(-3);
	}
	
	// reservar memoria para descriptores de ficheros destino
	int num_descriptores = argc - 1;
	descriptores = malloc(sizeof(int) * num_descriptores);
	if (descriptores == NULL)
	{
		perror("Error al reservar memoria");
		exit(-4);
	}
	
	// abrir ficheros destino y obtener sus descriptores
	for (i = 0, arg = 2; i <= num_descriptores; ++i, ++arg)
	{
		descriptores[i] = open(argv[arg], O_CREAT | O_TRUNC | O_WRONLY, 0640);
		if (descriptores[i] == -1)
		{
			// ignorar fichero mal especificado
			--i;
			--num_descriptores;
		}
	}	
	
	// copiar contenido de fichero origen en ficheros destino
	char buf[MAX_CARACTERES];
	int bytes_leidos = read(descriptor_origen, buf, MAX_CARACTERES);
	while (bytes_leidos > 0)
	{
		for (i = 0; i < num_descriptores; ++i)
		{
			if (write(descriptores[i], buf, bytes_leidos) == -1)
				perror("Error al copiar");
		}
		bytes_leidos = read(descriptor_origen, buf, MAX_CARACTERES);
	}
	
	// cerrar todos los ficheros abiertos
	if (close(descriptor_origen) == -1)
		perror("Error al cerrar");
	for (i = 0; i < num_descriptores; ++i)
	{
		if (close(descriptores[i]) == -1)
			perror("Error al cerrar");
	}
	
	free(descriptores);	
	
	exit(0);
}