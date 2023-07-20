import numpy as np
import scipy.io.wavfile as wavfile
from scipy import signal

# 1. Eine 8-Bit-Stereo-WAV-Datei öffnen und als IQ-Stream lesen
sample_rate, stereo_data = wavfile.read('audio.wav')
# In ein eindimensionales Array komplexer Zahlen konvertieren
iq_stream = stereo_data[:, 0] + 1j * stereo_data[:, 1]

# DC-Block Parameter
dc_block_size = 1024
dc_block_buffer = np.zeros(dc_block_size)
dc_block_sum = 0

# Verarbeitungsschleife
decimation_factor = 166
demodulated_stream = []
filtered_sample_prev = 0

for i in range(len(iq_stream)):
    sample = iq_stream[i]

    # DC-Block
    dc_block_sum += sample - dc_block_buffer[-1]
    dc_block_buffer[:-1] = dc_block_buffer[1:]
    dc_block_buffer[-1] = sample
    sample -= dc_block_sum / dc_block_size

    # 3. Sinus mit 625 kHz erstellen
    duration = 1 / sample_rate
    time = np.linspace(0, duration, 1)
    frequency = 629000
    sinusoid = np.exp(-1j * 2 * np.pi * frequency * time)

    # 4. IQ-Stream und Sinus multiplizieren (mischen)
    mixed_sample = sample * sinusoid

    # 6. Den gemischten Sample mit einem Tiefpassfilter filtern
    cutoff_freq = 5000
    passband_width = 10000
    stopband_attenuation = 60
    nyquist_rate = sample_rate / 2
    transition_width = (passband_width - cutoff_freq) / nyquist_rate

    filter_length, beta = signal.kaiserord(stopband_attenuation, transition_width)
    taps = signal.firwin(filter_length, cutoff_freq, window=('kaiser', beta), fs=sample_rate, pass_zero='lowpass')

    filtered_sample = signal.lfilter(taps, 1.0, mixed_sample)

    # 8. Jeden 83. Sample in den demodulierten Stream kopieren
    if i % decimation_factor == 0:
        demodulated_sample = np.angle(filtered_sample * np.conj(filtered_sample_prev))
        demodulated_stream.append(demodulated_sample)

    filtered_sample_prev = filtered_sample

# Den demodulierten Stream als Audio ausgeben
decimated_sample_rate = sample_rate // decimation_factor
wavfile.write('demodulated_audio.wav', int(decimated_sample_rate), np.array(demodulated_stream).astype(np.float32))
