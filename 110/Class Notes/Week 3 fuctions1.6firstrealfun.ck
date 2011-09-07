SinOsc s => dac;

[60, 62, 63, 65, 63, 64, 65, 58, 57] @=> int A[];

fun void swell(float begin, float end, float grain)
{
 for (begin => float i; i < end; i + grain => i) ///match types (float)
{
    i => s.gain;
    .01::second => now;
}}

for (0 => int i; i < A.cap(); i++)
{
    Std.mtof(A[i]) => s.freq;
    swell(.1,.8,.01);
    1::second => now;
}