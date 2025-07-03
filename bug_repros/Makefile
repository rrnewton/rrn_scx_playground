

# Using Docker on a Mac host.
build:
	docker build -t "mkosi-kernel-test" .
	docker run -it --rm --privileged mkosi-kernel-test ./mkosi_kernel_repro.sh


# The idea was to have an entrypoint to build and one to run.  Until then it's rather
# pointless to not just use another bash script.
run:
