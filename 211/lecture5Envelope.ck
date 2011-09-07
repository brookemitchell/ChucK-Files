Noise n => Enveope e => dac;

while(true)
{
    Std.rand2f(10,50)::ms => e.duration // rise/fall
    e.keyOn(); //Start Attack
    800::ms => now; //From begnning
    e.keyOff(); //start release
    800::ms => now;
}

//i cubed secret society ramp up = wayyyyy better