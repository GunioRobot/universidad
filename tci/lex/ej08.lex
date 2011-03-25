%{
	int begin = 0;
	int declaration = 0;
	int end = 0;
	
	int decimales = 0;
	int naturales = 0;
	
	int cadenas_entrecomilladas = 0;
	int identificadores = 0;
	
	int espacios = 0;
	int tabuladores = 0;
	int retornos_carro = 0;
	int caracteres = 0;
	
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

begin					{ begin++; caracteres += yyleng; }
declaration				{ declaration++; caracteres += yyleng; }
end						{ end++; caracteres += yyleng; }
[0-9]+\,[0-9]+			{ decimales++; }
[0-9]+					{ naturales++; }
\"[^\"]+\"				{ 
							cadenas_entrecomilladas++;
							espacios += cuenta_caracter (yytext, ' ');
							tabuladores += cuenta_caracter (yytext, '\t');
							retornos_carro += cuenta_caracter (yytext, '\n');
							caracteres += yyleng;
						}
[a-zA-Z][a-zA-Z0-9]*	{ identificadores++; caracteres += yyleng; }
" "						{ espacios++; caracteres++; }
\t						{ tabuladores++; caracteres++; }
\n						{ retornos_carro++; caracteres++; }
.						{ caracteres++; }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	printf ("Begin = %d\n", begin);
	printf ("Declaration = %d\n", declaration);
	printf ("End = %d\n", end);
	printf ("Decimales = %d\n", decimales);
	printf ("Naturales = %d\n", naturales);
	printf ("Cadenas entrecomilladas = %d\n", cadenas_entrecomilladas);
	printf ("Identificadores = %d\n", identificadores);
	printf ("Espacios = %d\n", espacios);
	printf ("Tabuladores = %d\n", tabuladores);
	printf ("Retornos de carro = %d\n", retornos_carro);
	printf ("Caracteres = %d\n", caracteres);
	
	return 0;
}