//set times
now + 30::second => time later;
223::ms => dur eighth;
.25::eighth => dur thirtysecond;

//float snaregain[];

//setup oscillators
TriOsc s1 => Pan2 p1 => dac;
SinOsc s2 => Pan2 p2 => dac;
TriOsc s3 => Pan2 p3 => dac;
SinOsc s4 => Pan2 p4 => dac;
SinOsc s5 => Pan2 p5 => dac;
Noise snare => Pan2 p6 => dac;

//set gains
.2 => s1.gain; 
.2 => s2.gain;
.2 => s3.gain; 
Std.rand2f(.1,.2) => s4.gain;
Math.sin(.1) => s5.gain;
0 => snare.gain;

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

//create snare drum pattern

[
0.12 , 0.0 , 0.0 , 0.0,
 0.0 , 0.0 , 0.0 , 0.0,
  0.0 , 0.0 , 0.0 , 0.0,
   0.0 , 0.0 , 0.0 , 0.0   
] @=> float snaregain[];


//play chords by adding a 3rd and 7th to bass note, with melody and panning
while (now < later){
    for (0 => int i; i < chords1.cap(); i++){
        if (now >= later) {break;}
            Std.mtof(chords1[i]) => s1.freq;
            Std.mtof(chords1[i]+3) => s2.freq;
            Std.mtof(chords1[i]+7) => s3.freq;
            Std.mtof(melody[i]) => s4.freq;
            eighth => now;
            
            for (0 => int i; i < snaregain.cap(); i++){
                snaregain[i] => snare.gain;
                .07::ms => now;
//                eighth => now;
            }
        }
            //panning
            Math.sin(now/.01::second *2*pi) => p1.pan => p2.pan => p3.pan;
            Math.cos(now/.001::second *2*pi) => p4.pan => p5.pan;
            10::ms => now; 
}

//            if (
//            snaregain[i] => snare.gain;
//            thirtysecond => now;

//noise snare drum on 2+4 of 2nd 8 bars
//        for (0 => int i; i < snaregain.cap(); i++){