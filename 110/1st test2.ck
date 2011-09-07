<<< "Allan Brooke Mitchell - Assignment 1" >>>;

TriOsc s => dac;
220 => int a;
.2 => float b;

b => s.gain;
a => s.freq;

1::second => dur note;
4::note => dur measure;

0 => int k;

if (k == 1)
{
    1::second => now;
}
else
{
    440 => s.freq;
    4::second => now;
}