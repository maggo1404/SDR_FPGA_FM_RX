import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

def load_binary_file(file_path):
    even_array = []
    odd_array = []

    with open(file_path, 'rb') as file:
        while True:
            try:
                # Lese zwei Bytes aus der Binärdatei
                byte1 = ord(file.read(1)) - 127
                byte2 = ord(file.read(1)) - 127

                # Überprüfe, ob das Ende der Datei erreicht ist
                if not byte1 and not byte2:
                    break

                # Speichere den Wert in den geraden Feldern im even_array
                even_array.append(byte1)

                # Speichere den Wert in den ungeraden Feldern im odd_array
                odd_array.append(byte2)

            except TypeError:
                break

    return even_array, odd_array

def generate_iq_stream(even_array, odd_array, sample_rate, frequency):
    time = np.arange(0, len(even_array) / sample_rate, 1 / sample_rate)
    i_samples = np.array(even_array) * np.sin(2 * np.pi * frequency * time)
    q_samples = np.array(odd_array) * np.cos(2 * np.pi * frequency * time)
    iq_stream = i_samples + 1j * q_samples
    return iq_stream

def apply_fir_filter(iq_stream, sample_rate, passband_freq, stopband_freq, attenuation):
    nyquist_rate = sample_rate / 2
    passband_normalized = passband_freq / nyquist_rate
    stopband_normalized = stopband_freq / nyquist_rate
    delta = 0.01
    num_taps, beta = signal.kaiserord(attenuation, passband_normalized - stopband_normalized)
    num_taps = max(num_taps, 1)  # Ensure num_taps is positive
    taps = signal.firwin(num_taps, passband_normalized, window=('kaiser', beta))
    filtered_iq_stream = signal.lfilter(taps, 1.0, iq_stream)
    return filtered_iq_stream

# Beispielaufruf des Skripts
even_values, odd_values = load_binary_file('HDSDR_20230629_144109Z_145000kHz_RF.wav')
sample_rate = 2e6  # 2 MSample/s
frequency = 625e3  # 625 kHz
passband_freq = 15e3  # 15 kHz
stopband_freq = 25e3  # 25 kHz
attenuation = 80  # 80 dB (erhöhter Wert)

iq_stream = generate_iq_stream(even_values, odd_values, sample_rate, frequency)
filtered_iq_stream = apply_fir_filter(iq_stream, sample_rate, passband_freq, stopband_freq, attenuation)

# Plot des Spektrums vor und nach der Filterung
frequency_resolution = sample_rate / len(iq_stream)
freq = np.fft.fftfreq(len(iq_stream), d=1 / sample_rate)
spectrum = np.fft.fft(iq_stream)
filtered_spectrum = np.fft.fft(filtered_iq_stream)

# Wasserfalldiagramm vor der Filterung
plt.figure(figsize=(8, 6))
plt.specgram(iq_stream, NFFT=1024, Fs=sample_rate, noverlap=512, cmap='jet')
plt.xlabel('Zeit (s)')
plt.ylabel('Frequenz (Hz)')
plt.title('Wasserfalldiagramm vor der Filterung')
plt.colorbar(label='Amplitude (dB)')

# Wasserfalldiagramm nach der Filterung
plt.figure(figsize=(8, 6))
plt.specgram(filtered_iq_stream, NFFT=1024, Fs=sample_rate, noverlap=512, cmap='jet')
plt.xlabel('Zeit (s)')
plt.ylabel('Frequenz (Hz)')
plt.title('Wasserfalldiagramm nach der Filterung')
plt.colorbar(label='Amplitude (dB)')

plt.tight_layout()
plt.show()
