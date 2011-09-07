SinOsc s => dac;

.5 => s.gain;
440 => s.freq;
int jordan;

[49, 50, 52, 53, 54, 56] @=> int notes[];

while (true){
    for (0 => int i; i < notes.cap(); i++)
    {
       Std.mtof(notes[Std.rand2(0, 5)]) => s.freq;
       <<<notes[i]>>>;
       .25::second=> now;
   }
}