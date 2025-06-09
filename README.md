> [!NOTE]
> Only works for compiling or running a single .asm file.
Support for multiple files will come in the future.

> [!IMPORTANT]
> Requires installation of the [NASM x86-64](https://www.nasm.us/) assembler and ld linker.
> ld is the GNU linker and you probably already have it installed.

# Start
To load the functions upon opening a bash instance or modifying the included files, run this command:
```shell
source run.sh
```
- Run the .asm file:
  
`Saves executable to <output_name> ONLY if specified`
```
run { <file_name.asm> | file_name } [ <output_name> ]
```
- Compile the .asm file:
```
compile { <file_name.asm> | file_name } [ <output_name> = file_name.o ]
```
# Template Guide
This documentation uses standard syntax, inspired by [PostgreSQL's documentation](https://www.postgresql.org/docs/)
> "...brackets ([ and ]) indicate optional parts. Braces ({ and }) and vertical lines (|) indicate that you must choose one alternative."

There are 2 simple additional rules
1. The expression `A = B` to represent `B` as the default value when `A` is not specified
2. Names are constant throughout the entire code block, unless explicitly stated otherwise (Ex. "file_name.o" will adopt "file_name" from "file_name.asm" or "file_name" in the first parameter)
