//Swing Function

SndBuf hat => Gain master => dac;
SndBuf kick => master;

"data/ge/hihat.wav" => string filehat;
filehat => hat.read;
"data/ge/kick.wav" => string filekick;
filekick => kick.read;

0.6  => master.gain;

0 => int inc;
.66 => float n;
150 => int myTime;

1.0 => hat.gain;
1.0 => kick.gain;

((myTime * n) $ int) =>  n;

while (true)
{
//    i%4 = int inc;
    0 => hat.pos;
    0 => kick.pos;
    Std.rand2 ( 0,15) => int r;
    Std.rand2f(.5,1.5) => hat.rate;
    
    if (inc == 0)
    {
        (myTime - n ) ::ms => now;        
    }
    
    else if (inc == 1)
    {
        //beat 3
        ((myTime  + n + (n * 0.8))  $ int ) ::ms => now;
        
    }
    else if (inc == 2)
        
    {        
        //beat 4 
        ((150 - n - ( n * 0.8)) $ int)::ms => now;
        
    }    

    else if (inc == 3)
        {
            0 => kick.pos;
            (myTime + n)::ms => now;
            
    }
    inc++;
    
}

// add extra offset forth note
