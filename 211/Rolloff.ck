adc => FFT fft =^ RollOff roff => blackhole;
fft =^ Centroid cent => blackhole;
fft =^ Flux flux => blackhole;
fft =^ RMS rms => blackhole;

1024 => fft.size;
1024 => int WinSize;

Windowing.hann(WinSize) => fft.window;

0.85 => roff.percent;
second/samp => float samplerate;

while(true){
    //Calculate Rolloff
    roff.upchuck() @=> UAnaBlob blob;
    blob.fval(0) * samplerate/2 => float roffValue;

    //Calculate Centroid
    cent.upchuck() @=> UAnaBlob blob2;
    blob2.fval(0) * samplerate/2 => float centValue;
    
    //Calculate Flux
    flux.upchuck() @=> UAnaBlob blob3;
    blob2.fval(0) => float fluxValue;

    //Calc RMS
    rms.upchuck() @=> UAnaBlob blob4;
    blob4.fval(0) => float rmsValue;

    <<<roffValue, centValue, fluxValue, rmsValue>>>;

    WinSize::samp => now;
}

