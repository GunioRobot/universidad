%{
	typedef struct
	{
		char * cadena;
		void * sig;
	} nodo;

	typedef nodo * lista;
	
	void insertar_lista (lista * l, char * v)
	{
		nodo *i, *nuevo;
		
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
		else
		  {
			while (i->sig != NULL)
				i = i->sig;
			
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
	
	int vacia (const lista l)
	{
		if (l == NULL)
			return 1;
			
		return 0;
	}
	
	void ver_lista (const lista l)
	{
		nodo *i;
		int num;
		
		i = l;
		
		if (es_vacia (i))
			fprintf (stdout, "vacia\n");
			
		num = 0;
		
		while (i != NULL)
		  {
			fprintf (stdout, "%d.  %s\n", num, i->cadena);
			i = i->sig;
			++num;
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
	
	lista li = NULL;
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
for  
goto  
if  
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
switch  
synchronized  
this  
throw  
throws  
transient  
true  
try  
void  
volatile  
while  
[a-zA-Z][a-zA-Z0-9]*	{ insertar_lista (&li, yytext); }
.|\n					{ }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	
	ver_lista (li);
	liberar_lista (&li);
	
	return 0;
}