Brass brass => JCRev r => Gain master => dac;
1.0=> master.gain;

//reverb params
.75 => r.gain;
.1 => r.mix;

[45,47,58,70,46,46,70,75] @=> int array[];

while (true)
{
    Std.rand2f(0.3, 1.0) => brass.lip;
    int rand => brass.slide;
    Std.rand2f (0,12) => brass.vibratoFreq;
    Std.rand2f (0,1) => brass.vibratoGain;
    Std.rand2f (0,1) => brass.volume; //stk's often have mult volume settin points
    
    for (0=> int i; i < array.cap(); i++)
    {
        //play
        play(array[i], Std.rand2f(.2,.9));
        300::ms => now;
    }
}

//_____________________________________Functions_____________________________________
    
    fun void play (int note, float velocity)
    {
        Std.mtof(note)*2 => brass.freq;
        velocity => brass.noteOn;
    }