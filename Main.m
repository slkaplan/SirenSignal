% starting to find FFT of police siren
[y,Fs] = audioread('C:\Users\skaplan1\Documents\GitHub\SirenSignal\sounds\test_signal.wav');
% sound(y,Fs);

N = length(y);
test_signal = fftshift(fft(y));
% spectrum2 = avg_spectrum(spectrum_police)
freqs_hz = linspace(-Fs*pi , Fs*(pi - 2*pi/N), N) + Fs*pi/N*mod(N,2);

plot(freqs_hz, abs(test_signal), 'o');
h = ylabel('Amplitude');
h = xlabel('Frequency rad/s');
h = title('Raw Power Spectrum');

%% Test signal test
[y,Fs] = audioread('C:\Users\skaplan1\Documents\GitHub\SirenSignal\sounds\test_signal.wav');
N = length(y);
test_signal = fftshift(fft(y));
freqs_hz = linspace(-Fs*pi , Fs*(pi - 2*pi/N), N) + Fs*pi/N*mod(N,2);
copy = test_signal;
len = length(total_spectrums)
diff = []
for i = 3:length(total_spectrums)
    signal = total_spectrums{i,1};
    signal_len = length(signal);
    signal_freq = linspace(-Fs*pi , Fs*(pi - 2*pi/signal_len), signal_len) + Fs*pi/signal_len*mod(signal_len,2);
    copy = test_signal;
    figure()
    hold on;
    plot(freqs_hz, abs(test_signal), 'o');
    plot(signal_freq, abs(signal), 'or');
    ylabel('Amplitude');
    xlabel('Frequency rad/s');
    title('Frequency Comparision');
    hold off;
    
    if (signal_len > N)
        B = zeros(signal_len,1);
        B(1:size(copy,1)) = copy;
        copy = B;
    else
        B = zeros(N,1);
        B(1:size(signal,1)) = signal;
        signal = B;
    end
    diff = [diff, mean(abs(copy - signal))]
end




%% Loading all definition frequencies
myDir = ['C:\Users\skaplan1\Documents\GitHub\SirenSignal\sounds'];	% sets working directory (not transferable)
files = dir(fullfile(myDir)); %gets all wav files in struct
numFiles = length(files)
total_spectrums = cell(numFiles,1);
total_freqs_hz = cell(numFiles,1);
for k = 3:length(files)
    Name =files(k).name; % files name
	fullFileName = fullfile(myDir, Name); % full file path
    FileName_edited = regexprep(fullFileName,'[][]',''); % removes brackets so we can use audioread
    [y, Fs] = audioread(FileName_edited);
    
    N = length(y);
    spectrum_vector = fftshift(fft(y));
    sz = size(spectrum_vector);
    
    % only averages channel if stereo signal
    if sz(2) > 1
        spectrum_vector = avg_spectrum(spectrum_vector);
    end
    freqs_hz = linspace(-Fs*pi , Fs*(pi - 2*pi/N), N) + Fs*pi/N*mod(N,2);
    
    total_spectrums{k} = spectrum_vector;
    total_freqs_hz{k} = freqs_hz;
    % trying to pad array because different sounds are different lengths
%     if k == 3
%         total_spectrums = [total_spectrums; spectrum_vector];
%         total_freqs_hz = [total_freqs_hz; freqs_hz];
%     else
%         total_spectrums = padcat(total_spectrums, spectrum_vector);
%         total_freqs_hz = padcat(total_freqs_hz, freqs_hz);
%     end

end




