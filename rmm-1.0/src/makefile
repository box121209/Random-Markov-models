# Makefile for rmm v1.0
# box121209, May 2013

# Compiler:
CC 	= gcc
CFLAGS 	= -Wall -pedantic -O3

# R binary:
R	= R

# Directories:
SRC	= .
LIB	= .
#LIB	= ../libs/x86_64

# targets:
all: rmm

rmm:
	$(R) CMD SHLIB $(CFLAGS) -o $(LIB)/rmm.so $(SRC)/rmm.c
	@ make clean

# clean up:
.PHONY: clean
clean:
	@ rm *.o
