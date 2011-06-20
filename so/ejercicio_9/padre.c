#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main (int argc, char ** argv)
{	
	int estado, i, pid;
	
	if (argc != 2)
	{
		fprintf(stderr, "Uso: %s <número-hijos>\n", argv[0]);
		exit(-1);
	}

	for (i = 0; i < atoi(argv[1]); ++i) 
	{
		pid = fork();
		if (pid == -1) 
		{
			perror("Error en creación del hijo");
			exit(-2);
		}
		else if (pid == 0) 
		{
			/* hijo */
			printf("[hijo %d] : comenzando su ejecución.\n", getpid());
			execl("./hijo", "etiqueta", NULL);
		} 
	}
	
	if (pid > 0) 
	{ 
		/* padre */
		for (i = 0; i < atoi(argv[1]); ++i) 
		{
			pid = wait(&estado);
			if (pid == -1) 
				printf("Error en la terminación de un hijo.\n");
			else
				printf("[hijo: %d] Espera de %d segundos. Terminado.\n", 
							pid, WEXITSTATUS(estado));
		}
	}

	exit(0);
}