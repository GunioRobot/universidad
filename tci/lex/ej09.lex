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
[a-zA-Z][a-zA-Z0-9]*	{ printf ("%s\n", yytext); }
.|\n					{ }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	
	return 0;
}