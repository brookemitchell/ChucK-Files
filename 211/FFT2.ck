adc => FFT fft =^ RMS rms => blackhole;

//Set Parameters
1024 => fft.size;
1024 => int WinSize;
1 => float threshold;

Windowing.hann(WinSize) => fft.window;

while(true){
    rms.upchuck() @=> UAnaBlob blob;
    blob.fval(0) * 1000 => float temp;

    //<<<temp>>>;

    WinSize::samp => now;

    if ((temp > threshold) && (gate == 0)){
        <<<"bang">>>;
        1=> gate;
        }
   else if ((temp < threshold) && (gate ==1)){
        0 => gate;
        }
    }

    // better way to turn 1 to vars called threshold to set sens.
    //or set two thresholds one for on and one for off
    //or adaptive thresholding
