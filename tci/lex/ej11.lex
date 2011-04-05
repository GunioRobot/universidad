%{
	/* TODO */
	// cargar diccionario.txt
	// int esta (char * palabra, FILE diccionario) ~
	
%}

%%

[a-zA-Z]+	{
				/* TODO */
			}

%%

#include <stdio.h>

int main ()
{
	yylex ();
	// printf ("Mayor nivel de anidamiento = %d\n", anidamiento);
	
	return 0;
}