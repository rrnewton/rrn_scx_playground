all: tests scheds

# Little Test programs
#==============================================================================
tests: hello.bin hello.static schtest schbench tools_scx

hello.bin: hello.c
	gcc hello.c -o hello.bin

hello.static: hello.c
	gcc -static hello.c -o hello.static

schtest:
	cd schtest && cargo build

schbench:
	cd schbench && make

tools_scx:
	cd linux && make -j16 -C tools/sched_ext

selftests:
	cd linux && make -j -C tools/testing/selftests/sched_ext
#	cd linux/tools/testing/selftests/sched_ext && make -j

# Schedulers
#==============================================================================

scheds:
	cd scx && cargo build --release

# Dependencies
#==============================================================================

ubuntu_deps:
	sudo apt-get install -y build-essential libelf-dev qemu-system busybox-static bc git exuberant-ctags
#   libncurses5-dev libssl-dev

fedora_deps:
	sudo dnf install -y elfutils-libelf-devel qemu busybox glibc-static ctags clang llvm libseccomp-devel ncurses-devel

# Linux Kernel Builds
#==============================================================================

incr:
	cd linux && make -j ARCH=x86_64

server:
	(cd linux && ln -sf ../kernel_configs_bak/server_current_config .config)

	(cd linux && make -j176 ARCH=x86_64)

laptop:
	(cd linux && ln -sf ../kernel_configs_bak/laptop_current_config .config)
	(cd linux && make -j16 ARCH=x86_64)

clean:
	rm -f hello.bin hello.static
	(cd linux && make clean)

.PHONY: schbench schtest
