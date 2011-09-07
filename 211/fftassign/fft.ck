
SndBuf Eno => FFT fft_e =^ RMS rms => blackhole; // Music signal
Eno => dac;
"/Users/heyarnold/Documents/ChucK/fftassign/Golden_Hours.wav" => Eno.read;

//OSC sender
OscSend xmit;
"localhost" => string hostname;
6450 => int sendport;
xmit.setHost( hostname, sendport );

//fft constants
2048 => int FFT_SIZE;
FFT_SIZE/2 => int WIN_SIZE;
WIN_SIZE/2 => int HOP_SIZE;

.5 => Eno.gain;
1 => Eno.loop;

//windowing
Windowing.hann( WIN_SIZE ) => fft_e.window;
FFT_SIZE => fft_e.size;

//Osc Begin
xmit.startMsg("/temp", "f");

//Begin loop
while(true){
    rms.upchuck() @=> UAnaBlob blob;
    blob.fval(0) * 1000 => float temp;

    //Transmit temp
    //temp => xmit.addFloat;

    WIN_SIZE::samp => now;
}
