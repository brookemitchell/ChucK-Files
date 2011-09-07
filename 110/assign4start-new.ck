326::ms => dur p;                           //Duration Triggering
0 => int q;

"data/ge/kick.wav" => string kick;

SndBuf snd => dac;
kick => snd.read;

[1,0,0,1,0,1,0,0,0,0] @=> int e[];                                          //Arrays for sample triggering
[0,0,1,0,0,0,1,0,0,0] @=> int f[];

//do something crazy to the .freq rate/rate
//oscillate rate between forwards and backwards   
//change playback position
fun void soundbuf(float begin, float end, float grain)
{
    for (begin => float i; i < end; i + grain => i)
    {
        i => snd.freq;
        .02::second => now;
    }
    for (end => float i; i > begin; i - grain => i) 
    {   i => snd.freq;
    .02::second => now; 
    }
}

//sine detune function, oscillate

//sequence map
while (true) 
    {
    for (0 => int i; i<4; i++)
        {
        for (0 => int i; i<16; i++)
            {
            if (e[q] == 1)
                {
                0 => snd.pos;
                q++;
                p/2 => now;
                }
            }
        }
    }
                

