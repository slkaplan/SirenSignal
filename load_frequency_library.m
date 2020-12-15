%% Creates library of reference frequencies
myDir = ['C:\Users\skaplan1\Documents\GitHub\SirenSignal\sounds'];	% sets working directory (not transferable)
files = dir(fullfile(myDir)); %gets all wav files in struct
numFiles = length(files);

% makes cells sized 2+number of sound files
total_spectrums = cell(numFiles,2);
total_freqs_hz = cell(numFiles,2);
for k = 3:length(files)
    Name =files(k).name; % files name
	fullFileName = fullfile(myDir, Name); % full file path
    FileName_edited = regexprep(fullFileName,'[][]',''); % removes brackets so we can use audioread
    [y, Fs] = audioread(FileName_edited);
    
    N = length(y);
    spectrum_vector = fftshift(fft(y));
   
    % only averages channel if stereo signal
    sz = size(spectrum_vector);
    if sz(2) > 1
        spectrum_vector = avg_spectrum(spectrum_vector);
    end
    freqs_hz = linspace(-Fs*pi , Fs*(pi - 2*pi/N), N) + Fs*pi/N*mod(N,2);
    
    total_spectrums{k,1} = spectrum_vector;
    total_spectrums{k,2} = Name;
    total_freqs_hz{k,1} = freqs_hz;
    total_freqs_hz{k,2} = Name;
end

save('frequency_library.mat', 'total_spectrums', 'total_freqs_hz')




