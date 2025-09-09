reset
set term pdfcairo color enhanced dashed linewidth 1.5 font "Times-Roman,16"
outfile = "multiple_density_pdfs.pdf"
set output outfile

# Styles
set style line 1 lt 1 lw 1.5 pt 1 ps 1.0
set style line 2 lt 2 lw 1.5 pt 2 ps 1.0
set style line 3 lt 3 lw 1.5 pt 3 ps 1.0

# Axes
unset title
set xlabel "s = ln(ρ/ρ₀)"
set ylabel "P_V(s)"
set xrange [-10:10]
set yrange [10e-5:2]
set logscale y
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95

# Plot all three PDFs, with vertical offsets
plot 'EXTREME_hdf5_plt_cnt_0020_dens.pdf_ln_data' using 1:3 with linespoints ls 1 title "0020", \
     'EXTREME_hdf5_plt_cnt_0030_dens.pdf_ln_data' using 1:($3 * 2) with linespoints ls 2 title "0030 × 2 ", \
     'EXTREME_hdf5_plt_cnt_0040_dens.pdf_ln_data' using 1:($3 * 4) with linespoints ls 3 title "0040 × 4 "

print outfile . " created."
