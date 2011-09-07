VoicForm voc  => Gain g => JCRev r => Dyno Limiter => Gain g2 => dac;
SinOsc s1 => SinOsc s2 => SinOsc s3 => g2;
.9 => g2.gain;
0.3=> g.gain;

//reverb params
.5 => r.gain;
.3 => r.mix;

//feedback
r => Delay d => r;
// make function to Modulate Feedback
Math.sin(.15)*.25=> d.gain;

[45,47,58,70,46,46,70,75] @=> int freq[];
[0,0,1,0,1,0,1,0,1,0,0,0] @=> int sequence[];
[ .0, .1, .2, .3, .4, .5, .2, .0, .0] @=> float groove[];


while (true)
{    
    
    2* Std.rand2(0,2) => voc.phonemeNum;
    Std.rand2f( 0.6, 0.8 ) => voc.noteOn;    
    <<<speakmix(Std.rand2f(0,1))>>>;        
    Std.rand2f(0,1) => voc.pitchSweepRate;         
    Std.rand2f(0,1) => voc.voiceMix;    
    Std.rand2f(600,1000) => voc.vibratoFreq;
    Std.rand2f(0,1) => voc.vibratoGain;
    Std.rand2f(0,1) => voc.loudness;        
    
    for (0=> int i; i < freq.cap(); i++)
    {
        //play
        play(Std.rand2(0,2)*12+freq[i]);
        arpeggio(freq[i]);                
        Std.rand2f(3,7) => float factor;
        .05*factor::second => now;
    }
}

//_____________________________________Functions_____________________________________

//SpeakerMix Function
fun float speakmix (float speak){
    speak => float speakvalue => voc.speak;
    1- speakvalue => voc.quiet;  
    return speakvalue;  
}

//Arpeggiator Function
fun void arpeggio (int rootnote)
{
    [0,4,3,4,5,-5,-4,-3] @=> int arpscale[];
    for ( 0 => int i; i < arpscale.cap(); i++)
    {
        
        Std.mtof(rootnote) => s1.freq => s2.freq => s3.freq; 
        0 => s2.gain => s3.gain;
        .1::second=>now;
        .2 => s2.gain;
        Std.mtof(rootnote + arpscale[i]) => s2.freq => s3.freq;
        .5::second=>now;
        .2=> s3.gain;
        Std.mtof(rootnote + arpscale[i]) => s3.freq;
        .1::second=>now;
    }
}

//control Vibrato Frequency
fun void vibfreq (float vibfreq[]){}

//control Vibrato Frequency
fun void vibgain (float vibgain[]){}

//control Spectral Tilt 
fun void loudtilt (float loudtilt[]){}

//control Vowel/Phenome selection
fun void vowelnome ( int InputArray[]){}

//freq shuffle
fun void play (int note)
{
    freq[Std.rand2(0,freq.cap()-1)] => int freq;
    Std.mtof((Std.rand2(0,2) * 12 + freq )) => voc.freq;
}

//sequence shuffle

//timing shuffle

//Feedback Modulation
