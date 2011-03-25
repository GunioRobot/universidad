%%

package					{ }
import					{ }
class					{ }
interface				{ }
public					{ }
private					{ }
protected				{ }
if						{ }
else					{ }
while					{ }
do						{ }
for						{ }
try						{ }
catch					{ }
finally					{ }
[a-zA-Z][a-zA-Z0-9]*	{ printf ("%s\n", yytext); }

%%

#include <stdio.h>

int main ()
{
	yylex ();
	
	return 0;
}