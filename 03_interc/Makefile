C_SOURCE = simd_sum.c
C_LIBRARY = libsimd_sum.dylib
COBOL_SOURCE = call_c_func.cbl
COBOL_EXECUTABLE = simd_caller

C_COMPILER = clang
CFLAGS = -shared -fPIC -mavx -o
COBOL_COMPILER = cobc
COBOL_COMPILE_FLAGS = -x -o
COBOL_FLAGS = -v -free

all: $(C_LIBRARY) $(COBOL_EXECUTABLE)

c_library: $(C_LIBRARY)

$(C_LIBRARY): $(C_SOURCE)
	$(C_COMPILER) $(CFLAGS) $(C_LIBRARY) $(C_SOURCE)

$(COBOL_EXECUTABLE): $(COBOL_SOURCE) $(C_LIBRARY)
	$(COBOL_COMPILER) $(COBOL_FLAGS) $(COBOL_COMPILE_FLAGS) $(COBOL_EXECUTABLE) $(COBOL_SOURCE) -L. -lsimd_sum

clean:
	rm -f $(C_LIBRARY) $(COBOL_EXECUTABLE) *.o

.PHONY: all clean c_library
