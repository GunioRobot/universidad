#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_MENSAJE 32

/*
/ Comunicación de dos procesos mediante un pipe. Se crea un proceso hijo
/ que lee de un pipe que ha creado el padre hasta que no haya nada más
/ que leer y va mostrando por pantalla lo leído.
*/

int main (int argc, char ** argv)
{	
	int tuberia[2];	// descriptores del pipe
	int pid;
	char buffer[MAX_MENSAJE];
	
	if (argc != 1)
	{
		fprintf(stderr, "Uso: %s\n", argv[0]);
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
		perror("error al crear el proceso hijo");
		exit(-1);
	}
	else if (pid == 0)
	{
		/* Proceso hijo. */
		close(tuberia[1]);	// cerrar escritura
		
		while (read(tuberia[0], buffer, MAX_MENSAJE) > 0)
			write(1, buffer, MAX_MENSAJE);	// escribir en salida estándar
		
		close(tuberia[0]);
	}
	else
	{
		/* Proceso padre. */
		close(tuberia[0]);	// cerrar lectura
		
		fgets(buffer, MAX_MENSAJE, stdin);	// leemos de la entrada estándar
		while(strcmp(buffer, "FIN\n") != 0)
		{
			write(tuberia[1], buffer, MAX_MENSAJE);
			fgets(buffer, MAX_MENSAJE, stdin);
		}
		
		close(tuberia[1]);
	}
	
	exit(0);
}