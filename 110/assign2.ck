/* 
Panning and how to move sound from left to right. You should
review the standard library and use tools like random numbers
and STD.mtoF().
*/

//set time
now + 30::second => time later;
276::ms => dur eighth;

//setup oscillators
TriOsc s1 => pan2 p1 => dac;
SinOsc s2 => pan2 p2 => dac;
TriOsc s3 => pan2 p3 => dac;
SinOsc s4 => pan2 p4 => dac;
SinOsc s5 => pan2 p5 => dac;

.2 => s1.gain; 
.3 => s2.gain;
.2 => s3.gain; 
.2 => s4.gain;
.3 => s5.gain;

// detune by midi frequency
s4.freq()  => s5.freq;

//setup chords1
[36, 36, 36, 36, 36, 36, 0, 36,
36, 36, 36, 36, 36, 36, 0, 36,
39, 39, 39, 39, 39, 39, 0, 39,
39, 39, 39, 39, 39, 39, 0, 39,
36, 36, 36, 36, 36, 36, 0, 36,
36, 36, 36, 36, 36, 36, 0, 36,
39, 39, 39, 39, 39, 39, 0, 39,
43, 43, 43, 0, 43, 43, 43, 0] @=> int chords1[];

[39, 39, 39, 39, 39, 39, 0, 39,
39, 39, 39, 39, 39, 39, 0, 39,
43, 43, 43, 43, 43, 43, 0, 43,
43, 43, 43, 43, 43, 43, 0, 43,
39, 39, 39, 39, 39, 39, 0, 39,
39, 39, 39, 39, 39, 39, 0, 39,
43, 43, 43, 43, 43, 43, 0, 43,
46, 46, 46, 0, 46, 46, 46, 0] @=> int chords2[];

[43, 43, 43, 43, 43, 43, 0, 43,
43, 43, 43, 43, 43, 43, 0, 43,
46, 46, 46, 46, 46, 46, 0, 46,
46, 46, 46, 46, 46, 46, 0, 46,
43, 43, 43, 43, 43, 43, 0, 43,
43, 43, 43, 43, 43, 43, 0, 43,
46, 46, 46, 46, 46, 46, 0, 46,
50, 50, 50, 0, 48, 48, 48, 0] @=> int chords3[];

[60, 67, 60, 65, 60, 60, 60, 0,
60, 67, 60, 65, 60, 60, 60, 0,
60, 63, 67, 63, 65, 63, 60, 63,
60, 63, 67, 63, 65, 63, 60, 63,
60, 60, 67, 60, 65, 60, 60, 60,
60, 60, 67, 60, 65, 60, 60, 60,
60, 63, 67, 63, 65, 63, 60, 63,
60, 67, 67, 67, 65, 72, 60, 67] @=> int melody[];

while (now < later){
    for (0 => int i; i < chords1.cap(); i++){
        Std.mtof(chords1[i]) => s1.freq;
        Std.mtof(chords2[i]) => s2.freq;
        Std.mtof(chords3[i]) => s3.freq;
        Std.mtof(melody[i]) => s4.freq;
        eighth => now;
        
        //panning
        Math.sin(now/1::second *2*pi) => p1.pan => p2.pan => p3.pan => p4.pan => p5.pan; 
        10::ms => now;

    }
}
    