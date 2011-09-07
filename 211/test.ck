// processing
adc => Pan2 pan => dac;
// analysis
adc => FFT fft =^ Flux capacitor => blackhole;

// set FFT parameters
Windowing.hann( 512 ) => fft.window;
512 => fft.size;
256 => int hopSize;

while( true )
{
     // upchuck
     capacitor.upchuck() @=> UAnaBlob @ fluxBlob;

     // "classify"
     if( fluxBlob.fval(0) > .5 )
     { -1 => pan.pan; }
     else
     { 1 => pan.pan; }

     // hop (by advancing time)
     256::samp => now;
}
