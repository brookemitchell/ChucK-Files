//Basic FM synth
SinOsc m => SinOsc c => dac;

//carrier frequency
220 => c.freq;
//modulation frequency
20 => m.freq;
//index of modulation
200 => m.gain;

//phase mod to make FM
2 => c.sync;

while(true){
    1::second => now;
}