SqrOsc s => dac;
SqrOsc t => dac;

fun float octave(float a)
{
    return (a*2);
}

for (0 => float i; i < 4000; i+.5 => i)
{
    i => s.freq;
    octave(i) => s.freq;
    .001::second => now;
}