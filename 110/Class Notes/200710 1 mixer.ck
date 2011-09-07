//remember to control volumes

SinOsc => dac;
SqrOsc => dac;

//Only play s
.5 => s.gain
0 => t.gain

for (0 => int i,  i < 500, i++)
{
    i => s.freq;
    .001::second => now;
}

//Only play t
0 => s.gain
0.5 => t.gain

for (0 => int i,  i < 500, i++)
{
    i => t.freq;
    .001::second => now;
}
