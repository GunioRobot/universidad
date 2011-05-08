#include <stdio.h>
#include <stdlib.h>
#include <sys/file.h>
#include <sys/stat.h>

#define NUEVO_FICHERO "nuevo_fichero.txt"

/*
/ Sin argumentos, imprime máscara actual. Con un argumento,
/ cambia la máscara al valor dado y crea un fichero.
*/

int mask_octal(char * num)
{
	return (int) strtol(num, (char **) NULL, 8);
}

void crear_fichero(char * name)
{
	open(name, O_CREAT | O_TRUNC);
}

int main (int argc, char ** argv)
{	
	int nueva_mask;

	if (argc > 2)
	{
		fprintf(stderr, "Uso: %s <número-en-octal>\n", argv[0]);
		return;
	}
	
	if (argc == 1)
	{
		printf("máscara = %o\n", umask(0));
	}
	else 
	{
		nueva_mask = mask_octal(argv[1]);
		printf("vieja máscara = %o\n", umask(nueva_mask));
		printf("nueva máscara = %o\n", nueva_mask);
		crear_fichero(NUEVO_FICHERO);
	}
	
	return 0;
}