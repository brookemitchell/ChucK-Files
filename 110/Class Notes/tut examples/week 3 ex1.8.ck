SndBuf kick => dac;
"data/ge/kick.wav" => kick.read;

0 => kick.gain;

while (true)
{
    0 => kick.pos;
    swell(.1,1,.001);
    .5 => kick.gain;
    1::second => now;
}

//functions
fun void swell(float begin, float end, float grain)
{
    for(begin => float j; j < end; j+grain => j)
    {
     //           0 => kick.pos;
        j => kick.rate;
        2::second => now;
    }
    
    for (end => float j; j > begin; j-grain => j)
    {
        0 => kick.pos;
        j => kick.rate;
        .002::second => now;
    }
    
    .1 => kick.rate
}