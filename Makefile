CC=g++
STD=-std=c++1z
CFLAGS=-Wall -g
LINKS=-lglfw

PATHINCLUDE=./include/headers
PATHSRC=./src/
PATHOBJ=./obj/

SRCSUFFIX=.cpp

OUTPUT=Game


SOURCES=$(shell find $(PATHSRC) -name *$(SRCSUFFIX))

OBJECTS=$(patsubst $(PATHSRC)%$(SRCSUFFIX),$(PATHOBJ)%.o,$(SOURCES))

COMPILE=$(CC) $(CFLAGS) $(STD)

all: $(OUTPUT)

$(OUTPUT): $(OBJECTS) obj/glad/glad.o
	$(COMPILE) -o $@ $^ $(LINKS)

$(PATHOBJ)%.o: $(PATHSRC)%$(SRCSUFFIX)
	mkdir -p $(dir $@)
	$(COMPILE) -I$(PATHINCLUDE) -c $< -o $@ 

obj/glad/glad.o: src/glad/glad.c
	mkdir -p obj/glad 
	gcc -I $(PATHINCLUDE) -c src/glad/glad.c -o obj/glad/glad.o

clean:
	rm -rf $(PATHOBJ)*
	rm $(OUTPUT)

.PHONY: all clean
