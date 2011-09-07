SinOsc s => dac;
.5 => s.gain;

[54,56,59,55] @=> int notes[];

for (0 => int i; i < notes.cpp(); i++)
{
    Std.mtof(notes [i}) => s.freq;
    .25::second => now;
    Std.mtof(octave(notes[i])) => s.freq;
    .25::second => now;
}

fun int octave(int x)
{
    return (x + 12);    
}

//return array as function return to make arppeg eg