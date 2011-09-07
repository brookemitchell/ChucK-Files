<<< "Allan Mitchell - Assignment 5" >>>;

//______________Master Parameters________________________
//One Function Control Physical Model, Other Control Play settings
//Master Out
Gain g => JCRev r => dac;
//Instrument Lineup
VoicForm voc  => g;
//Feedback Line
r => Delay d => r;

//set bpm & time divisions
now + 30::second => time StopTime;
123.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet /2 => dur q;
q / 2 => dur sq;
sq / 2 => dur dsq;
dsq / 2 => dur hdsq;
hdsq /2 => dur shdsq;
(sq / 2)*1.5 => dur dotdsq;
(dsq / 2)*1.5 => dur dothdsq;
(hdsq /2)*1.5 => dur dotshdsq;


//reverb params
.5 => r.gain;
.1 => r.mix;

//Arrays
[.2,.3,.45,.6,.4, .3, .12 ,.12,.43] @=> float modulate[];
[65,57,58,70,76,56,70,75] @=> int freq[];
[0,0,1,0,1,0,1,0,1,0,0,0] @=> int vocseq[];
[dotshdsq, dothdsq, dothdsq, hdsq, dothdsq, dotshdsq, dothdsq, shdsq, hdsq, dotshdsq, dothdsq, dotshdsq, hdsq] @=> dur delaytimes[];

//___________________________________Sequence_____________________________________

while (now < StopTime)
{            
    Std.rand() => float randseq;
    if (randseq > .5)
    {
        ModDelay(Std.rand()*1);    
        ModFeed(.45);    
        FreqSelect(Std.rand()*.5);
        speakmix(Math.sin(pi/2));
        .00001::ms => now;
    }
    else
    {
        ShuffleArrayf(modulate) @=> modulate;
        ShuffleArray(freq) @=> freq;
        ShuffleArray(vocseq) @=> vocseq;
        ShuffleArrayd(delaytimes) @=> delaytimes;
        .00001::ms => now;        
    }
}

//_____________________________________Functions_____________________________________

//SpeakerMix Function
fun float speakmix (float speak){
    speak => float speakvalue => voc.speak;
    1 - speakvalue => voc.quiet;  
    return speakvalue;  
    .00001::ms => now;
}


//Speaking Sequence Function
fun int speak ( int vocseq[])
{
    Std.rand() => int quickrand;
    if (quickrand >.5)
    {
        for (0=> int i; i < vocseq.cap(); i ++)
            vocseq[i] => voc.speak;
        100::ms => now;
    }
    else
    {
        for (0=> int i; i < vocseq.cap(); i ++)
            vocseq[i] => voc.speak;
        1::ms => now;
    }
}

//quick, dirty and slightly bizzare Arpeggiator Function with speak function and phenome selection inside, could be much radder
fun void arpeggio (int rootnote[])
{        
    [7, 4, 3, 4, 5, -5, -4, -3] @=> int arpscale[];
    for ( 0 => int i; i < arpscale.cap(); i++)
    {        
        if (now >= StopTime)
        {
            break;
        }
        Std.mtof(rootnote[i]) => voc.freq;
        Std.rand2(10,128) => voc.phonemeNum;
        speak(vocseq); 
        80::ms=>now;
        Std.mtof(rootnote[i] + arpscale[i]) => voc.freq;
        Std.rand2(10,128) => voc.phonemeNum;
        .2 => voc.pitchSweepRate;
        speak(vocseq); 
        40::ms=>now;
        Std.mtof(Std.ftom(voc.freq())*2 + arpscale[i]) => voc.freq;
        speak(vocseq); 
        4::ms=>now;
        Std.mtof(Std.ftom(voc.freq())/1.5 + arpscale[i]) => voc.freq;
        Std.rand2(10,128) => voc.phonemeNum;
        speak(vocseq); 
        1::ms=>now;
        Std.mtof(Std.ftom(voc.freq())*1.5 + arpscale[i]) => voc.freq;
        speakmix(Std.rand2f(0.6,1));
        speak(vocseq); 
        70::ms=>now;
    }
}

//Frequency Select Function

fun void FreqSelect (float chance)
{
    for (0=> int i; i < freq.cap(); i++)
    {
        
        Std.rand2f(0,1) => float rand;
        chance *=> rand;
        if (rand > .25)
        {        
           
            .7::second => dur T;
            T - (now % T) => now;
            arpeggio(freq);
            Std.rand2f(.1,3) => float factor;
            .0009*factor*T => now;
        }
        else 
        {
            Std.rand2f(1,11)*.2::second => dur T;
            T - (now % T) => now;
            arpeggio(freq);
            T => now;
        }              
    }
}

//Modulate Delay Time

fun void ModDelay (int starttime){
    
    for (starttime => int i; i < delaytimes.cap(); i++)
    { 
        delaytimes[i] => d.delay;
        10::ms => now;
    }
}

// Modulate Feedback
fun void ModFeed (float factor)
{
    for (0 => int i; i < modulate.cap(); i++)
    {
        Math.sin(modulate[i])*factor=> d.gain;
        10::ms => now;
    }
}

//Shuffle Function (thanks Luke!)
fun int[] ShuffleArray (int InputArray[])
{
    //  int NewArray[];
    InputArray @=> int NewArray[];
    
    for (InputArray.cap() -1 => int n; n > -1; n--)
    {
        Std.rand2(0, n) => int ChangeIndex;
        InputArray[ChangeIndex] => int a;
        InputArray[n] => int b;
        a => InputArray[n];
        b => InputArray[ChangeIndex];
    }
    return NewArray;
}

//Shuffle Float Function  (why can't you function overload different var types?)
fun float[] ShuffleArrayf (float InputArray[])
{
    //  int NewArray[];
    InputArray @=> float NewArray[];
    
    for (InputArray.cap() -1 => int n; n > -1; n--)
    {
        Std.rand2(0, n) => int ChangeIndex;
        InputArray[ChangeIndex] => float a;
        InputArray[n] => float b;
        a => InputArray[n];
        b => InputArray[ChangeIndex];
    }
    return NewArray;
}
//Shuffle Dur Function 
fun dur[] ShuffleArrayd (dur InputArray[])
{
    //  int NewArray[];
    InputArray @=> dur NewArray[];
    
    for (InputArray.cap() -1 => int n; n > -1; n--)
    {
        Std.rand2(0, n) => int ChangeIndex;
        InputArray[ChangeIndex] => dur a;
        InputArray[n] => dur b;
        a => InputArray[n];
        b => InputArray[ChangeIndex];
    }
    return NewArray;
}