// Sound Network
SndBuf kick => Gain master => dac;
SndBuf hihat => master;
SndBuf snare => master;

// Object Initialization
GameTrak g;
g.init(0);

// Load Sound Files
"compositions/GameTrak2011/data/beats/hh_04.wav" => hihat.read; 
"compositions/GameTrak2011/data/beats/kick_03.wav" => kick.read; 
"compositions/GameTrak2011/data/beats/snare_04.wav" => snare.read; 

// Take away sound from Beginning
kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;

// Array of Sequence - 1 to trigger, 0 to rest
[1,0,1,0,1,0,1,0] @=> int kickpattern01[];
[1,0,1,0,1,0,1,0] @=> int kickpattern02[];
[0,0,1,0,0,0,1,0] @=> int snarepattern01[];
[0,0,1,0,0,0,1,1] @=> int snarepattern02[];
[0,1,0,1,0,1,0,1] @=> int hihatpattern01[];
[0,1,0,1,0,1,1,1] @=> int hihatpattern02[];


// Sound Player
fun void play(int kickarray[], int snarearray[], int hihatarray[], float beattime)
{
    for (0 => int i; i < kickarray.cap(); i++)
    {           
        if (kickarray[i] == 1)
        {
            0 => kick.pos;
        }
        
        if (hihatarray[i] == 1)
        {
            Std.rand2(0,hihat.samples()/2) => hihat.pos;
        }
        
        if (snarearray[i] == 1)
        {
            Std.rand2(0,snare.samples()/2) => snare.pos;
        }
        
        beattime:: second => now;       
    }           
}


fun void HihatrateControl(SndBuf@ x)
{
    while (true)
    {
        // Control Rate
        (g.aY+1.0) => x.rate;
        20::ms => now;    
    }  
}

fun void SnarerateControl(SndBuf@ x)
{
    while (true)
    {
        // Control Rate
        (g.bY+1.0) => x.rate;
        20::ms => now;    
    }  
}


fun void VolumeControl()
{
    while (true)
    {
        // Control Rate
        1.0 - g.aZ => master.gain;
        20::ms => now;    
    }  
}



spork ~ HihatrateControl(hihat);
spork ~ SnarerateControl(snare);
spork ~ VolumeControl();


// COMPOSITION

// Groove 1
for (0 => int i; i < 4; i++)
{
    play(kickpattern01,snarepattern01,hihatpattern01,.4);
}

// Groove 2
for (0 => int i; i < 10; i++)
{
    play(kickpattern01,snarepattern01,hihatpattern01,.2);
    play(kickpattern02,snarepattern02,hihatpattern02,.2);
}

// Groove 3
for (0 => int i; i < 10; i++)
{
    play(kickpattern01,snarepattern01,hihatpattern01,.1);
    play(kickpattern02,snarepattern02,hihatpattern02,.1);
}


