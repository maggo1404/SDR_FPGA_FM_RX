import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

def design_lowpass_fir(sample_rate, cutoff_freq, stopband_attenuation):
    nyquist_freq = 0.5 * sample_rate
    normalized_cutoff_freq = cutoff_freq / nyquist_freq
    num_taps, beta = signal.kaiserord(stopband_attenuation, normalized_cutoff_freq)
    taps = signal.firwin(num_taps, normalized_cutoff_freq, window=('kaiser', beta))
    return taps

# Beispielaufruf des Filters
sample_rate = 2e6  # 2 MSample/s
cutoff_freq = 15e3  # 15 kHz
stopband_attenuation = 50  # 50 dB

fir_taps = design_lowpass_fir(sample_rate, cutoff_freq, stopband_attenuation)

# Plot der Filterkoeffizienten
plt.figure()
plt.stem(fir_taps, use_line_collection=True)
plt.xlabel('Sample')
plt.ylabel('Coefficient Value')
plt.title('FIR Filter Coefficients')
plt.grid(True)
plt.show()