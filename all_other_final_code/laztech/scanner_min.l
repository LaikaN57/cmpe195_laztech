%option noyywrap
%option 8bit

%{

#define YY_BUF_SIZE 1024

%}

%%

  /* General Graphics State */
"w" { } // line width
"J" { } // line cap style
"j" { } // line join style
"M" { } // miter limit
"d" { } // line dash pattern
"gs" { } // EXTERNAL GRAPHICS STATE

  /* Special Graphics State */
"q" { } // push gfx state
"Q" { } // pop gfx state
"cm" { } // modify ctm

  /* Path Construction */
"m" { } // move
"l" { } // line
"c" { } // curve
"h" { } // close
"re" { } // rectangle

  /* Path Painting */
"S" { } // Stroke
"B*" { } // [fill (even-odd) and] Stroke

  /* Color */
"RG" { } // fg
"rg" { } // bg

  /* Number */
(\+|-)?(([[:digit:]]*\.[[:digit:]]+)|([[:digit:]]+\.?)) { }

  /* PDF Array */
\[(.*?)\] { }

  /* PDF Name */
\/[^[:space:]]* { }

  /* Whitespace */
[[:space:]] { }

  /* Save time and eliminate pop/push */
Q[[:space:]]q { }

  /* Other */
. { printf("Unknown char '%s'.\n", yytext); }

%%

int main() {
  while(1) {
//------------------------------------------------------

    switch(state) {
      case start:
        while(start_not_found) uart_getchar();
        state = uart_in;
        break;
      case uart_in:
        while(in_len < in_cap) {
          if(end_found) flush();

          in[in_len] = uart_getchar();

          if(timeout) {
            break;
          }

          in_len++;
        }

        if(in_len) {
          // zlib();
          // yylex();
          in_len = 0;
        }
        break;
    }

//-------------------------------------------------------
  }
}

