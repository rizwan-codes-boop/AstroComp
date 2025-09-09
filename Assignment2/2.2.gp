reset
set term pdfcairo color enhanced dashed linewidth 1.5 font "Times-Roman,16"
outfile = "mass_weighted_pdf.pdf"
set output outfile

# Styles
set style line 1 lt 1 lw 1.5 pt 1 ps 1.0
set style line 2 lt 2 lw 1.5 pt 2 ps 1.0

# Axes
set xlabel "s = ln(ρ/ρ₀)"
set ylabel "P_M(s)"
set xrange [-10:10]
unset logscale y
set key at graph 0.95, graph 0.95

# Define Gaussian
f_mass(x) = A * exp(-(x - x0)**2 / (2 * sigma**2))
A = 0.2
x0 = 0.5
sigma = 1.0

# Fit to mass-weighted PDF: PM = exp(x) * PV
fit f_mass(x) 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' using 1:($3 * exp($1)) via A, x0, sigma

# Plot
plot 'EXTREME_hdf5_plt_cnt_0050_dens.pdf_ln_data' using 1:($3 * exp($1)) with points ls 2 title "Mass-weighted PDF", \
     f_mass(x) with lines ls 1 title sprintf("Gaussian Fit (μ=%.2f, σ=%.2f)", x0, sigma)

print outfile . " created."
print sprintf("Fit results: mu = %.4f, sigma = %.4f", x0, sigma)
