adc => FFT fft =^ Centroid cent => blackhole;

//Set Parameters
1024 => fft.size;
1024 => int WinSize;

second/samp => float samplerate;

Windowing.hann(WinSize) => fft.window;

0 => int gate;
1.0 => float threshold

while(true){
    rms.upchuck() @=> UAnaBlob blob;
    blob.fval(0) * 1000 => float temp;
    <<<temp>>>;

    WinSize::samp => now;

}
