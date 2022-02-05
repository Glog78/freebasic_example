CTAGS=/home/mgnad/.local/share/ctags/bin/ctags
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
	fbc -g -nostrip -w pedantic -mt -exx $< -x bin/$@

ctags:
	rm -f tags
	$(CTAGS) --languages=Basic --extras-basic=* -R 
#	$(CTAGS) --languages=Basic --kinds-basic=-v --extras=+r -R 

clean:
	rm -f $(OBJS:%=bin/%) $(OBJS_DEBUG:%=bin/%)
