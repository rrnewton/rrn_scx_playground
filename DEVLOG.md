


# Configurations that work


 * ./go_virtme.sh runs with stdout passthru on a vanilla ubuntu laptop.
   Using default `virtme-configkernel --defconfig --arch x86` config found in:
    `kernel_configs_bak/.config_virtme_default_on_ubuntu_laptop`



# Problems with MenuConfig

On some machines I'm having trouble enabling CONFIG_SCHED_CLASS_EXT

    ./linux/kernel/Kconfig.preempt

I'm not finding the option where it should be to enable DEBUG_INFO_BTF.
That option in trun has a long list of dependencies.

    DEBUG_INFO [=n] && 
	!DEBUG_INFO_SPLIT [=n] && 
	!DEBUG_INFO_REDUCED [=n] && 
	(!GCC_PLUGIN_RANDSTRICT [=n] || COMPILE_TEST [=n]) && 
	BPF_SYSCALL [=y] && 
	PAHOLE_VERSION [=0]>=116 && 
	(DEBUG_INFO_DWARF4 [=n] || PAHOLE_VERSION [=0]>=121) && 
	!HEXAGON

I think the square brackets are showing the CURRENT setting.
PAHOLE_VERSION needs to be updated. Indeed, I needed to install that dependency.
So what is a complete set of options I could set to get all my dependencies?

Ok now it is happy. The below set of options seems to help, plus having pahole installed:

```
CONFIG_BPF=y
CONFIG_SCHED_CLASS_EXT=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_SPLIT=n
CONFIG_DEBUG_INFO_REDUCED=n
```

What's the deal with the HEXAGON thing?
