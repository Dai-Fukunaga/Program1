%{
/* Text in %{ %} (which must appear on their own lines) is also copied
 * verbatim to the output.  Here is where we might #include necessary
 * header files, unless we also want them to affect flex's boilerplate.
*/
#include <iostream>
#include <string>
#include <set>

/* Needed for C++, not C */
#define YY_DECL extern "C" int yylex()

/* Use a namespace called std */
using namespace std;

/* It is important that none of these enumerators are zero, since yylex()
 * returns 0 to indicate the end of input.  You could use const ints or
 * #defines instead.
*/
enum Token {
    INTEGER = 1,
    NUMBER,
    CHARACTER,
    STRING,
    /* keywords */
    IF, ELSE, WHILE, DO, FOR,
    INT, FLOAT, CHAR, VOID,
    RETURN,
    STRUCT,
    /* operations */
    ASSIGNMENT, PLUS, MINUS, TIMES, DIVIDE, MODULO,
    EQUAL, NEQUAL,
    GREATER, GEQUAL,
    LESS, LEQUAL,
    AND, OR,
    /* punctuations */
    COMMA, PERIOD, SEMICOLON,
    LPAREN, RPAREN,
    LCURLY, RCURLY,
    LSQUARE, RSQUARE,
    IDENTIFIER,
};
%}

/* Options.  Specifically, don't generate the yyunput() function: Since we
 * don't use it, we'd get a -Wall warning about an unused static function.
 */
%option nounput

/* state identifier for comments, especially for \/\* \*\/ type comment.
 * it is exclusive start conditions
*/
%x COMMENTS

/* Define named patterns. */
ALPHA [a-zA-Z]
NONZERO [1-9]
DIGIT [0-9]
INTEGER [\+-]?({DIGIT}+)
EXPONENT ([eE][\+-]?{DIGIT}+)
NUMBER [\+-]?({DIGIT}+(\.{DIGIT}*)?|\.{DIGIT}+){EXPONENT}?
WSPACE [ \t\n\r]+
IDENTIFIER (_|{ALPHA})(_|{ALPHA}|{DIGIT})*
CHARACTER (\'({ALPHA}|{DIGIT}|,|\.|\(|\)|\{|\}|\[|\]|\ |=|\+|\-|\*|\/|_|%|;|:|\||~|\^|@|<|>|\?|!|#|$|&|\"|\\\\|\\\')\')
STRING (\"({ALPHA}|{DIGIT}|,|\.|\(|\)|\{|\}|\[|\]|\ |=|\+|\-|\*|\/|_|%|;|:|\||~|\^|@|<|>|\?|!|#|$|&|\'|\\\\|\\\")*\")
COMMENT (\/\/(.*))

%%

{COMMENT} {} /* escape "//" type comment */

"if" { /* catch all keywords below */
    return IF;
}

"else" {
    return ELSE;
}

"while" {
    return WHILE;
}

"do" {
    return DO;
}

"for" {
    return FOR;
}

"int" {
    return INT;
}

"float" {
    return FLOAT;
}

"char" {
    return CHAR;
}

"void" {
    return VOID;
}

"return" {
    return RETURN;
}

"struct" {
    return STRUCT;
}

"=" { /* catch all operators below */
    return ASSIGNMENT;
}

"+" {
    return PLUS;
}

"-" {
    return MINUS;
}

"*" {
    return TIMES;
}

"/" {
    return DIVIDE;
}

"%" {
    return MODULO;
}

"==" {
    return EQUAL;
}

"!=" {
    return NEQUAL;
}

">" {
    return GREATER;
}

">=" {
    return GEQUAL;
}

"<" {
    return LESS;
}

"<=" {
    return LEQUAL;
}

"&&" {
    return AND;
}

"||" {
    return OR;
}

"," { /* catch all puctuations below*/
    return COMMA;
}

"." {
    return PERIOD;
}

";" {
    return SEMICOLON;
}

"(" {
    return LPAREN;
}

")" {
    return RPAREN;
}

"{" {
    return LCURLY;
}

"}" {
    return RCURLY;
}

"[" {
    return LSQUARE;
}

"]" {
    return RSQUARE;
}

{INTEGER}  { /* catch all integers */
    return INTEGER;
}

{NUMBER} { /* catch all numbers except integers */
    return NUMBER;
}

{CHARACTER} { /* catch all characters */
    return CHARACTER;
}

{STRING} { /* catch all strings */
    return STRING;
}

{IDENTIFIER} { /* catch all identifiers */
    return IDENTIFIER;
}

{WSPACE} { }  /* skip whitespace entirely */

. {        /* Anything else.  Must be the last rule! */
    std::cerr << "Unrecognized character: " << yytext << "\n";
}


"/*" BEGIN(COMMENTS); yymore(); /* escape "\/\*\*\/" type comment */
<COMMENTS>"*/" BEGIN(INITIAL);
<COMMENTS>"*" yymore();
<COMMENTS>[^*]+ yymore();

%%

/*******************
 * User code section. Copied verbatim.
 */
string token_name(int tok) {
    // return the token name
    switch(tok) {
        case INTEGER: return "INTEGER"; break;
        case NUMBER: return "DOUBLE";   break;
        case CHARACTER: return "CHARACTER"; break;
        case STRING: return "STRING"; break;
        case IF : return "IF"; break;
        case ELSE: return "ELSE"; break;
        case WHILE: return "WHILE"; break;
        case DO: return "DO"; break;
        case FOR: return "FOR"; break;
        case INT: return "INT"; break;
        case FLOAT: return "FLOAT"; break;
        case CHAR: return "CHAR"; break;
        case VOID: return "VOID"; break;
        case RETURN: return "RETURN"; break;
        case STRUCT: return "STRUCT"; break;
        case ASSIGNMENT: return "ASSIGNMENT"; break;
        case PLUS: return "PLUS"; break;
        case MINUS: return "MINUS"; break;
        case TIMES: return "TIMES"; break;
        case DIVIDE: return "DIVIDE"; break;
        case MODULO: return "MODULO"; break;
        case EQUAL: return "EQUAL"; break;
        case NEQUAL: return "NEQUAL"; break;
        case GREATER: return "GREATER"; break;
        case GEQUAL: return "GEQUAL"; break;
        case LESS: return "LESS"; break;
        case LEQUAL: return "LEQUAL"; break;
        case AND: return "AND"; break;
        case OR: return "OR"; break;
        case COMMA: return "COMMA"; break;
        case PERIOD: return "PERIOD"; break;
        case SEMICOLON: return "SEMICOLON"; break;
        case LPAREN: return "LPAREN"; break;
        case RPAREN: return "RPAREN"; break;
        case LCURLY: return "LCURLY"; break;
        case RCURLY: return "RCURLY"; break;
        case LSQUARE: return "LSQUARE"; break;
        case RSQUARE: return "RSQUARE"; break;
        case IDENTIFIER: return "IDENTIFIER"; break;
        default: return "????";    break;
    }
}

int main(int argc, char** argv) {
    int token = 0;
    // save a token name
    string name = "";

    // to catch all keywords, operators, and punctuations
    set<string> keywords = {"IF", "ELSE", "WHILE", "DO", "FOR", "INT", "FLOAT", "CHAR", "VOID", "RETURN", "STRUCT"};
    set<string> operators = {"ASSIGNMENT", "PLUS", "MINUS", "TIMES", "DIVIDE", "MODULO", "EQUAL", "NEQUAL", "GREATER", "GEQUAL", "LESS", "LEQUAL", "AND", "OR"};
    set<string> punctuations = {"COMMA", "PERIOD", "SEMICOLON", "LPAREN", "RPAREN", "LCURLY", "RCURLY", "LSQUARE", "RSQUARE"};

    // when there are no command line arguments
    if (argc == 1) {
        // The usual way of calling the lexer in a loop, when the lexer uses "return".
        while ((token = yylex()) != 0) {
            name = token_name(token);
            if (keywords.find(name) != keywords.end() || operators.find(name) != operators.end() || punctuations.find(name) != punctuations.end()) {
                // if yytext is KEYWORDS, OPERATORS, and PUCTUATION
                cout << yytext << endl;
            } else if (name == "INTEGER") {
                // if yytext is INTEGER
                cout << name << ": " << atoi(yytext) << endl;
            } else if (name == "DOUBLE") {
                // if yytext is FLOAT
                cout << name << ": " << atof(yytext) << endl;
            }else {
                // otherwise
                cout << name << ": " << yytext << endl;
            }
        }
        cout << "End of input." << endl;
    } else if (argc == 2) { // when there is exactly one comannd line argument
        // check if the input file can be opened successfully
        FILE *in_file = fopen(argv[1], "r");
        if (in_file == NULL) { // when the file cannot be opened
            cout << "Warning: cannot open the file named " << argv[1] << "!" << endl;
            return 1;
        }

        // print all lexical analyzer results
        yyin = in_file;
        while ((token = yylex()) != 0) {
            name = token_name(token);
            if (keywords.find(name) != keywords.end() || operators.find(name) != operators.end() || punctuations.find(name) != punctuations.end()) {
                // if yytext is KEYWORDS, OPERATORS, and PUCTUATION
                cout << yytext << endl;
            } else if (name == "INTEGER") {
                // if yytext is INTEGER
                cout << name << ": " << atoi(yytext) << endl;
            } else if (name == "DOUBLE") {
                // if yytext is FLOAT
                cout << name << ": " << atof(yytext) << endl;
            }else {
                // otherwise
                cout << name << ": " << yytext << endl;
            }
        }
        cout << "End of the file" << endl;
    } else { // when there are more than 2 command line arguments
        cout << "Too many command line arguments" << endl;
        return 2;
    }

    /* Free memory.  Not usually needed, but the assignment asks for
     * no memory leaks!
     */
    yylex_destroy();
    return 0;
}
