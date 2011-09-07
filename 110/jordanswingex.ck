//Swing CMO 110

SndBuf hihat => Gain drumBus => dac;
SndBuf kick => drumBus;

"data/ge/hihat.wav" => hihat.read;
"data/ge/kick.wav" => kick.read;

0 => kick.gain;
0 => hihat.gain;
.6 => drumBus.gain;

//set bpm & time divisions
123.1 => float bpm;
60::second / bpm => dur c;
c /2 => dur q;
q / 2 => dur sq;
sq / 2 => dur dsq;
dsq / 2 => dur hdsq;
hdsq /2 => dur shdsq;
(sq / 2)*1.5 => dur dotdsq;
(dsq / 2)*1.5 => dur dothdsq;
(hdsq /2)*1.5 => dur dotshdsq;

4::q => dur sync;
sync - (now % sync) => now;

spork ~ kickPattern();
spork ~ hatPattern();

while (true) 
{
    
    1::sync => now;    
}

fun void kickPattern()
{
    while (true)
    {
        0 => kick.pos;
        1 => kick.gain;
        1::c => now;
    }    
}

fun void hatPattern()
{
    while (true)
    {
        0 => hihat.pos;
        1 => hihat.gain;
        swing(1::q, 1::shdsq, 1::dsq, .1, "pull") => now;
    }    
}

fun dur swing(dur initial, dur min, dur max, float amt, string pushPull) 
{
    if (pushPull == "push")
    {
        return initial+(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp;
    }
    
    else if (pushPull == "pull")
        
        {
            if (max > initial)
            {
                initial => max;
            }
            return initial - (Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp;    
        }
    }