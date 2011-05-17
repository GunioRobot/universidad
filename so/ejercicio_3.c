#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

/*
/ Programa equivalente a la orden chmod.
*/

mode_t a_modo(char * num)
{
	return (mode_t) strtol(num, (char **) NULL, 8);
}

int main (int argc, char ** argv)
{	
	if (argc != 3)
	{
		fprintf(stderr, "Uso: %s <número-en-octal> <fichero>\n", argv[0]);
		exit(-1);
	}
	
	mode_t modo = a_modo(argv[1]);
	char * fichero = argv[2];
	
	if (chmod(fichero, modo) == -1)
		fprintf(stderr, "Ha habido un error, %s debe existir.\n", fichero);
	
	exit(0);
}