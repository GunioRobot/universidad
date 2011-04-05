%{
	int comentarios = 0, espacios = 0, public = 0, private = 0, tabuladores = 0;
	
	int cuenta_caracter (char * s, char c)
	{
		int i, cuenta;
		
		cuenta = 0;
		
		for (i = 0; i < strlen (s); i++)
		{
			if (s[i] == c)
				cuenta++;
		}
		
		return cuenta;
	}
%}

%%

public					{ public++; }
private					{ private++; }
"/*"(.*\n)+.*"*/"		{ 
							comentarios++; 
							espacios += cuenta_caracter (yytext, ' ');
							tabuladores += cuenta_caracter (yytext, '\t');
						}
" "						{ espacios++; }
\t						{ tabuladores++; }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	printf ("Comentarios = %d\n", comentarios);
	printf ("Espacios = %d\n", espacios);
	printf ("Public = %d\n", public);
	printf ("Private = %d\n", private);
	printf ("Tabuladores = %d\n", tabuladores);
	
	return 0;
}