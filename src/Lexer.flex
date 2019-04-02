%option noyywrap

%{
  #include <stdio.h>
  #include <iostream>

extern "C" int fileno(FILE *stream);
#define SAVE_TOKEN yylval.string = new

void yyerror (char const *s);
%}

LETTERS        [\xd8a1-\xd98a\xd991]
DIAC           [\xd98b-\xd990\xd992\xd993]
DIGIT					 [٠١٢٣٤٥٦٧٨٩]
LATIN					 [a-zA-Z_]
LATINDIG			 [0-9]

%%
[ \n\t]                  {;}
"//".*             {;}

"("						 {return T_LBRACKET;}
")"						 {return T_RBRACKET;}
"{"						 {return T_LBRACE;}
"}"						 {return T_RBRACE;}
"["						 {return T_LINDEX;}
"]"						 {return T_RINDEX;}

"auto"					 {return TK_auto;}
"break"					 {return TK_break;}
"case"					 {return TK_case;}
"char"					 {return TK_char;}
"const"					 {return TK_const;}
"continue"				 {return TK_continue;}
"default"				 {return TK_default;}
"do"					 {return TK_do;}
"double"				 {return TK_double;}
"else"					 {return TK_else;}
"enum"					 {return TK_enum;}
"extern"				 {return TK_extern;}
"float"					 {return TK_float;}
"for"					 {return TK_for;}
"goto"					 {return TK_goto;}
"if"					 {return TK_if;}
"int"					 {return TK_int;}
"long"					 {return TK_long;}
"register"				 {return TK_register;}
"return"				 {return TK_return;}
"short"					 {return TK_short;}
"signed"				 {return TK_signed;}
"sizeof"				 {return TK_sizeof;}
"static"				 {return TK_static;}
"struct"				 {return TK_struct;}
"switch"				 {return TK_switch;}
"typedef"				 {return TK_typedef;}
"union"					 {return TK_union;}
"unsigned"				 {return TK_unsigned;}
"void"					 {return TK_void;}
"volatile"				 {return TK_volatile;}
"while"					 {return TK_while;}

\"(\\.|[^\\"])*\"		 {return T_StringLiteral;}
[L]\"(\\.|[^\\"])*\"	 {return T_LStringLiteral;}

"->"					 {return TO_memberAccess;}
"!"						 {return TO_not;}
"?"            {return TO_questionMark;}
"^"            {return TO_exclussiveOr;}
"="            {return TO_equal;}
"~"						 {return TO_bitwiseNot;}
"&"						 {return TO_ampersand;}
"&&"					 {return TO_logicAnd;}
"||"           {return TO_logicOr;}
"*"						 {return TO_asterix;}
"%"						 {return TO_mod;}
"|"            {return TO_OR;}
"<<"					 {return TO_bitwiseLeft;}
">>"					 {return TO_bitwiseRight;}
"<"						 {return TO_lessThan;}
"<="					 {return TO_lessThanOrEqual;}
">"						 {return TO_moreThan;}
">="					 {return TO_moreThanOrEqual;}
"=="					 {return TO_equalTo;}
"*="           {return TO_multEqual;}
"/="           {return TO_divEqual;}
"%="           {return TO_modEqual;}
"+="           {return TO_plusEqual;}
"-="           {return TO_minusEqual;}
"<<="           {return TO_leftEqual;}
">>="           {return TO_rightEqual;}
"&="           {return TO_andEqual;}
"^="           {return TO_exOrEqual;}
"|="           {return TO_OrEqual;}
"!="					 {return TO_notEqualTo;}
"+"						 {return TO_plus;}
"-"						 {return TO_minus;}
"/"            {return TO_divide;}
"++"					 {return TO_increment;}
"--"					 {return TO_decrement;}

","						 {return TP_comma;}
"."						 {return T_dot;}
":"						 {return TP_colon;}
";"						 {return TP_semiColon;}

[1-9][0-9]*(({USS}?{LGS}?)|({LGS}?{USS}?))				   {yylval.Integer=strtod(yytext, 0); return TC_integer; /*to be changes later */}
[0-9][0-9]*(({USS}?{LGS}?)|({LGS}?{USS}?))				   {yylval.Integer=std::stoi( yytext, 0, 8  ); return TC_integer; /*to be changes later */}
[0][xX]{HEX}+(({USS}?{LGS}?)|({LGS}?{USS}?))				   {yylval.Integer=std::stoi( yytext, 0, 8  ); return TC_integer;}
({DIGIT})*"."({DIGIT})+([eE]("+"|"-")?{DIGIT}+)?[flFL]?  {yylval.Float = strtof(yytext, NULL); return TC_float;}

"true"					 {return TC_true;}
"false"					 {return TC_false;}
"NULL"					 {return TC_NULL;}
"nullptr"				 {return TC_nullptr;}

{ID}({DIGIT}|{ID})*			 {yylval.word = new std::string(yytext); return T_IDENTIFIER;}

.                 {;}

%%

 void yyerror (char const *s) {
   fprintf (stderr, "Parse Error: %s\n", s);
 }