SndBuf wav => FFT fft => blackhole;
wav => dac;
IFFT ifft => dac;

.75 => wav.gain;
1 => wav.loop;

"./data/0.wav" => string filename;
if( me.args() ) me.arg(0) => filename;
filename => wav.read;

//OSC sender
OscSend xmit;
"localhost" => string hostname;
12000 => int sendport;
xmit.setHost( hostname, sendport);

UAnaBlob blob;

//Set Sameple Rate
44100.0 => float SAMPLE_RATE;

//Set FFT Parameters
4096 => fft.size => int FFT_SIZE; // Frequency Resolution
1024 => int WINDOW_SIZE; // Time domain samples
WINDOW_SIZE/2 => int HOP_SIZE; //Iteration number of samples (overlap)

//Create an FFT Window
Windowing.hann(WINDOW_SIZE) => fft.window;
Windowing.hann(WINDOW_SIZE) => ifft.window;

while (true){
   //Step 1: find amplitude/peak, 2: locate which BIN it is, 3: convert BIN to freq
    float Z[FFT_SIZE/2]; // FFT Analysis Array ( to Nyquist)
    int MaxI; // Store Peak Value index (bbin) in FFT
    fft.upchuck() @=> blob;

    //store FFT results in array Z (magnitude, not complex)
    //so no phase information

    for (0 => int i; i < Z.cap(); i++){
        //you could just send straight out to make spectogram (make fftsze as small as you need) /way smaller
        fft.fval(i) => Z[i];
    }

    MaxIndex(Z) => MaxI;
    //freq => s.freq;
    HOP_SIZE::samp => now;
   // 0 => wav.pos;

   TempSend("/freq", MaxI, Z);

}

fun int MaxIndex(float A[]){

    //Value is max amp value, index location is freq bin place where max hit
    0.0 => float tempMaxValue;
    0 => int tempMaxIndex;

    for(0 => int i; i < A.cap(); i++){
        if(tempMaxValue < A[i]){
            A[i] => tempMaxValue;
            i => tempMaxIndex;
        }
    }
    return tempMaxIndex;
}

fun float Bin2Freq(int bin, float sr, int fftsize){
    float freq;
    //magic equation - derived from standard unit thing
    (bin*sr)/fftsize => freq;

    return freq;
}

fun void TempSend(string Msg, int i1, float[] array){
    //Osc Message ident
    xmit.startMsg(Msg, "if");
    //Transmit temp
    i1 => xmit.addInt;
    for (0 => int i; i < float.cap(); i++){
      float[i] => xmit.addFloat;
    }
}

