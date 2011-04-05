%{
	void invertir (char * cadena, int longitud)
	{
		int i;
		
		for (i = longitud; i >= 0; --i)
			printf ("%c", cadena[i]);
			
	}
%}

%%

[^ \t\n]+	{ invertir (yytext, yyleng); }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	
	return 0;
}