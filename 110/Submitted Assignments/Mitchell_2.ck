<<< "Allan Mitchell - Assignment 2" >>>;

//set times
now + 30::second => time later;
223::ms => dur eighth;

//setup oscillators
TriOsc s1 => Pan2 p1 => dac;
SinOsc s2 => Pan2 p2 => dac;
TriOsc s3 => Pan2 p3 => dac;
SinOsc s4 => Pan2 p4 => dac;
SinOsc s5 => Pan2 p5 => dac;

//set gains
.2 => s1.gain; 
.2 => s2.gain;
.2 => s3.gain; 
Std.rand2f(.1,.2) => s4.gain;
Math.sin(.1) => s5.gain;

// detune randomly by up to 25hz
s4.freq() - Std.rand2(0,25) => s5.freq;

//setup bass note of chord
[36, 36, 36, 36, 36, 36, 0, 36,
36, 36, 36, 36, 36, 36, 0, 36,
39, 39, 39, 39, 39, 39, 0, 39,
39, 39, 39, 39, 39, 39, 0, 39,
36, 36, 36, 36, 36, 36, 0, 36,
36, 36, 36, 36, 36, 36, 0, 36,
39, 39, 39, 39, 39, 39, 0, 39,
43, 43, 43, 0, 43, 43, 43, 0] @=> int chords1[];

//create melody
[60, 67, 60, 65, 60, 60, 60, 0,
60, 67, 60, 65, 60, 60, 60, 0,
60, 63, 67, 63, 65, 63, 60, 63,
60, 63, 67, 63, 65, 63, 60, 63,
60, 60, 67, 60, 65, 60, 60, 60,
60, 60, 67, 60, 65, 60, 60, 60,
60, 63, 67, 63, 65, 63, 60, 63,
60, 67, 67, 67, 65, 72, 60, 67] @=> int melody[];

[.25, .25, .5, .5, .0125, .0125] @=> float durations[];

//play chords by adding a 3rd and 7th to bass note, with melody and panning
while (now < later){
    for (0 => int i; i < chords1.cap(); i++){
        if (now >= later) {break;}
        
        //Panning Osc's 1-3 (chords) (leaving the slight pops in since i like them)
            Math.sin(now/29::second *2*pi) => p1.pan => p2.pan => p3.pan;
            //Panning Osc's 4-5 (melody)
            Math.cos(now/.001::second *2*pi) => p4.pan => p5.pan;
            .01::ms => now; 
            
            //play chords and melody on eigths
            Std.mtof(chords1[i]) => s1.freq;
            Std.mtof(chords1[i]+3) => s2.freq;
            Std.mtof(chords1[i]+7) => s3.freq;
            Std.mtof(melody[i]) => s4.freq;
            eighth => now;
            }           
}