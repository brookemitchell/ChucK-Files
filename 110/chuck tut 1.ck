//make our patch
SinOsc s => dac;

//time-loop, in which Osc's frequency is changed evry 100ms
while ( true ) 
{
    200::ms => now;
    Std.rand2f(30.0, 1000.0) => s.freq;
}
