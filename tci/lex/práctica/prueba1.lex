%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	typedef struct
	{
		char * cadena;
		void * sig;
	} nodo;

	typedef nodo * lista;
	
	int asignaciones = 0;
	int num_if_y_switch = 0;
	int num_while = 0;
	int num_for = 0;
	int num_system_out_print = 0;
	lista lista_cadenas = NULL;
	lista lista_o_identificadores = NULL;
	
	void insertar_lista (lista * l, char * v)
	{
		nodo *i, *nuevo;
		
		nuevo = malloc (sizeof (nodo));
		
		if (nuevo == NULL)
		  {
			fprintf (stderr, "Error al reservar memoria.\n");
			exit(1);
		  }
		else
		  {
			nuevo->cadena = malloc (sizeof (char) * (int) strlen (v));
			strcpy (nuevo->cadena, v);
			nuevo->sig = NULL;
		  }
		  
		i = *l;
		  
		if (es_vacia (i))
			*l = nuevo;
		else
		  {
			while (i->sig != NULL)
				i = i->sig;
			
			i->sig = nuevo;
		  }
	}
	
	int igual (char * s, char * d)
	{
		if (strcmp (s, d) == 0)
			return 1;
		else
			return 0;
	}
	
	int mayor (char * s, char * d)
	{
		if (strcmp (s, d) > 0)
			return 1;
		else
			return 0;
	}
	
	int menor (char * s, char * d)
	{
		if (strcmp (s, d) < 0)
			return 1;
		else
			return 0;
	}
	
	int esta (lista l, char * v)
	{
		nodo *i;
		
		i = (nodo *) l;
		
		if (es_vacia (l))
			return 0;
		else
			return (igual (v, i->cadena) || esta (i->sig, v));
	}
	
	void insertar_lista_o (lista * l, char * v)
	{
		nodo *adelantado, *i, *nuevo;
		
		// evitar repeticiones
		if (esta (*l, v))
			return;
		
		nuevo = malloc (sizeof (nodo));
		
		if (nuevo == NULL)
		  {
			fprintf (stderr, "Error al reservar memoria.\n");
			return;
		  }
		else
		  {
			nuevo->cadena = malloc (sizeof (char) * (int) strlen (v));
			strcpy (nuevo->cadena, v);
			nuevo->sig = NULL;
		  }
		  
		i = *l;
		  
		if (es_vacia (i))
			*l = nuevo;
		else if (mayor (i->cadena, v))
		  {
			nuevo->sig = *l;
			*l = nuevo;
			return;
		  }
		else
		  {
			adelantado = i->sig;
			
			while (adelantado != NULL && menor (adelantado->cadena, v))
			  {
				i = adelantado;
				adelantado = adelantado->sig;
			  }
			  
			nuevo->sig = adelantado;
			i->sig = nuevo;
		  }
	}
	
	void eliminar_ultimo (lista * l)
	{
		nodo *adelantado, *i;
		
		i = *l;
		
		if (es_vacia (i))
			return;
		else if (i->sig == NULL)
		  {
			free (i);
			*l = NULL;
			return;
		  }
		  
		adelantado = i->sig;
		
		while (adelantado->sig != NULL)
		  {
			i = adelantado;
			adelantado = adelantado->sig;
		  }
		  
		free (adelantado);
		i->sig = NULL;
	}
	
	void liberar_lista (lista * l)
	{
		while (!es_vacia (*l))
			eliminar_ultimo (l);
	}
	
	void imprimir_lista (const lista l)
	{
		nodo *i;
		
		if (!es_vacia (l))
		  {
		    i = (nodo *) l;
		  	printf ("%s\n", i->cadena);
		  	imprimir_lista (i->sig);
		  }
	}
	
	int es_vacia (const lista l)
	{
		if (l == NULL)
			return 1;
		else	
			return 0;
	}
	
	int longitud_lista (const lista l)
	{
		int longitud = 0;
		nodo *i;
		
		i = l;
		
		while (i != NULL)
		  {
			i = i->sig;
			++longitud;
		  }
	
		return longitud;
	}
	
	void imprimir_resultados ()
	{
		printf ("asignaciones encontradas: %d\n", asignaciones);
		printf ("sentencias if y switch: %d\n", num_if_y_switch);
		printf ("sentencias while: %d\n", num_while);
		printf ("sentencias for: %d\n", num_for);
		printf ("identificadores:\n");
		imprimir_lista (lista_o_identificadores);
		printf ("cadenas:\n");
		imprimir_lista (lista_cadenas);
		printf("System.out.print: %d\n", num_system_out_print);
	}
%}

%%

abstract
assert
boolean
break
byte
case
catch
char
class
const
continue
default
do
double
else
enum
extends
false
final
finally
float
goto
implements
import
instanceof
int
interface
long
native
new 
null
package
private
protected
public
return
short
static
strictfp
super
synchronized
this
throw
throws
transient
true
try 
void
volatile
"/*"(.*\n)+.*"*/"		
"//"(.*\n)				
[^=]=[^=]				{ asignaciones++; }
if						{ num_if_y_switch++; }
switch					{ num_if_y_switch++; }
while					{ num_while++; }
for						{ num_for++; }
System.out.print		{ num_system_out_print++; }
System.out.println		{ num_system_out_print++; }
\"([^\"\\]|(\\.))*\"	{ insertar_lista (&lista_cadenas, yytext); }
[a-zA-Z][a-zA-Z0-9]*	{ insertar_lista_o (&lista_o_identificadores, yytext); }
.|\n					

%%
int main ()
{
	yylex ();
	imprimir_resultados ();
	liberar_lista (&lista_cadenas);
	liberar_lista (&lista_o_identificadores);
	
	return 0;
}