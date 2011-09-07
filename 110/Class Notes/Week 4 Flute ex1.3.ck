Flute flute => PoleZero f => JCRev r => Gain master => dac;
0.6=> master.gain;

//reverb params
.75 => r.gain;
.1 => r.mix;
1 => f.blockZero;

[45,47,58,70,46,46,70,75] @=> int array[];

while (true)
{    
    flute.clear(1.0);
    
    Std.rand2f(0,1) => float f => flute.jetDelay;
    Std.rand2f(0,1) => float g=> flute.jetReflection;
    Std.rand2f(0,1) => flute.endReflection;
    Std.rand2f(0,1) => flute.noiseGain;
    Std.rand2f(0,1) => flute.pressure;    
    // Std.rand2f(0.3, 1.0) => flute.lip;
    //   int rand => flute.slide;
    Std.rand2f (0,12) => flute.vibratoFreq;
    Std.rand2f (.5,1) => flute.vibratoGain;
    //  Std.rand2f (0,1) => flute.volume; //stk's often have mult volume setting points
    
    <<<"Jet Delay:", f, "Reflection:", g>>>;
    
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
    Std.mtof(note)*2 => flute.freq;
    velocity => flute.noteOn;
}