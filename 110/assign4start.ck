"data/ge/kick.wav" => string kick;

SndBuf snd => dac;
kick => snd.read;

SinOsc sin => dac;

[60, 62, 63, 65, 63, 64, 65, 58, 57] @=> int A[];

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
    for ( end => float i; i > begin; i - grain => i) //only in each for loop
    {   i => s.gain;
    .02::second => now;
}}

//fun void oscillator(,)
//{
   // modulate, do something weird with .width on Saw
//    }

//fun void timing (,)
//{
    
//    }

