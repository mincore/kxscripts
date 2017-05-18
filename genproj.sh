#!/bin/bash

mkdir -p deps/include deps/lib include src lib bin test

echo '
CC=@echo -e "cc \033[32m$@\033[0m";g++

DEPINCDIR=deps/include
DEPLIBDIR=deps/lib
BINDIR=bin
EXE=$(BINDIR)/a.out
TEST=$(BINDIR)/test

CXXFLAGS=-g -Wall -Werror
CXXFLAGS+=-I$(DEPINCDIR) -Isrc

OBJS=$(patsubst %.cpp,%.o,$(shell find src -name *.cpp))
TEST_OBJS=$(patsubst %.cpp,%.o,$(shell find test -name *.cpp))
TEST_OBJS+=$(patsubst %main.o,,$(OBJS))

DEPS=

LDFLAGS+=$(DEPS)

all:$(EXE) $(TEST) 

$(EXE): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

$(TEST): $(TEST_OBJS) 
	$(CC) $^ $(LDFLAGS) $(DEPLIBDIR)/google/libgtest.a -o $@

%.o:%.cpp
	$(CC) $< -c -o $@ $(CXXFLAGS)

.PHONY : clean

clean:
	@rm $(OBJS) $(EXE) $(TEST) $(TEST_OBJS) -f
' > Makefile
