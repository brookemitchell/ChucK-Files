//Set the time limit for composition
30::second => dur t;
t + now => time later;

//Patch Oscillators to Audio Out
SawOsc s1 => dac;
SawOsc s2 => dac;

//set gain of each oscillator
0.25 => float gain;
gain => s1.gain => s2.gain;

//set detune amount and apply
3 => int detune;
s1.freq() - detune => s2.freq;

//time-loop, in which Osc's frequency is changed evry 100ms
while ( now < later ) 
{
   500::ms => now;
   Std.rand2f(150.0, 260.0) => s1.freq;
   800::ms => now;
   Std.rand2f(100.0, 200.0) => s2.freq;

    if (s2.freq() > 150)
    {
        for (1 => int whizz; whizz < 17; whizz++)
        {
            s2.freq() + whizz => s1.freq;
            <<<whizz>>>;
            0.25::ms => now;
        }
    }
    else
    {
          s2.freq() /2 => s1.freq;
    }
}
