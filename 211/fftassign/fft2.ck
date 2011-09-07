
SndBuf Eno => FFT fft_e =^ RMS rms => blackhole; // Music signal
fft_e =^ Centroid cent => blackhole;
fft_e =^ Flux flux => blackhole;
fft_e =^ RollOff roff => blackhole;
Eno => dac;
"/Users/heyarnold/Documents/ChucK/fftassign/Golden_Hours.wav" => Eno.read;

//OSC sender
OscSend xmit;
"localhost" => string hostname;
12000 => int sendport;
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


//Begin loop
while(true){
    rms.upchuck() @=> UAnaBlob blob;
    blob.fval(0) * 1000 => float rmsVal;
    
    cent.upchuck() @=> UAnaBlob blob2;
    blob2.fval(0) => float centValue;

    flux.upchuck() @=> UAnaBlob blob3;
    blob3.fval(0) => float fluxValue;

    roff.upchuck() @=> UAnaBlob blob4;
    blob3.fval(0) => float roffValue;

    TempSend("/Temp", rmsVal, centValue, fluxValue, roffValue);

    WIN_SIZE::samp => now;
}

fun void TempSend(string Msg, float f1, float f2, float f3, float f4){
    //Osc Message ident
    xmit.startMsg(Msg, "ffff");
    //Transmit temp
    f1 => xmit.addFloat;
    f2 => xmit.addFloat;
    f3 => xmit.addFloat;
    f4 => xmit.addFloat;
}

