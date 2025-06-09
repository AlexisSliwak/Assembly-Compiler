#!/bin/bash
source ./compile.sh
run() {
    if output_file=$(compile "$1" "$2"); then
        if [ -n "$output_file" ]; then
            echo "Running $output_file..."
            ./"$output_file"
            if [ -z "$2" ]; then
                rm "$output_file"
            fi
        fi
    else
        return 1;
    fi
}
