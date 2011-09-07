VoicForm voc  => Gain g => JCRev r => Dyno Limiter =>  dac;
0.3=> g.gain;

//reverb params
.5 => r.gain;
.3 => r.mix;

//feedback
r => Gain g2 => r;
//Modulate Feedback
.15=> g2.gain;

[45,47,58,70,46,46,70,75] @=> int array[];


while (true)
{    
    2* Std.rand2(0,2) => voc.phonemeNum;
    Std.rand2f( 0.6, 0.8 ) => voc.noteOn;
    //    Std.rand2f(0,1) 
    
    <<<speakmix(Std.rand2f(0,1))>>>;
    
    //    Std.rand2f (0,1) => voc.quiet; 
    
    Std.rand2f(0,1) => voc.pitchSweepRate; 
    
    
    Std.rand2f(0,1) => voc.voiceMix;    
    Std.rand2f(600,1000) => voc.vibratoFreq;
    Std.rand2f(0,1) => voc.vibratoGain;
    Std.rand2f(0,1) => voc.loudness;        
    
    for (0=> int i; i < array.cap(); i++)
    {
        //play
        play(Std.rand2(0,2)*12+array[i]);
        Std.rand2f(1,4) => float factor;
        .05*factor::second => now;
    }
}

//_____________________________________Functions_____________________________________


fun float speakmix (float speak){
    speak => float speakvalue => voc.speak;
    1- speakvalue => voc.quiet;  
    return speakvalue;  
}

fun void control ( int InputArray[])
{
}

fun void play (int note)
{
    array[Std.rand2(0,array.cap()-1)] => int freq;
    Std.mtof((Std.rand2(0,2) * 12 + freq )) => voc.freq;
}