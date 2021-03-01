NAME = cCoroutines

CC = clang
OPT = -O2
VERSION = -std=c11

FLAGS = -Wall -Wextra -Werror -pedantic -pedantic-errors -Wpedantic
WARNINGS = -Wno-pointer-sign -Wno-sign-compare
UNUSED_WARNINGS = -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wno-extra-semi
REMOVE_WARNINGS =
LIBS = 

INPUT = src/$(NAME).c #src/$(NAME)/*.c
OUTPUT = $(NAME)

#TESTFILES = ../src/$(NAME)/*.c
TESTINPUT = $(NAME).spec.c
TESTOUTPUT = spec_results

all: default

default:
	$(CC) $(OPT) $(VERSION) $(FLAGS) $(WARNINGS) $(REMOVE_WARNINGS) $(UNUSED_WARNINGS) $(LIBS) -o $(OUTPUT) $(INPUT)
	$(RM) -r export && mkdir export && mkdir export/$(NAME) && mkdir export/$(NAME)/headers
	#cp src/$(NAME)/headers/* export/$(NAME)/headers/
	#cp src/$(NAME).h export/
	mv $(OUTPUT) export/$(OUTPUT).app

lib: default

test:
	cd spec && $(CC) $(OPT) $(VERSION) $(HEADERS) $(FLAGS) $(WARNINGS) $(REMOVE_WARNINGS) $(UNUSED_WARNINGS) $(LIBS) -o $(TESTOUTPUT) $(TESTFILES) $(TESTINPUT)
	@echo
	./spec/$(TESTOUTPUT)

spec: test

clean:
	$(RM) -r spec/$(TESTOUTPUT)
	$(RM) -r export
