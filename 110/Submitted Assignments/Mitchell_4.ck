<<< "Allan Mitchell - Assignment 4" >>>;
<<< "Recursive Rave" >>>;

//====Mixer=====
SndBuf bufkick => Gain masterg => dac;
SndBuf bufsnarehop => Pan2 p => masterg;
SinOsc s => masterg;

//=====PATHS=====
"data/ge/kick.wav" => string kick;
"data/ge/snare-hop.wav" => string snarehop;

// ===Initialize Soundbuf===
kick => bufkick.read;
snarehop => bufsnarehop.read;
0 => bufkick.gain => bufsnarehop.gain => s.gain;

//-===Variables===-
//Time
now + 30::second => time later;
143.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet / 2.0 => dur quaver;
crotchet / 4.0 => dur semiquaver;
bufkick.samples() => int kicklength;

//-===========Arrays=========- 
//SndBuf Array
[.14, 13, 1.36,.347,.520] @=>float snarerate[];

//----------------------Sequence--------------------------
//Intro     
for (0 => int x; x < 1; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if( i == 0 || i == 4 || i == 8 || i == 12)
        {
            kickbasic (100, .5, 0, 3, .1 );
            crotchet => now;
        }
    }
}
//Break 1     
for (0 => int x; x < 2; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if(i == 1 || i == 2 || i == 3 || i == 6 || i == 8 || i == 10 || i == 12 || i == 14)
        {
            kickbasic (90, .4, 0, 0.7, .09);
            semiquaver => now;                     
            sinoscfact (39);            
            
        }
        //Snare
        else
        {
            snarebasic (410, .2, Std.rand2f(.0001, .002));            
            sinoscfact (63);
            semiquaver => now;            
        }
    }
}
//Next Steady
for (0 => int x; x < 1; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if( i == 0 || i == 4 || i == 8 || i == 12)
        {
            kickbasic (0, .4, 0.01, 1, 13.1);
            semiquaver => now;                        
            sinoscfact (63);
            
        }
        //Snare
        else
        {
            snarebasic (20, Std.rand2f(.1, .2), .0005);
            semiquaver => now;            
            sinoscfact (58);            
        }
    }
}
//Break 2     
for (0 => int x; x < 2; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if(i == 1 || i == 2 || i == 4 || i == 6 || i == 8 || i == 10 || i == 12 || i == 14)
        {
            kickbasic (0,.4, 0.1, 9, .01);
            semiquaver => now;
            sinoscfact (58);                       
        }
        //Snare
        else
        {
            snarebasic (Std.rand2(2120,4000), .1, .0005);
            semiquaver => now;            
            sinoscfact (61);                        
        }
    }
}
//Next Steady
for (0 => int x; x < 2; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if( i == 1 || i == 2 || i == 4 || i == 8 || i == 12)
        {
            kickbasic (1000, .01, 0.5, 2, .1);
            semiquaver => now;                       
            sinoscfact (56);                        
        }
        //Snare
        else
        {
            snarebasic (20, Std.rand2f(0, .1), .0002);
            semiquaver => now;            
            sinoscfact (63);                        
        }
    }
}
//Quiet     
for (0 => int x; x < 1; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if( i == 0  || i == 12 || i == 13|| i == 14 || i == 15|| i == 16 )
        {
            kickbasic (0, .4, 1, Std.rand2f(.092, .1), .3);
            semiquaver => now;
        }
        else
        {            
            sinoscfact (58);            
            quaver => now;            
        }
    }
}
//One Last Break
for (0 => int x; x < 2; x++)
{
    //16 beat division
    for (0 => int i; i < 16; i++)
    {
        //Kick
        if(i == 0 || i == 10 || i == 12 || i == 14|| i == 15|| i == 16)
        {
            kickbasic (10, .4, 0.5, 5, .1);
            sinoscfact (58);
            quaver => now;            
        }
        //Snare
        else
        {
            snarebasic (Std.rand2(2120, 40000), .1, .0005);
            sinoscfact (61);
            semiquaver => now;            
        }
    }
}

//-----------------------------Functions ---------------------------------
fun void kickbasic ( int kickpos, float kickgain, float kickbegin, float kickend, float kickgrain)
{
    kickgain => bufkick.gain;
    kickpos => bufkick.pos;
    //quick rate ramp, I'm tired
    for (kickbegin => float i; i < kickend; i+kickgrain => i)
    {
        i => bufkick.rate;
        .0009::ms => now;          
    }
}

fun void snarebasic (int snarepos, float snaregain, float changegrain)
{
    snarepos => bufsnarehop.pos;
    snaregain => bufsnarehop.gain;
    Std.rand2f(-1 , 1) => p.pan;
    //something pretty similar, ah well.
    for (0 => int i; i < snarerate.cap(); i++)
    {
        snarerate[i] => bufsnarehop.rate;
        changegrain::second => now;
    } 
}
//factorial sin wave, this is cool.
fun float sinoscfact (int pitchstart)
{    
    float out;
    if (pitchstart <= 1)
    {
        1 => out;
    }
    else {
        (pitchstart*sinoscfact(pitchstart-1)) => out;
    }
    out => float freq;
    
    Std.mtof(pitchstart) => s.freq;    
    
    1::ms => now;
    .2 => s.gain;
    
    return out;
}
