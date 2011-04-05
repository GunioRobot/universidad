%{
int caracteres = 0, lineas = 1, palabras = 0;
%}

%%

[^ \t\n]+	{ caracteres += yyleng; palabras++; }
[ \t]		{ caracteres++; }
\n			{ caracteres++; lineas++; }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	printf ("Lineas: %d\nPalabras: %d\nCaracteres:%d\n", lineas, palabras, caracteres);
	
	return 0;
}