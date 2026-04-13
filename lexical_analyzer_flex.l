%{
#include <stdio.h>
int line = 1;
%}


IDENTIFIER [A-Za-z][A-Za-z0-9_]*
INTEGER    0|[1-9][0-9]*
FLOAT      {INTEGER}\.[0-9]+([eE][+-]?[0-9]+)?
STRING     \"([^\"\\\n]|\\[ntr\"\\])*\"

%%

 /*___________ KEYWORDS _____________*/
 
[ \t\r]+     /*ignore*/
\n 	     {++line;}
"--".*       /*ignore comment until the end of line*/

"int"        { printf("INT_TYPE\n"); }
"real"       { printf("REAL_TYPE\n"); }
"text"       { printf("TEXT_TYPE\n"); }
"bool"       { printf("BOOL_TYPE\n"); }

"True"       { printf("TRUE\n"); }
"False"      { printf("FALSE\n"); }

"const"      { printf("CONST\n"); }

"if"         { printf("IF\n"); }
"else"       { printf("ELSE\n"); }
"fi"         { printf("FI\n"); }

"for"        { printf("FOR\n"); }
"in"         { printf("IN\n"); }
"rof"        { printf("ROF\n"); }

"while"      { printf("WHILE\n"); }
"od"         { printf("OD\n"); }

"break"      { printf("BREAK\n"); }
"continue"   { printf("CONTINUE\n"); }

"not"        { printf("NOT\n"); }
"and"        { printf("AND\n"); }
"or"         { printf("OR\n"); }

"fun"        { printf("FUN\n"); }
"nuf"        { printf("NUF\n"); }

"main"       { printf("MAIN\n"); }
"return"     { printf("RETURN\n"); }

"record"     { printf("RECORD\n"); }
"drocer"     { printf("DROCER\n"); }

"of"         { printf("OF\n"); }

 /* __________________________________
  _____________ OPERATORS _____________ */

       /* multi-character FIRST */
       
"**"   { printf("POW\n"); }

"=="   { printf("EQ\n"); }
"!="   { printf("NEQ\n"); }
"<="   { printf("LEQ\n"); }
">="   { printf("GEQ\n"); }

"+="   { printf("PLUS_ASSIGN\n"); }
"-="   { printf("MINUS_ASSIGN\n"); }
"*="   { printf("MUL_ASSIGN\n"); }
"/="   { printf("DIV_ASSIGN\n"); }
"%="   { printf("MOD_ASSIGN\n"); }

"<-"   { printf("ASSIGN_ARROW\n"); }

     /* single-character AFTER */
 
"+"    { printf("PLUS\n"); }
"-"    { printf("MINUS\n"); }
"*"    { printf("MUL\n"); }
"/"    { printf("DIV\n"); }
"%"    { printf("MOD\n"); }

"="    { printf("ASSIGN\n"); }

"<"    { printf("LT\n"); }
">"    { printf("GT\n"); }

 /*___________________________________________*/
 /* first match wins flex rule */

{STRING} { printf("STRING %s\n", yytext); }

{FLOAT}	     { printf("FLOAT %s\n", yytext);} 
{INTEGER}    { printf("INTEGER %s\n", yytext);}

{IDENTIFIER} { printf("IDENTIFIER %s\n", yytext);} 

 /*____________________________________________
   ELSE                                        */
   
. { printf("Unrecognized character in line %d {%s}",line,yytext);}

%%


int main()
{ yylex(); }
