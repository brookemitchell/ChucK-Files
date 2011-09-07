//Classical-ish Harmonic Generator

//setScale("G","Minor") => 

//int set modulationChance, 
//int setHarmonicChangeRate,
//if chord=0 set gain 0

public class Harmony
{            
    fun int[] setScale (string setKey, string setMode)
    {
        int setNote;
        int scale[8];
        
        if (setKey == "Ab"){56 => setNote;}
        if (setKey == "A"){57 => setNote;}
        if (setKey == "A#"){58 => setNote;}
        if (setKey == "Bb"){58 => setNote;}
        if (setKey == "B"){59 => setNote;}
        if (setKey == "C"){60 => setNote;}
        if (setKey == "C#"){61 => setNote;}
        if (setKey == "Db"){61 => setNote;}
        if (setKey == "D"){62 => setNote;}
        if (setKey == "D#"){63 => setNote;}
        if (setKey == "E"){64 => setNote;}
        if (setKey == "F"){65 => setNote;}
        if (setKey == "F#"){66 => setNote;}
        if (setKey == "Gb"){66 => setNote;}
        if (setKey == "G"){67 => setNote;}
        if (setKey == "G#"){68 => setNote;}
        
        setNote  @=> scale[0];
        scale[0]+2 @=> scale[1];
        scale[0]+4 @=> scale[2];
        scale[0]+5 @=> scale[3];
        scale[0]+7 @=> scale[4];
        scale[0]+9 @=> scale[5];
        scale[0]+11 @=> scale[6];
        scale[0]+12 @=> scale[7];
        
        if (setMode == "Major")
        { <<<"Key" + (setKey) + ":" +setMode>>>;}
        
        else if (setMode == "Minor")
        {scale[2]-1 @=> scale[2];
        scale[5]-1 @=> scale[5];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Dorian")
        {scale[2]-1 @=> scale[2];
        scale[6]-1 @=> scale[6];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Phrygian")
        {scale[1]-1 @=> scale[1];
        scale[2]-1 @=> scale[2];
        scale[5]-1 @=> scale[5];
        scale[6]-1 @=> scale[6];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Lydian")
        {scale[1]+1 @=> scale[3];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Mixolydian")
        {scale[6]-1 @=> scale[6];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Aeolian")
        {scale[2]-1 @=> scale[2];
        scale[5]-1 @=> scale[5];
        scale[6]-1 @=> scale[6];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Locrian")
        {scale[1]-1 @=> scale[1];
        scale[2]-1 @=> scale[2];
        scale[4]-1 @=> scale[4];
        scale[5]-1 @=> scale[5];
        scale[6]-1 @=> scale[6];
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Octatonic1")
        {int newArraySize[9] @=> scale;
        setNote => scale[0];
        for (0 => int i; i > scale.cap(); i+2 => i)
        {scale[i]+1 @=> scale[i+1];
        scale[i+1]+2 @=> scale[i+2];}
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Octatonic2")
        {int newArraySize[9] @=> scale;
        setNote => scale[0];
        for (0 => int i; i > scale.cap(); i+2 => i)
        {scale[i]+2 @=> scale[i+1];
        scale[i+1]+1 @=> scale[i+2];}
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        return scale;
    }
    
    
    fun int[] chordGen(int scale[], int setstartDegree,  int flagAdd7ths, int flagAdd9ths, int flagAdd12ths, int spacing, int inversion, int Octave)
    {
        scale @=> int scale[];
        int impChord[6];
        //Add feature print chord name
        
        if (setstartDegree == 1)
        {
            scale[0] @=> impChord[0];
            scale[2] @=> impChord[1]; 
            scale[4] @=> impChord[2];
            if (flagAdd7ths == 1){scale[6] @=> impChord[3];}
            if (flagAdd9ths == 1){scale[1]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[4]+12 @=> impChord[5];}
        }
        else if (setstartDegree == 2)
        {
            scale[1] @=> impChord[0];
            scale[3] @=> impChord[1]; 
            scale[5] @=> impChord[2];
            if (flagAdd7ths == 1){scale[7] @=> impChord[3];}
            if (flagAdd9ths == 1){scale[2]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[5]+12 @=> impChord[5];}
        }
        else if (setstartDegree == 3)
        {
            scale[2] @=> impChord[0];
            scale[4] @=> impChord[1]; 
            scale[6] @=> impChord[2];
            if (flagAdd7ths == 1){scale[0]+12 @=> impChord[3];}
            if (flagAdd9ths == 1){scale[3]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[2]+12 @=> impChord[5];}
            
        }
        else if (setstartDegree == 4)
        {
            scale[3] @=> impChord[0];
            scale[5] @=> impChord[1]; 
            scale[7] @=> impChord[2];
            if (flagAdd7ths == 1){scale[1]+12 @=> impChord[3];}
            if (flagAdd9ths == 1){scale[4]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[2]+12 @=> impChord[5];}
        }
        else if (setstartDegree == 5)
        {
            scale[4] @=> impChord[0];
            scale[6] @=> impChord[1]; 
            scale[0]+12 @=> impChord[2];
            if (flagAdd7ths == 1){scale[2]+12 @=> impChord[3];}
            if (flagAdd9ths == 1){scale[5]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[2]+12 @=> impChord[5];}
        }
        else if (setstartDegree == 6)
        {
            scale[5] @=> impChord[0];
            scale[7] @=> impChord[1]; 
            scale[1]+12 @=> impChord[2];
            if (flagAdd7ths == 1){scale[3]+12 @=> impChord[3];}
            if (flagAdd9ths == 1){scale[6]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[2]+12 @=> impChord[5];}
        }
        else if (setstartDegree == 7)
        {
            scale[6] @=> impChord[0];
            scale[0]+12 @=> impChord[1]; 
            scale[2]+12 @=> impChord[2];
            if (flagAdd7ths == 1){scale[4]+12 @=> impChord[3];}
            if (flagAdd9ths == 1){scale[7]+12 @=> impChord[4];}
            if (flagAdd12ths == 1){impChord[2]+12 @=> impChord[5];}
        }
        //SPACING Parameter
        if (spacing == 1 ) 
        {
            if (flagAdd12ths == 1){impChord [5] + 12 @=> impChord[5];}
            else if (flagAdd9ths == 1){impChord[4]+12 @=> impChord[4];}
            else if (flagAdd7ths == 1){impChord[3]+12 @=> impChord[3];}
            else {impChord[2]+12 @=> impChord[2];}
        }
        else if (spacing == 2)
        {
            if (flagAdd12ths == 1){impChord [5] + 12 @=> impChord[5];
            impChord[4]+12 @=> impChord[4];}
            else if (flagAdd9ths == 1){impChord[4]+12 @=> impChord[4];}
            else if (flagAdd7ths == 1){impChord[3]+12 @=> impChord[3];
            impChord[2]+12 @=> impChord[2];}
            else {impChord[2]+12 @=> impChord[2];
            impChord[1]+12 @=> impChord[1];}
        }
        else if (spacing == 3)
        {
            if (flagAdd12ths == 1){impChord [5] + 12 @=> impChord[5];
            impChord[4]+12 @=> impChord[4];
            impChord[3]+12 @=> impChord[3];}
            else if (flagAdd9ths == 1){impChord[4]+12 @=> impChord[4];
            impChord[3]+12 @=> impChord[3];
            impChord[2]+12 @=> impChord[2];}
            else if (flagAdd7ths == 1){impChord[3]+12 @=> impChord[3];
            impChord[2]+12 @=> impChord[3];
            impChord[1]+12 @=> impChord[2];}
            else {impChord[2]+12 @=> impChord[2];
            impChord[1]+12 @=> impChord[1];
            impChord[0]+12 @=> impChord[0];}
        }
        
        
        //INVERSION ParaMeter
        if (inversion == 1 ) 
        {
            impChord [0] + 12 @=> impChord[0]; 
        }
        else if (inversion == 2 ) 
        {
            impChord [0] + 12 @=> impChord[0];
            impChord [1] + 12 @=> impChord [1]; 
        }
        else if (inversion == 3 ) 
        {
            impChord [0]+12 @=> impChord [0];
            impChord [1]+12 @=> impChord [1];
            impChord [2]+12 @=> impChord [2];
        } 
        else if (inversion == 4 ) 
        {
            impChord [0]+12 @=> impChord [0];
            impChord [1]+12 @=> impChord [1];
            impChord [2]+12 @=> impChord [2];
            impChord [3]+12 @=> impChord [3];
        } 
        
        else if (inversion == 5 ) 
        {
            impChord [0]+12 @=> impChord [0];
            impChord [1]+12 @=> impChord [1];
            impChord [2]+12 @=> impChord [2];
            impChord [3]+12 @=> impChord [3];
            impChord [4]+12 @=> impChord [4];
        } 
        else if (inversion == 6 ) 
        {
            impChord [0]+12 @=> impChord [0];
            impChord [1]+12 @=> impChord [1];
            impChord [2]+12 @=> impChord [2];
            impChord [3]+12 @=> impChord [3];
            impChord [4]+12 @=> impChord [4];
            impChord [5]+12 @=> impChord [5];
        } 
        else if (inversion == -6 ) 
        {
            impChord [0]-12 @=> impChord [0];
            impChord [1]-12 @=> impChord [1];
            impChord [2]-12 @=> impChord [2];
            impChord [3]-12 @=> impChord [3];
            impChord [4]-12 @=> impChord [4];
            impChord [5]-12 @=> impChord [5];
        } 
        else if (inversion == -5 ) 
        {
            impChord [0]-12 @=> impChord [0];
            impChord [1]-12 @=> impChord [1];
            impChord [2]-12 @=> impChord [2];
            impChord [3]-12 @=> impChord [3];
        }
        else if (inversion == -4 ) 
        {
            impChord [0]-12 @=> impChord [0];
            impChord [1]-12 @=> impChord [1];
            impChord [2]-12 @=> impChord [2];
            impChord [3]-12 @=> impChord [3];
        } 
        else if (inversion == -3 ) 
        {
            impChord [0]-12 @=> impChord [0];
            impChord [1]-12 @=> impChord [1];
            impChord [2]-12 @=> impChord [2];
        } 
        else if (inversion == -2 ) 
        {
            impChord [1]-12 @=> impChord[1];
            impChord [2]-12 @=> impChord [2]; 
        }
        else if (inversion == -1 ) 
        {
            impChord [2]-12 @=> impChord[2]; 
        }
        
        //Octave Parameter
        impChord[0]+(Octave*12) @=> impChord[0];
        impChord[1]+(Octave*12) @=> impChord[1];
        impChord[2]+(Octave*12) @=> impChord[2];
        impChord[3]+(Octave*12) @=> impChord[3];
        impChord[4]+(Octave*12) @=> impChord[4];
        impChord[5]+(Octave*12) @=> impChord[5];
        
        return impChord;           
    }
    
    
    fun int[] blueChord(int chord[])
    {
        //  Std.rand() => int <<<blueschance>>>;
        if(maybe){chord[2]-1@=>chord[2];}
        if(maybe){chord[6]-1@=>chord[6];}
        return chord;
    }
    
}              
