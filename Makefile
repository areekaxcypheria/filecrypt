CXX      ?= g++
CXXFLAGS ?= -std=c++17 -Wall -Wextra -Wpedantic -O2 -Iinclude
BUILD    := build
LIB_SRC  := src/ciphers.cpp src/file_handler.cpp
LIB_OBJ  := $(LIB_SRC:src/%.cpp=$(BUILD)/%.o)

.PHONY: all test demo clean

all: $(BUILD)/filecrypt

$(BUILD)/%.o: src/%.cpp | $(BUILD)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/filecrypt: $(LIB_OBJ) $(BUILD)/main.o
	$(CXX) $^ -o $@

$(BUILD)/test_ciphers: tests/test_ciphers.cpp $(LIB_OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@

test: $(BUILD)/test_ciphers
	./$(BUILD)/test_ciphers

demo: all
	./$(BUILD)/filecrypt -m encrypt -c vigenere -k LEMON -i examples/sample.txt -o $(BUILD)/demo.enc
	@echo "--- encrypted ---" && cat $(BUILD)/demo.enc
	./$(BUILD)/filecrypt -m decrypt -c vigenere -k LEMON -i $(BUILD)/demo.enc -o $(BUILD)/demo.dec
	@echo "--- decrypted ---" && cat $(BUILD)/demo.dec

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
