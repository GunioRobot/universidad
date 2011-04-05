# Makefile para ejercicios en lex

# Lex
L = lex

# Compilador 
CC = gcc
CFLAGS = -lfl

# Ejercicios a compilar
ejercicios = ej01 ej02 ej03 ej04 ej05 ej06 ej07 ej08 ej09 ej10 ej11 ej12

.PHONY: all limpiar

all:	$(ejercicios)

# Generar archivos .c con el mismo nombre que los .lex
%.c:		%.lex
		$(L) -o $@ $<

# Generar archivos .o con el mismo nombre que los .c
%.o:		%.c
		$(CC) -c -o $@ $<

#Generar ejecutable
%:			%.o
		$(CC) -o $@ $< $(CFLAGS)
		
limpiar:
		rm *.c *.o $(ejercicios)