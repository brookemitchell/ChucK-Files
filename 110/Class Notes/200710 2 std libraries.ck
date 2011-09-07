// Standard Libraries
SinOsc s=> dac;

float i;

while (true)
{
    Std.rand2f(-20.1 , 400.67) => float i; //randf random float
    <<<i>>>;
    i => s.freq;
    .5::second => now;
}