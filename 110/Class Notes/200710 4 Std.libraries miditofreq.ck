//Midi to Frequency

TriOsc t => dac;
.2 => t.gain;
float k;


for (1 => int i; i <127; i++)
{
    Std.mtof(i) => k;
    <<<k>>>;
    k => t.freq;
    200::ms => now;
}