<<< "Allan Brooke Mitchell - Assignment 1" >>>;

TriOsc s => dac;
.2 => s.gain;

//for loop
for (20 => int foo; foo < 400; foo++)
{
    foo=> s.freq;
    <<<foo>>>;
    .1::second => now;
}