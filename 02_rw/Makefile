MODULES = user_input_handler fs_writer
MAIN_PROGRAM = write_to_fs_from_stdin

COBOL_COMPILER = cobc
LIBTOOL = libtool
COBOL_COMPILE_FLAGS = -c  # Compile only for object files
COBOL_FLAGS = -v -free  # Universal flags

CC = clang
CFLAGS = -dynamiclib -lcob

OBJECT_FILES = $(MODULES:=.o)
DYLIB_FILES = $(MODULES:%=lib%.dylib)

all: modules main

modules: $(DYLIB_FILES)

lib%.dylib: %.o
	$(CC) $(CFLAGS) -o $@ $<

%.o: %.cbl
	$(COBOL_COMPILER) $(COBOL_FLAGS) $(COBOL_COMPILE_FLAGS) $<

main: $(MAIN_PROGRAM).cbl $(DYLIB_FILES)
	$(COBOL_COMPILER) -x -o $(MAIN_PROGRAM) $(MAIN_PROGRAM).cbl -L. $(DYLIB_FILES:lib%.dylib=-l%)

clean:
	rm -f *.o *.dylib $(MAIN_PROGRAM)

.PHONY: all modules main clean
