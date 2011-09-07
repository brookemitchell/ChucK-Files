Sitar s => Gain master => dac;
1.0=> master.gain;

[45,47,58,70,46,46,70,75] @=> int array[];

for (0=> int i; i < array.cap(); i++)
{
    Std.mtof(array[i]) => s.freq;
    1.0 => s.noteOn;
    500::ms => now;
}