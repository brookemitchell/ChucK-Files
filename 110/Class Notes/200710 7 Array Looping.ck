//Array Looping

SinOsc s => dac;
.2 => s.gain;

[54,56,62,54,48,50,52,0,0,54,56,56] @=> int foo[]; // 2nd way
// store timing - new addittion ffloat multiply!
[.5,.2,.4,.6,.5,.3,.4,.7] @=> float A[];

for (0 => int i; i < A.cap(); i++) //use foo.cap() to input size of array, counting is crappy programming
{
    <<<i, foo[i]>>>;
    std.mtof(foo[i]) => s.freq; 
    Std.rand2f(.2, .6) => s.gain;
    A[i]::second => now;
}