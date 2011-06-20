#include <stdio.h>
#include <stdlib.h>


int main (int argc, char *argv[]) 
{
	// generar el número aleatorio
	srandom(getpid());
	int aleatorio = (int) (random() % 31);
	// dormirse y terminar
	sleep(aleatorio);
	exit(aleatorio);
}

