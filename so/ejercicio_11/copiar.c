#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_BUFFER 32

/*
/ Toma como argumentos un fichero fuente y uno destino. Crea un pipe y 
/ vuelca el contenido en él. Crea un proceso hijo que lanza un programa 
/ secundario que recibirá como argumento el nombre del fichero, 
/ leerá de su entrada estándar y volcará el contenido en el fichero destino.
*/

int main (int argc, char ** argv)
{	
	int tuberia[2];	// descriptores del pipe
	int pid;
	char buffer[MAX_BUFFER];
	
	if (argc != 3)
	{
		fprintf(stderr, "Uso: %s <fichero-fuente> <fichero-destino>\n", argv[0]);
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
		// cerrar entrada estándar y duplicar el pipe en su descriptor
		close(0);
		dup(tuberia[0]);
		close(tuberia[0]);
		// llamar al programa secundario
		execl("./hijo", "hijo", argv[2], NULL);
		// no debería llegarse aquí
		perror("error al lanzar programa secundario");
	}
	else
	{
		/* Proceso padre. */
		close(tuberia[0]);	// cerrar lectura
		
		// leer fichero y volcarlo en el pipe
		int fichero_fuente = open(argv[1], O_RDONLY);
		if (fichero_fuente == -1)
		{
			perror("error al abrir el fichero fuente");
			exit(-1);
		}
		
		int bytes_leidos;
		while((bytes_leidos = read(fichero_fuente, buffer, MAX_BUFFER)) > 0)
			write(tuberia[1], buffer, bytes_leidos);
		
		close(tuberia[1]);
		close(fichero_fuente);
	}
	
	exit(0);
}