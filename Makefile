all: hello.bin hello.static

hello.bin: hello.c
	gcc hello.c -o hello.bin

hello.static: hello.c
	gcc -static hello.c -o hello.static

ubuntu_deps:
	sudo apt-get install -y build-essential libelf-dev qemu-system busybox-static bc git exuberant-ctags
#   libncurses5-dev libssl-dev

fedora_deps:
	sudo dnf install -y elfutils-libelf-devel qemu busybox glibc-static ctags

clean:
	rm -f hello.bin hello.static
