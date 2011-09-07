<<< "Allan Brooke Mitchell - Assignment 1" >>>;

TriOsc s => dac;
.2 => s.gain;
20 => int foo;

//for loop
while (foo <400)
{
    foo => s.freq;
    <<<foo>>>;
    .25::second => now;
    foo++;
}