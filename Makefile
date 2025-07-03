all: hello.bin hello.static

hello.bin: hello.c
	gcc hello.c -o hello.bin

hello.static: hello.c
	gcc -static hello.c -o hello.static

clean:
	rm -f hello.bin hello.static
