//set bpm &  time divisions
123.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet * 4.0 => dur bar;
crotchet / 4.0 => dur semiquaver;

"data/ge/snare-hop.wav" => string snarehop;
SndBuf bufsnarehop => dac;
snarehop => bufsnarehop.read;
.5 => bufsnarehop.gain;

int snarepitch[0];
0=> int barcounter;

while (barcounter < 2)
{
    if (barcounter == 0)
    {        
        snaretune(1);
    } 
    else if (barcounter == 1)
    {
        snaretune(12);
    }
    
    for (0 => int i; i < snarepitch.cap(); i++)
    {
        0 => bufsnarehop.pos;
        .5 => bufsnarehop.gain;
        <<< snarepitch[i] >>>;
        Std.mtof(snarepitch [i]) => bufsnarehop.freq;
        semiquaver => now;
        
    }        
    barcounter ++;
}
///New Functions
//SndBuf Function
//Take frequency

fun void snaretune (int x)
{
    snarepitch << x << x+5 << x+12;
}