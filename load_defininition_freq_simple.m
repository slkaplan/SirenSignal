% starting to find FFT of police siren
[y,Fs] = audioread('sounds/police.wav');
% sound(y,Fs);

N = length(y);
spectrum_police = fftshift(fft(y));
spectrum2 = avg_spectrum(spectrum_police)
freqs_hz = linspace(-Fs*pi , Fs*(pi - 2*pi/N), N) + Fs*pi/N*mod(N,2);

plot(freqs_hz, abs(spectrum_police));
h = ylabel('Amplitude');
set(h,'FontSize', 18);
h = xlabel('Frequency rad/s');
set(h,'FontSize', 18);
h = title('Raw Power Spectrum');
set(h, 'FontSize', 18);

figure()
plot(freqs_hz, abs(spectrum2));
