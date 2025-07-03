


[2025.07.03] {Kernel panics elsewhere, trying a repro under docker}
================================================================================

I'm trying the same repro script on a fresh container under docker to
see if the result is the same as on the two linux (laptop & server)
systems I tested on.

Initial result: it installed a bunch of fedora packages then ran into this error:

```
Complete!
‣  Running depmod for 6.16.0-0.rc3.250627g67a993863163.35.fc43.aarch64
‣  Installing cache copies
‣  Copying cached trees
Traceback (most recent call last):
  File "/build/mkosi/mkosi/run.py", line 51, in uncaught_exception_handler
    yield
  File "/build/mkosi/mkosi/run.py", line 91, in fork_and_wait
    target(*args, **kwargs)
  File "/build/mkosi/mkosi/__init__.py", line 4935, in run_build
    build_image(
  File "/build/mkosi/mkosi/__init__.py", line 3999, in build_image
    reuse_cache(context)
  File "/build/mkosi/mkosi/__init__.py", line 3305, in reuse_cache
    copy_tree(
  File "/build/mkosi/mkosi/tree.py", line 116, in copy_tree
    if statfs(os.fspath(dst.parent)) != OVERLAYFS_SUPER_MAGIC or not tree_has_selinux_xattr(src):
                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/build/mkosi/mkosi/tree.py", line 91, in tree_has_selinux_xattr
    return any("security.selinux" in os.listxattr(p) for p in (path, *path.rglob("*")))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/build/mkosi/mkosi/tree.py", line 91, in <genexpr>
    return any("security.selinux" in os.listxattr(p) for p in (path, *path.rglob("*")))
                                     ^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: '/build/mkosi-kernel/mkosi.cache/fedora~rawhide~arm64~main.cache/var/lock'
make: *** [go] Error 1
```
