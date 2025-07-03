all: hello.bin hello.static

hello.bin: hello.c
	gcc hello.c -o hello.bin

hello.static: hello.c
	gcc -static hello.c -o hello.static

ubuntu_deps:
	sudo apt install -y build-essential libelf-dev qemu-system busybox-static

fedora_deps:
	sudo dnf install -y elfutils-libelf-devel qemu busybox glibc-static

clean:
	rm -f hello.bin hello.static
