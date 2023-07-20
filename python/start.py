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

def plot_waterfall(iq_stream, sample_rate, frequency_range):
    n_samples = len(iq_stream)
    time = np.arange(0, n_samples / sample_rate, 1 / sample_rate)
    frequency_resolution = sample_rate / n_samples
    _, _, _, im = plt.specgram(iq_stream, NFFT=65536, Fs=sample_rate, noverlap=32768)
    plt.colorbar(im, format='%+2.0f dB')
    plt.xlabel('Time (s)')
    plt.ylabel('Frequency (Hz)')
    #plt.ylim(frequency_range[0], frequency_range[1])
    plt.show()

def apply_fir_filter(iq_stream, sample_rate, passband_freq, stopband_freq, attenuation):
    nyquist_rate = sample_rate / 2
    passband_normalized = passband_freq / nyquist_rate
    stopband_normalized = stopband_freq / nyquist_rate
    delta = 0.01
    num_taps, beta = signal.kaiserord(attenuation, passband_normalized - stopband_normalized)
    num_taps = max(num_taps, 1)
    taps = signal.firwin(num_taps, passband_normalized, window=('kaiser', beta))
    filtered_iq_stream = signal.lfilter(taps, 1.0, iq_stream)
    return filtered_iq_stream

# Beispielaufruf des Skripts
even_values, odd_values = load_binary_file('HDSDR_20230629_144109Z_145000kHz_RF.wav')

sample_rate = 2e6  # 2 MSample/s
frequency = 625e3  # 625 kHz
frequency_range = (600e3, 650e3)  # 600 kHz bis 650 kHz
passband_freq = 15e3  # 15 kHz
stopband_freq = 25e3  # 25 kHz
attenuation = 80  # 50 dB

iq_stream = generate_iq_stream(even_values, odd_values, sample_rate, frequency)
filtered_iq_stream = apply_fir_filter(iq_stream, sample_rate, passband_freq, stopband_freq, attenuation)


# Plot des Spektrums vor und nach der Filterung
frequency_resolution = sample_rate / len(iq_stream)
freq = np.fft.fftfreq(len(iq_stream), d=1 / sample_rate)
spectrum = np.fft.fft(iq_stream)
filtered_spectrum = np.fft.fft(filtered_iq_stream)

plt.figure(figsize=(12, 6))
plt.subplot(2, 1, 1)
plt.plot(freq, 20 * np.log10(np.abs(spectrum)), label='Vor der Filterung')
plt.xlabel('Frequenz (Hz)')
plt.ylabel('Amplitude (dB)')
plt.title('Spektrum vor der Filterung')
plt.grid(True)
plt.legend()

plt.subplot(2, 1, 2)
plt.plot(freq, 20 * np.log10(np.abs(filtered_spectrum)), label='Nach der Filterung')
plt.xlabel('Frequenz (Hz)')
plt.ylabel('Amplitude (dB)')
plt.title('Spektrum nach der Filterung')
plt.grid(True)
plt.legend()

plt.tight_layout()
plt.show()