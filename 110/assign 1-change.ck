//Set the time limit for composition
now + 30::second => time later;

//initialise variables
.5::second => dur T; //name better
1::ms => dur x;
0.0 => float v;

//initialize detune amount variable
123 => int detune;

//Patch Oscillators to Audio Out
SawOsc s1 => dac;
SawOsc s2 => dac;

//set gain of each oscillator
0.25 => float gain;
gain => s1.gain => s2.gain;

//apply detune between sine 1 frequency and sine 2 frequency
s1.freq() - detune => s2.freq;

//compostion begins, in which Osc's frequency is changed evry 250ms
while ( now < later ) 
{
   //advance time by 250 ms and synchronize to period of .5 second
   450::ms => now; 
   T - (now % T) => now;
   
   // oscillate frequency of sine wave 1 by sine
   Std.fabs(Math.sin(v)) * 100.0 => s1.freq;
   // increment v
    v + .05 => v;
    
    //set sine.2 to random frequency
   Std.rand2f(200.0, 270.0) => s2.freq;
   //if above 230hz add oscillating tone to s2.freq
   if (s2.freq() > 230)
    {
        for (1 => int whizz; whizz < 17; whizz++)
        {
            s2.freq() + Std.fabs(Math.sin(whizz)) * 23.0 => s2.freq;
            0.125::ms => now;
        }
    }
    //otherwise set sine2.frequency to half of sine1.frequency
    else
    {
          s1.freq() /2 => s2.freq;
    }
}
