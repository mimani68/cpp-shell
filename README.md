# Compile with Makefile

```bash
make
```

# Compile directly

```bash
g++ -Wall -g -v -std=c++11 -O3 -Iinclude -o main main.cpp
```

* -o: specifies the output executable filename.
* -Wall: prints "all" Warning messages.
* -g: generates additional symbolic debuggging information for use with gdb debugger.
* -v : verbose mode
* -Ixxx: use for header files
* -Ldir: directoy of library
* -lgcc: use static library with file lgcc.a

## Compile-only with -c option

```bash
g++ -c -Wall -g main.cpp
```

## Link object file(s) into an executable

```bash
g++ -g -o main.exe main.o
```

* -c: Compile into object file "main.o". By default, the object file has the same name as the source file with extension of ".o" (there is no need to specify -o option). No linking with other object files or libraries.
* Linking is performed when the input file are object files ".o" (instead of source file ".cpp" or ".c"). GCC uses a separate linker program (called ld.exe) to perform the linking.

## Library

### Static Library vs. Shared Library

A library is a collection of pre-compiled object files that can be linked into your programs via the linker. Examples are the system functions such as `printf()` and `sqrt()`.

There are two types of external libraries: _static library_ and _shared library_.

1.  A static library has file extension of "`.a`" (archive file) in Unixes or "`.lib`" (library) in Windows. When your program is linked against a static library, the machine code of external functions used in your program is copied into the executable. A static library can be created via the _archive_ program "`ar.exe`".
2.  A shared library has file extension of "`.so`" (shared objects) in Unixes or "`.dll`" (dynamic link library) in Windows. When your program is linked against a shared library, only a small table is created in the executable. Before the executable starts running, the operating system loads the machine code needed for the external functions - a process known as _dynamic linking_. Dynamic linking makes executable files smaller and saves disk space, because one copy of a library can be shared between multiple programs. Furthermore, most operating systems allows one copy of a shared library in memory to be used by all running programs, thus, saving memory. The shared library codes can be upgraded without the need to recompile your program.

Because of the advantage of dynamic linking, GCC, by default, links to the shared library if it is available.

You can list the contents of a library via "`nm _filename_`".

### Searching for Header Files and Libraries (\-I, \-L and \-l)

When compiling the program, the _compiler_ needs the _header files_ to compile the source codes; the _linker_ needs the _libraries_ to resolve external references from other object files or libraries. The compiler and linker will not find the headers/libraries unless you set the appropriate options, which is not obvious for first-time user.

For each of the headers used in your source (via `#include` directives), the compiler searches the so-called _include-paths_ for these headers. The include-paths are specified via `-I_dir_` option (or environment variable `CPATH`). Since the header's filename is known (e.g., `iostream.h`, `stdio.h`), the compiler only needs the directories.

The linker searches the so-called _library-paths_ for libraries needed to link the program into an executable. The library-path is specified via `-L_dir_` option (uppercase `'L'` followed by the directory path) (or environment variable `LIBRARY_PATH`). In addition, you also have to specify the library name. In Unixes, the library `lib_xxx_.a` is specified via `-l_xxx_` option (lowercase letter `'l'`, without the prefix "`lib`" and `".a`" extension). In Windows, provide the full name such as `-lxxx.lib`. The linker needs to know both the directories as well as the library names. Hence, two options need to be specified.

Try running the compilation in verbose mode `(-v)` to study the library-paths `(-L)` and libraries `(-l)` used in your system:

```bash
gcc -v -o hello.exe hello.c

-L/usr/lib/gcc/x86_64-pc-cygwin/6.4.0
-L/usr/x86_64-pc-cygwin/lib
-L/usr/lib
-L/lib
-lgcc_s     // libgcc_s.a
-lgcc       // libgcc.a
-lcygwin    // libcygwin.a
-ladvapi32  // libadvapi32.a
-lshell32   // libshell32.a
-luser32    // libuser32.a
-lkernel32  // libkernel32.a
```

### GCC uses the following environment variables:

*   `PATH`: For searching the executables and run-time shared libraries (`.dll`, `.so`).
*   `CPATH`: For searching the _include-paths_ for headers. It is searched after paths specified in `-I<_dir_>` options. `C_INCLUDE_PATH` and `CPLUS_INCLUDE_PATH` can be used to specify C and C++ headers if the particular language was indicated in pre-processing.
*   `LIBRARY_PATH`: For searching _library-paths_ for link libraries. It is searched after paths specified in -`L<_dir_>` options.

---

### "ldd" Utility - List Dynamic-Link Libraries

```bash 
ldd application
-------
ntdll.dll => /cygdrive/c/WINDOWS/SYSTEM32/ntdll.dll (0x7ff9ba3c0000)
KERNEL32.DLL => /cygdrive/c/WINDOWS/System32/KERNEL32.DLL (0x7ff9b9880000)
KERNELBASE.dll => /cygdrive/c/WINDOWS/System32/KERNELBASE.dll (0x7ff9b6a60000)
SYSFER.DLL => /cygdrive/c/WINDOWS/System32/SYSFER.DLL (0x6ec90000)
ADVAPI32.dll => /cygdrive/c/WINDOWS/System32/ADVAPI32.dll (0x7ff9b79a0000)
msvcrt.dll => /cygdrive/c/WINDOWS/System32/msvcrt.dll (0x7ff9b9100000)
sechost.dll => /cygdrive/c/WINDOWS/System32/sechost.dll (0x7ff9b9000000)
RPCRT4.dll => /cygdrive/c/WINDOWS/System32/RPCRT4.dll (0x7ff9b9700000)
cygwin1.dll => /usr/bin/cygwin1.dll (0x180040000)
```

## Compile process

![](docs/GCC_CompilationProcess.png)

## Read more

    1) https://www3.ntu.edu.sg/home/ehchua/programming/cpp/gcc_make.html

    2) https://www.cs.fsu.edu/~myers/howto/g++compiling.txt