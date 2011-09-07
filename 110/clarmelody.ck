[64, 66, 67, 72, 62, 64, 66, 71, 71, 60, 62, 64, 69, 59, 61, 63, 67, 64, 66, 67] @=> int melody[];
TIME bpm;
JAZZATRON jazz;

fun void clarmelody()
{    
    for (0 => int i ; i < melody.cap(); i++)
    {
        jazz.ShuffleArray(melody) @=> melody;
        Std.mtof(melody[i]) => clar.freq;
        .5=> clar.startBlowing;
        1 => clar.noteOn; 
        <<<melody[i]>>>;
        swing(3::bpm.myDurations["dEighth"], 1::bpm.myDurations["sixtyfourth"], 1::bpm.myDurations["tSixteenth"], Std.rand2f(0.1, 0.4), "push") => now;  
        1 => clar.stopBlowing;
        
    }
}