SRCS=$(wildcard *.bas)
OBJS=$(SRCS:%.bas=%)
OBJS_DEBUG=$(patsubst %.bas, %_debug, $(SRCS))

.PHONY: ctags debug release all clean

debug: $(OBJS_DEBUG) ctags

release: $(OBJS)

all: debug release

bin:
	- mkdir -p bin

$(OBJS): % : %.bas bin
	fbc -O 3 -strip -mt $< -x bin/$@
	- upx bin/$@

$(OBJS_DEBUG) : %_debug : %.bas bin
	fbc -g -nostrip -w all -mt -exx $< -x bin/$@

ctags:
	rm -f tags
	- find . -type f -iname "*.bas" -o -iname "*.bi" | xargs ctags -G -a 

clean:
	rm -f $(OBJS:%=bin/%) $(OBJS_DEBUG:%=bin/%)
