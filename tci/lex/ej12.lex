%{
	/* TODO */
	
	char * parsea_subtitulos (char * s)
	{
		char * res;
		
		res = malloc (sizeof (char) * (int) strlen (s));
		/* TODO */
		return res;
	}
	
	void separa_tiempos (char * s, char * izq, char * der)
	{
		/* TODO */
	}
	
	char aumenta_tiempo (char * s, int seg, int miliseg)
	{
		/* TODO */
	}
	
%}

%%

[0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9]" --> "[0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9]	{ printf ("%s", parsea_subtitulos (yytext)); }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	
	return 0;
}