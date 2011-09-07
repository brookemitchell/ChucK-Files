SinOsc s => dac;

.5 => s.gain;
440 => s.freq;

[49, 50, 52, 53, 54, 56] @=> int notes[];
[.25, .25, .5, .5, .0125, .0125] @=> float durations[];

while (true){
    for (0 => int i; i < notes.cap(); i++)
    {
       Std.mtof(notes[i]) => s.freq;
       //<<<notes[i]>>>;
       durations[i]::second=> now;
   }
}