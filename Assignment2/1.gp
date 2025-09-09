reset
set term pdfcairo color enhanced dashed linewidth 1.5 font "Times-Roman,16"

# Output file
outfile = "density_pdf_fit.pdf"
set output outfile

# Line styles
set style line 1 lt 1 lw 1.5 pt 1 ps 1.0  # Gaussian fit
set style line 2 lt 3 lw 1.5 pt 5 ps 1.0  # Data points


# Axes
unset title
set key spacing 1.5 samplen 3
set key at graph 0.95, graph 0.95
set xlabel "s = ln(ρ/ρ₀)"
set ylabel "P_V(s)"
set xrange [-10:10]
unset logscale x
unset logscale y

# Gaussian model
f(x) = 1.0/(sqrt(2.0*pi)*sigma) * exp(-(x-x0)**2/(2.0*sigma**2))
x0 = 0.0
sigma = 1.0
fit f(x) 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' using 1:3 via x0, sigma


# Plot data and fit
plot 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' every ::10 using 1:3 with points ls 2 title "Simulation PDF", \
     f(x) with lines ls 1 title sprintf("Gaussian Fit (μ=%.2f, σ=%.2f)", x0, sigma)

print outfile . " created."
