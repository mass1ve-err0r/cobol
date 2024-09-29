COBOL_COMPILER = cobc
COBOL_FLAGS = -v -free -x

# Source file
SRC = main.cbl

# Target executable
TARGET = cxx

all: $(TARGET)

$(TARGET):
	$(COBOL_COMPILER) $(COBOL_FLAGS) $(SRC) -o $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all clean
