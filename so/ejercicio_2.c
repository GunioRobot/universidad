#include <stdio.h>
#include <stdlib.h>
#include <sys/file.h>
#include <sys/stat.h>

/*
/ Mueve el fichero especificado en el primer parámetro
/ a la posición indicada por el segundo.
*/

int main (int argc, char ** argv)
{	
	if (argc != 3)
	{
		printf("Uso: ejercicio1 <número-en-octal>\n");
		return;
	}
	
	char * origen = argv[1];
	char * destino = argv[2];
	
	if (link(origen, destino) == -1)
		fprintf(stderr, "Ha habido un error, %s debe existir.\n", origen);
	
	return 0;
}