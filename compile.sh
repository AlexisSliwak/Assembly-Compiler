#!/bin/bash
# This script compiles an assembly file using NASM and links it with ld.
# Returns the name of the output file if successful
# $1: input file | .s file extension optional
# $2: output file | optional, defaults to base name of input file
compile() {
    base_name=$(basename "$1" .asm)
    if [ -z "$base_name" ]; then
        echo "No file name provided." >&2
        echo "Usage: (compile | run) <filename> [<output_file>]" >&2
        return 1;
    fi

    if [ ! -e "$base_name.asm" ]; then
        echo "Expected file $base_name.asm not found." >&2
        echo "Usage: (compile | run) <filename> [<output_file>]" >&2
        return 1;
    fi

    if [ ! -f "$base_name.asm" ]; then
        echo "File $base_name.asm is not a regular file." >&2
        return 1;
    fi

    if [ -z "$2" ]; then
        output_file="$base_name.exe"
    else
        output_file="$2"
    fi

    while [ -e "$output_file" ]; do
        echo "Output file $output_file already exists." >&2
        read -p "Do you want to overwrite it? (y/n) " answer
        if [ "${answer,,}" != "y" ]; then
            read -p "Do you want to choose a different output file? (y/n) " answer
            if [ "${answer,,}" != "y" ]; then
                echo "Exited without overwriting." >&2
                return 0;
            fi
            read -p "Enter the new output file: " new_output_file
            output_file=$(basename "$new_output_file")
        else
            echo "Overwriting $output_file..." >&2
            break
        fi
    done

    object_file="${output_file}_$(uuidgen).o"
    if nasm -f elf64 "$base_name.asm" -o "$object_file"; then
        if ld "$object_file" -o "$output_file"; then
            printf "Compilation successful to file: " >&2
            rm "$object_file"
            echo "$output_file"
            return 0;
        else
            echo "Linking failed." >&2
            rm "$object_file"
        fi
    else
        echo "Assembly failed." >&2
    fi
    return 1;
}
