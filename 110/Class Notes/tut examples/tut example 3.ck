SinOsc s => dac;
SinOsc s2 => dac;

.5 => s.gain;
440 => s.freq;

[49, 50, 52, 53, 54, 56] @=> int notes[];
[.25, .25, .5, .5, .0125, .0125] @=> float durations[];
[.5, .5, .5, .5, .0125, .0125] @=> float durations2[];

for (0 => int i; i < notes.cap(); i++)
{
    Std.mtof(notes[i]) => s.freq;
    Std.mtof(notes[i]+5) => s2.freq;
    //<<<notes[i]>>>;
    durations2[i]::second=> now;
}

for (0 => int i; i < notes.cap(); i++)
{
    Std.mtof(notes[i]) => s.freq;
    Std.mtof(notes[i]+5) => s2.freq;
    //<<<notes[i]>>>;
    durations2[i]::second=> now;
}