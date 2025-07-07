all: hello.bin hello.static

# Little Test programs
#==============================================================================

hello.bin: hello.c
	gcc hello.c -o hello.bin

hello.static: hello.c
	gcc -static hello.c -o hello.static

# Dependencies
#==============================================================================


ubuntu_deps:
	sudo apt-get install -y build-essential libelf-dev qemu-system busybox-static bc git exuberant-ctags
#   libncurses5-dev libssl-dev

fedora_deps:
	sudo dnf install -y elfutils-libelf-devel qemu busybox glibc-static ctags

# Linux Kernel Builds
#==============================================================================

server:
	(cd linux && ln -sf ../kernel_configs_bak/server_current_config)
	(cd linux && make -j ARCH=x86_64)

laptop:
	(cd linux && ln -sf ../kernel_configs_bak/laptop_current_config)
	(cd linux && make -j ARCH=x86_64)

clean:
	rm -f hello.bin hello.static
