TIME bpm;
JAZZATRON jazz;

[57, 62, 55, 60, 66, 59, 64, 64, 59, 64, 64, 66, 59, 64, 64, 57, 62] @=> int roots[]; 
["minor", "dominant", "major", "major", "minor", "dominant", "dominant", "dominant", "dominant", "dominant", "dominant", "diminished", "minor", "dominant", "dominant", "minor", "dominant" ] @=> string chordquality[];
[0,1,0,1,2,0,1,2,0,1,2,3,2,0,1,3,0] @=> int inversion[];

fun void rhodes()
{
    int pianocounter;
    if ( pianocounter % 2 == 0 )
    {
        for (0 => int i; i < inversion.cap(); i++)
        {
            jazz.generateChord(roots[i], chordquality[i], inversion[i]);
            Std.mtof(jazz.chord[0]) => voc0.freq;
            Std.mtof(jazz.chord[1]) => voc1.freq;
            Std.mtof(jazz.chord[2]) => voc2.freq;
            Std.mtof(jazz.chord[3]) => voc3.freq;
            1 => voc0.gain;
            1 => voc1.gain;
            1 => voc2.gain;
            1 => voc3.gain;            
            8::bpm.myDurations["quarter"] => now;
            
        }    
    }
}