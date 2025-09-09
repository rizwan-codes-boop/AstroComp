#!/bin/bash

# 1. Print integers 1 to 20 on separate lines
for i in {1..20}; do
    echo "$i"
done

# 2. Print numbers 1 to 20 on one line with spaces
for i in {1..20}; do
    echo -n "$i "
done
echo ""

# 3. Print padded numbers (01 to 20) with trailing commas
for i in $(seq -w 1 20); do
    echo -n "$i, "
done
echo ""

# 4. Same as above but remove the last comma with if-else
for i in $(seq -w 1 20); do
    if [ "$i" -eq 20 ]; then
        echo -n "$i"
    else
        echo -n "$i, "
    fi
done
echo ""

# 5. List files/directories in root with custom prefix
for item in /.* /*; do
    [ -e "$item" ] && echo "Listing item in root: $item"
done
