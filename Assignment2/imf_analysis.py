import numpy as np
import matplotlib.pyplot as plt

# Define the Chabrier IMF (dN/dM)
def IMF(M):
    """Initial Mass Function dN/dM (Chabrier 2005)."""
    M = np.array(M)  # Ensure M is a numpy array for vectorized operations
    IMF_vals = np.where(
        M <= 1,
        # Low-mass branch
        (0.093 / (M * np.log(10))) * np.exp(-(np.log10(M) - np.log10(0.2))**2 / (2 * 0.55**2)),
        # High-mass branch
        (0.041 / np.log(10)) * M**-2.35
    )
    return IMF_vals

# Discretize the IMF over logarithmic bins 
def discretise_IMF(Mmin, Mmax, bins):
    logM_edges = np.linspace(np.log10(Mmin), np.log10(Mmax), bins + 1)
    M_edges = 10**logM_edges
    M_centers = np.sqrt(M_edges[:-1] * M_edges[1:])
    return M_edges, M_centers

# Find the mode of the IMF 
def find_mode(M_centers):
    IMF_vals = IMF(M_centers)
    return M_centers[np.argmax(IMF_vals)]

#  Compute average stellar mass via staggered binning
def compute_average_mass(M_edges):
    M_left = M_edges[:-1]
    M_right = M_edges[1:]
    M_mid = (M_left + M_right) / 2

    IMF_left = IMF(M_left)
    IMF_right = IMF(M_right)
    IMF_mid = (IMF_left + IMF_right) / 2

    dM = M_right - M_left
    integral = np.sum(IMF_mid * dM)  # normalize
    IMF_normalized = IMF_mid / integral
    avg_mass = np.sum(IMF_normalized * M_mid * dM)
    return avg_mass

#   Analyze convergence of average mass with bin count
def analyze_convergence(Mmin, Mmax, bin_range):
    avg_masses = []
    for bins in bin_range:
        M_edges, _ = discretise_IMF(Mmin, Mmax, bins)
        avg_mass = compute_average_mass(M_edges)
        avg_masses.append(avg_mass)
    return avg_masses

#   Estimate average mass with large Mmax 
def estimate_mass_for_large_Mmax(Mmin, Mmax_large=1e5, bins=1000):
    M_edges, _ = discretise_IMF(Mmin, Mmax_large, bins)
    avg_mass = compute_average_mass(M_edges)
    return avg_mass

#  Main execution 
def main():
    Mmin = 10e-2
    Mmax = 10e2
    bins = 100

    # Discretize
    M_edges, M_centers = discretise_IMF(Mmin, Mmax, bins)
    IMF_vals = IMF(M_centers)

    # Plot IMF
    plt.figure()
    plt.loglog(M_centers, IMF_vals, label="IMF (dN/dM)")
    plt.xlabel("Stellar Mass M [M☉]")
    plt.ylabel("dN/dM")
    plt.title("Initial Mass Function (Chabrier 2005)")
    plt.grid(True, which="both", ls="--")
    plt.legend()
    plt.savefig("imf_plot.pdf")

    # Mode
    mode = find_mode(M_centers)
    print(f"Mode of IMF: {mode:.3f} M☉")

    # Average Mass
    avg_mass = compute_average_mass(M_edges)
    print(f"Average Stellar Mass (bins={bins}): {avg_mass:.3f} M☉")

    # Convergence test
    bin_range = np.arange(10, 301, 10)
    avg_masses = analyze_convergence(Mmin, Mmax, bin_range)

    plt.figure()
    plt.plot(bin_range, avg_masses, marker='o')
    plt.xlabel("Number of bins")
    plt.ylabel("Average Stellar Mass [M☉]")
    plt.title("Convergence of Average Mass with Bins")
    plt.grid(True)
    plt.savefig("avg_mass_convergence.pdf")

    # Find bin count needed for 1% convergence
    final_val = avg_masses[-1]
    for b, val in zip(bin_range, avg_masses):
        rel_err = abs(val - final_val) / final_val
        if rel_err < 0.01:
            print(f"Converged to within 1% for bins ≥ {b}")
            break

    # Estimate average mass as Mmax → ∞
    avg_mass_large = estimate_mass_for_large_Mmax(Mmin, Mmax_large=1e5, bins=5000)
    print(f"Average mass with Mmax → ∞ (Mmax=1e5): {avg_mass_large:.2f} M☉")

if __name__ == "__main__":
    main()
