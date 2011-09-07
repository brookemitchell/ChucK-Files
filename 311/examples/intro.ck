// Sound Network
SndBuf snd => Pan2 p => Envelope e => dac;
0.6 => snd.gain; // initialize volume

// Object Initialization
GameTrak g;
g.init(0);

// Max # of soundFiles
3 => int maxR; 

// Store all filenames in Recordings Array
string recordings[maxR];

"compositions/GameTrak2011/data/waves.wav" => recordings[0]; 
"compositions/GameTrak2011/data/drip.wav" => recordings[1]; 
"compositions/GameTrak2011/data/rain.wav" => recordings[2]; 


// Envelope Parameters
500::ms => e.duration;

// Sound Player
fun void play(SndBuf@ x)
{
    while (true)
    {           
        // Control which file played
        recordings[Std.rand2(0, maxR-1)] => x.read;
        
        e.keyOn();
                
        // play
        0 => x.pos;
        Std.rand2f(8, 10) => float t;
        t:: second => now;
        
        e.keyOff();
        500::ms => now;        
    }
}


fun void rateControl(SndBuf@ x)
{
    while (true)
    {
        // Control Rate
        g.aY => x.rate;
        20::ms => now;    
    }  
}



fun void PanControl()
{
    while (true)
    {
        // Control Rate
        g.aX => p.pan;
        20::ms => now;    
    }  
}

fun void VolumeControl(SndBuf@ x)
{
    while (true)
    {
        // Control Rate
        1.0 - g.aZ => x.gain;
        20::ms => now;    
    }  
}

spork ~ play(snd);
spork ~ rateControl(snd);
spork ~ VolumeControl(snd);
spork ~ PanControl();


while (true)
{
    1::minute => now;   
}