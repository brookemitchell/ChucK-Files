//Scale Function

public class HARMONY

fun int[] setScale (string setKey, string setMode )
{
    int Chordkey[];
    setNote @=> Chordkey[0];
    Chordkey[0]+2 @=> Chordkey[1];
    Chordkey[0]+4 @=> Chordkey[2];
    Chordkey[0]+5 @=> Chordkey[3];
    Chordkey[0]+7 @=> Chordkey[4];
    Chordkey[0]+9 @=> Chordkey[5];
    Chordkey[0]+11 @=> Chordkey[6];
    Chordkey[0]+12 @=> Chordkey[7];
    
    if (setKind == "Major")
    {<<<setkey setMode>>>;}
    
    elseif (setKind == "Minor")
    {Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[5]-1 @=> Chordkey[5];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Dorian")
    {Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[6]-1 @=> Chordkey[6];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Phrygian")
    {Chordkey[1]-1 @=> Chordkey[1];
    Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[5]-1 @=> Chordkey[5];
    Chordkey[6]-1 @=> Chordkey[6];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Lydian")
    {Chordkey[1]+1 @=> Chordkey[3];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Mixolydian")
    {Chordkey[6]-1 @=> Chordkey[6];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Aeolian")
    {Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[5]-1 @=> Chordkey[5];
    Chordkey[6]-1 @=> Chordkey[6];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Locrian")
    {Chordkey[1]-1 @=> Chordkey[1];
    Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[4]-1 @=> Chordkey[4];
    Chordkey[5]-1 @=> Chordkey[5];
    Chordkey[6]-1 @=> Chordkey[6];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Octatonic1")
    {setNote @=> Chordkey[0];
    Chordkey[0]+1 @=> Chordkey[1];
    Chordkey[1]+2 @=> Chordkey[2];
    Chordkey[2]+1 @=> Chordkey[3];
    Chordkey[3]+2 @=> Chordkey[4];
    Chordkey[4]+1 @=> Chordkey[5];
    Chordkey[5]+2 @=> Chordkey[6];
    Chordkey[6]+1 @=> Chordkey[7];
    Chordkey[6]+2 @=> Chordkey[8];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Octatonic1")
    {setNote @=> Chordkey[0];
    Chordkey[0]+2 @=> Chordkey[1];
    Chordkey[1]+1 @=> Chordkey[2];
    Chordkey[2]+2 @=> Chordkey[3];
    Chordkey[3]+1 @=> Chordkey[4];
    Chordkey[4]+2 @=> Chordkey[5];
    Chordkey[5]+1 @=> Chordkey[6];
    Chordkey[6]+2 @=> Chordkey[7];
    Chordkey[7]+1 @=> Chordkey[8];
    <<<setkey setMode>>>;}
    
    elseif(setKind == "Blues")
    {Chordkey[2]-1 @=> Chordkey[2];
    Chordkey[2]+1 @=> Chordkey[3];
    Chordkey[3]+1 @=> Chordkey[4];
    Chordkey[4]+2 @=> Chordkey[5];
    Chordkey[5]+2 @=> Chordkey[6];
    Chordkey[6]+1 @=> Chordkey[7];
    Chordkey[7]+1 @=> Chordkey[8];
    Chordkey[8]+1 @=> Chordkey[9];
    <<<setkey setMode>>>;}
    
    return Chordkey;
}
