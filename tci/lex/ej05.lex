%{
	int multiplos_cuatro = 0;
%}

%%

[0-9]*(0|2|4|6|8)(0|4|8)		{ multiplos_cuatro++; }
[0-9]*(1|3|5|7|9)(2|6)			{ multiplos_cuatro++; }
[^0-9](0|4|8)[^0-9]				{ multiplos_cuatro++; }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	printf ("Múltiplos de cuatro encontrados = %d\n", multiplos_cuatro);
	
	return 0;
}