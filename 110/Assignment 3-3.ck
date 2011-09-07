<<< "Allan Mitchell - Assignment 4" >>>;


//Bassline Eb minor pentatonic scale Array midi
[51, 54, 56, 58, 61,  63] @=> int scale[]; 

//Time
now + 1::minute => time later;

//set bpm &  time divisions
193.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet * 4.0 => dur bar;
crotchet / 4.0 => dur semiquaver;

//Mixer
SndBuf bufkick => Pan2 pkick => dac;
SndBuf bufsnarehop => Pan2 psnarehop => dac;

//PATH
"data/ge/kick.wav" => string kick;
"data/ge/snare-hop.wav" => string snarehop;

// Initialize buf
kick => bufkick.read;
snarehop => bufsnarehop.read;

0 => bufkick.gain => bufsnarehop.gain;

bufkick.samples() => int numbersamples;

    //Part A     
    //number of times looped
    for (0 => int x; x < 1; x++)
    {
        //16 beat division
        for (0 => int i; i < 16; i++)
        {
            //Kick
            if( i == 0 || i == 4 || i == 8 || i == 12)
            {
                kickbasic (0,0.4,1);
                crotchet => now;
            }
            //Snare
            if( i == 3 || i == 7 || i == 11 || i == 14 )
            {
                snarebasic (0,0.4,1);
                crotchet => now;
            }
        }
    }
    
    //-----------------------------Functions 
    fun void kickbasic (int kickpos, float kickgain, float kickrate)
    {
        kickpos => bufkick.pos;
        kickgain => bufkick.gain;
        kickrate => bufkick.rate;
    }
    
    fun void snarebasic (int snarepos, float snaregain, float snarerate)
    {
        snarepos => bufsnarehop.pos;
        snaregain => bufsnarehop.gain;
        snarerate => bufsnarehop.rate;
    }