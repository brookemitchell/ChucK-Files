// Fourier Transform

adc => FFT fft =^ RMS rms => blackhole; // RMS _of_ fft

//set parameters
1024 => fft.size; //Freq Domain
1024 => int WinSize; //Time Domain

Windowing.hann(1024) => fft.window; //also has a size

while(true){
rms.upchuck() @=> UAnaBlob blob;
blob.fval(0)*1000 => float temp;
<<<temp>>>;
WinSize::samp => now;
}
