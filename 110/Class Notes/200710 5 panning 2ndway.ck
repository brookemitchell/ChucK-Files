// Panning - Two Ways - 2nd Way

SinOsc s => pan2 p => dac;

1.0 => float i;

while (i > -1.0)
{
    i => p.pan;
    .01::second => now;
    i-.01;
    <<<i>>>;
}
    