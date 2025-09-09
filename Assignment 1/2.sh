#!/bin/bash

# 1. Download the data file using wget
wget -O datafile.txt https://www.mso.anu.edu.au/~chfeder/teaching/astr_4004_8004/material/mM4_10048_pdfs/EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data

# 3. grep lines with 'sigma'
grep 'sigma' datafile.txt

# 4. grep sigma and the next line
grep -A1 'sigma' datafile.txt

# 5. Pipe: extract only the line *after* 'sigma'
grep -A1 'sigma' datafile.txt | tail -n1

# 6. Show bash help
bash --help

# 7. Only show 2 lines that explain usage
bash --help | grep -A2 "Usage:"

# 8. Count number of words in last output
bash --help | grep -A2 "Usage:" | wc -w

# 9. Prefix output with "Number of words:"
echo -n "Number of words: "
bash --help | grep -A2 "Usage:" | wc -w

# 10. Extract first 11 lines to header.txt
awk 'NR<=11' datafile.txt > header.txt

# 11. Extract first column after header to column1.txt
awk 'NR>11 {print $1}' datafile.txt > column1.txt
