SinOsc s => dac;
SinOsc t => dac;
SinOsc u => dac;

fun float octave(float a)
{
    return (a*2);
}

fun float fifth(float a)
{
 return (3*a/2); //fifth = 3 1/2s in harmonic theory   
}

for (0 => float i; i < 4000; i+.5 => i)
{
    i => s.freq;
    octave(i) => t.freq;
    fifth(i) => u.freq;
    .001::second => now;
}