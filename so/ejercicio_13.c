#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


/*
/ Ejecuta la orden que se le pasa como primer parámetro y redirige su salida
/ estándar a la orden especificada como segundo parámetro.
*/

int main (int argc, char ** argv)
{	
	int tuberia[2];
	int pid;
	
	if (argc != 3)
	{
		fprintf(stderr, "Uso: %s <orden> <orden>\n", argv[0]);
		exit(-1);
	}
	
	if (pipe(tuberia) == -1)
	{
		perror("error al crear el pipe");
		exit(-1);
	}
	
	pid = fork();
	if (pid == -1)
	{
		perror("error al crear proceso hijo");
		exit(-1);
	}
	else if (pid == 0)
	{
		/* Proceso hijo: Ejecuta la primera orden. */	
		close(tuberia[0]);	// cerrar lectura
		
		// cerrar salida estándar y redirigir salida al pipe
		close(1);
		dup(tuberia[1]);
		close(tuberia[1]);
		
		if (execlp(argv[1], "orden1", NULL) == -1)
		{
			perror("error al ejecutar la primera orden");
			exit(-1);
		}
	}
	else
	{
		/* Proceso padre: Ejecuta la segunda orden */
		close(tuberia[1]);	// cerrar escritura
		
		// cerrar entrada estándar y reemplazarla por el pipe
		close(0);
		dup(tuberia[0]);
		close(tuberia[0]);
		
		if (execlp(argv[2], "orden2", NULL) == -1)
		{
			perror("error al ejecutar la segunda orden");
			exit(-1);
		}		
	}
	
	exit(0);
}