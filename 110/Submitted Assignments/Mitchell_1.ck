<<<"Allan Brooke Mitchell - Assgnment 1">>> ;

//Set the time limit for composition
now + 30::second => time later;

//initialise variables
.8::second => dur sync;
23 => int detune;
0.0 => float v;

//Patch Oscillators to Audio Out
SawOsc s1 => dac;
SawOsc s2 => dac;

//set gain of each oscillator
0.25 => float gain;
gain => s1.gain => s2.gain;

//apply detune between sine 1 frequency and sine 2 frequency
s1.freq() - detune => s2.freq;

//compostion begins
while ( now < later ) 
{
   //synchronize to period of .8 second
   sync - (now % sync) => now;
   
   // oscillate frequency of sine.1 by sine function
   Std.fabs(Math.sin(v)) * 150.0 => s1.freq;
   // increment oscillation
    v + .35 => v;
    
   //set sine.2 to random frequency from 200 to 270hz
   Std.rand2f(200.0, 270.0) => s2.freq;
   
   //advance time by 250 ms 
   250::ms => now; 
   
   //if sine 2 frequency is above 240hz add higher oscillating tone to sine 2
         if (s2.freq() > 250)
    {
        for (1 => int beep; beep < 33; beep++)
        {
            s2.freq() + Std.fabs(Math.sin(beep)) * 1.5 => s2.freq;
            2.3::ms => now;
        }
    }
    //otherwise set sine2.frequency to half of sine1.frequency
    else
    {
          s1.freq() /2 => s2.freq;
    }
}
