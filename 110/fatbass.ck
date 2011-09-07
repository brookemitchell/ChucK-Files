//make a phat bass

PulseOsc p1 => Gain g => LPF lpf => Dyno comp => Delay d => dac;
PulseOsc p2 => g;
PulseOsc p3 => g;
0 => p1.gain => p2.gain => p3.gain;

SinOsc lfo1 => blackhole;
SinOsc lfo2 => blackhole;
SinOsc lfo3 => blackhole;
Envelope e => blackhole;

e.target(40000);
e.time(1);

1000 => lfo1.gain => lfo2.gain =>lfo3.gain;

.2 => g.gain;
10::ms => d.delay;

[33, 55, 17, 41, 39] @=> int scale[];

//filter Settings

detunelfo(10, -10);
play(scale, 31, 41);

// mod pulsewidth. Keep sending data out from lfo while patch running. (Put lfo Assigns Here)
while(1) 
{
    lfo1.last() + 1900 => p1.width;   
    lfo2.last() + 900 => p2.width;  
    lfo3.last() + 900 => p3.width;  
    Math.sin(1)*1000 => lpf.freq;
    
}

//play notes detune each
fun void play(int note[], int det1, int det2) 
{
    for (0=> int i; i< scale.cap(); i++)
    {          
        1 => lfo1.freq => lfo2.freq =>lfo3.freq;
        Std.mtof(note[i]) => p1.freq;
        Std.mtof(note[i]-12) + det1 => p2.freq;
        Std.mtof(note[i]-12) + det2 => p3.freq;
        1 => p1.gain => p2.gain => p3.gain;
        1::second => now;
        0 => p1.gain => p2.gain => p3.gain;
        1::ms => now;
        
    }
}

//detune lfos
fun void detunelfo(float p1, float p2)
{
    lfo2.freq() + p1 => lfo1.freq;
    lfo3.freq() + p2 => lfo2.freq;
}