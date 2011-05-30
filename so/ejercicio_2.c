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
		fprintf(stderr, "Uso: %s <fichero-origen> <fichero-destino>\n", argv[0]);
		exit(-1);
	}
	
	char * origen = argv[1];
	char * destino = argv[2];
	
	if (link(origen, destino) == -1) {
		fprintf(stderr, "Ha habido un error al mover %s en %s.\n", origen, destino);
		exit(-2);
	}
	if (unlink(origen) == -1) {
		fprintf(stderr, "Ha habido un error al intentar borrar %s\n", origen);
		exit(-3);
	}
	
	return 0;
}