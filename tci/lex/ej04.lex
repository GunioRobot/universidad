%{
	int multiplos_dos = 0;
%}

%%

[0-9]*(0|2|4|6|8)	{ multiplos_dos++; }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	printf ("Múltiplos de dos encontrados = %d\n", multiplos_dos);
	
	return 0;
}