//Allan Mitchell 300214807 CMPO 110 Fianl Assign


//Classical-ish Harmonic Scale & Chord and Blues Variation Generator
//to one day be extended and more bugs checked


public class Harmony
{            
    fun int[] setScale (string setKey, string setMode)
    {
        int setNote;
        int scale[8];
        
        //Sets Midi Root Note
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
        if (setKey == "Eb"){63 => setNote;}
        if (setKey == "E"){64 => setNote;}
        if (setKey == "F"){65 => setNote;}
        if (setKey == "F#"){66 => setNote;}
        if (setKey == "Gb"){66 => setNote;}
        if (setKey == "G"){67 => setNote;}
        if (setKey == "G#"){68 => setNote;}
        
        //Setup Major Scale for Other modes to work from
        setNote  @=> scale[0];
        scale[0]+2 @=> scale[1];
        scale[0]+4 @=> scale[2];
        scale[0]+5 @=> scale[3];
        scale[0]+7 @=> scale[4];
        scale[0]+9 @=> scale[5];
        scale[0]+11 @=> scale[6];
        scale[0]+12 @=> scale[7];
        
        
        //And then all our scale Variations
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
        for (0 => int i; i > scale.cap()-1; i+2 => i)
        {scale[i]+1 @=> scale[i+1];
        scale[i+1]+2 @=> scale[i+2];}
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        
        else if(setMode == "Octatonic2")
        {int newArraySize[9] @=> scale;
        setNote => scale[0];
        for (0 => int i; i > scale.cap()-1; i+2 => i)
        {scale[i]+2 @=> scale[i+1];
        scale[i+1]+1 @=> scale[i+2];}
        <<<"Key" +":" + setKey + "." +setMode>>>;}
        return scale;
    }
    
    //Chord Generator, will have to simplify one day. Would like it to print the chords name eventually
    
    fun int[] chordGen(int scale[], int setstartDegree,  int flagAdd7ths, int flagAdd9ths, int flagAdd12ths, int spacing, int inversion, int Octave)
    {
        int impChord[6];
        
        //Sets up your chord depending on what you ask for.
        if (setstartDegree == 1)
        {scale[0] @=> impChord[0];
        scale[2] @=> impChord[1]; 
        scale[4] @=> impChord[2];
        if (flagAdd7ths == 1){scale[6] @=> impChord[3];}
        if (flagAdd9ths == 1){scale[1]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[4]+12 @=> impChord[5];}}
        else if (setstartDegree == 2)
        {scale[1] @=> impChord[0];
        scale[3] @=> impChord[1]; 
        scale[5] @=> impChord[2];
        if (flagAdd7ths == 1){scale[7] @=> impChord[3];}
        if (flagAdd9ths == 1){scale[2]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[5]+12 @=> impChord[5];}}
        else if (setstartDegree == 3)
        {scale[2] @=> impChord[0];
        scale[4] @=> impChord[1]; 
        scale[6] @=> impChord[2];
        if (flagAdd7ths == 1){scale[0]+12 @=> impChord[3];}
        if (flagAdd9ths == 1){scale[3]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[2]+12 @=> impChord[5];}}
        else if (setstartDegree == 4)
        {scale[3] @=> impChord[0];
        scale[5] @=> impChord[1]; 
        scale[7] @=> impChord[2];
        if (flagAdd7ths == 1){scale[1]+12 @=> impChord[3];}
        if (flagAdd9ths == 1){scale[4]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[2]+12 @=> impChord[5];}}
        else if (setstartDegree == 5)
        {scale[4] @=> impChord[0];
        scale[6] @=> impChord[1]; 
        scale[0]+12 @=> impChord[2];
        if (flagAdd7ths == 1){scale[2]+12 @=> impChord[3];}
        if (flagAdd9ths == 1){scale[5]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[2]+12 @=> impChord[5];}}
        else if (setstartDegree == 6)
        {scale[5] @=> impChord[0];
        scale[7] @=> impChord[1]; 
        scale[1]+12 @=> impChord[2];
        if (flagAdd7ths == 1){scale[3]+12 @=> impChord[3];}
        if (flagAdd9ths == 1){scale[6]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[2]+12 @=> impChord[5];}}
        else if (setstartDegree == 7)
        {scale[6] @=> impChord[0];
        scale[0]+12 @=> impChord[1]; 
        scale[2]+12 @=> impChord[2];
        if (flagAdd7ths == 1){scale[4]+12 @=> impChord[3];}
        if (flagAdd9ths == 1){scale[7]+12 @=> impChord[4];}
        if (flagAdd12ths == 1){scale[2]+12 @=> impChord[5];}}
        
        
        
        //INVERSION ParaMeter
        if (inversion == 1 ) 
        {impChord [0] + 12 @=> impChord[0]; }
        else if (inversion == 2 ) 
        {for (0 => int i; i<2; i++)
        {impChord [i]+12 @=> impChord [i];}}
        else if (inversion == 3 ) 
        {for (0 => int i; i<3; i++)
        {impChord [i]+12 @=> impChord [i];}} 
        else if (inversion == 4 ) 
        {for (0 => int i; i<4; i++)
        {impChord [i]+12 @=> impChord [i];}} 
        else if (inversion == 5 ) 
        {for (0 => int i; i<5; i++)
        {impChord [i]+12 @=> impChord [i];}} 
        else if (inversion == 6 ) 
        {for (0 => int i; i<6; i++)
        {impChord [i]+12 @=> impChord [i];}} 
        else if (inversion == -6 ) 
        {for (0 => int i; i<6; i++)
        {impChord [i]-12 @=> impChord [i];}} 
        else if (inversion == -5 ) 
        {for (0 => int i; i<5; i++)
        {impChord [i]-12 @=> impChord [i];}}
        else if (inversion == -4 ) 
        {for (0 => int i; i<3; i++)
        {impChord [i]-12 @=> impChord [i];}} 
        else if (inversion == -3 ) 
        {for (0 => int i; i<3; i++)
        {impChord [i]-12 @=> impChord [i];}} 
        else if (inversion == -2 ) 
        {for (0 => int i; i<2; i++)
        {impChord [i]-12 @=> impChord [i];}}
        else if (inversion == -1 ) 
        {impChord [0] + 12 @=> impChord[0];}
        
        //Octave Parameter
        for (0 => int i; i<impChord.cap(); i++)
        {impChord[i]+(Octave*12) @=> impChord[i];}
        
        //--------resize chord array before returning (not super elegant but hey.)----------------
       
       if (scale.cap() == 9 ){}
       
       else if (impChord[3] == 0  && impChord[4] == 0 && impChord[5] == 0 )
        {
            int resizeArray[3];            
            for(0 => int i; i < resizeArray.cap(); i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            resizeArray @=> impChord;
        }
        
        else if (impChord[3] == 0 && impChord[4] == 0 && impChord[5] != 0 )
        {
            int resizeArray[4];
            for(0 => int i; i < resizeArray.cap()-1; i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            impChord[5] @=> resizeArray[3];
            resizeArray @=> impChord;
        }
        else if (impChord[3] == 0 && impChord[4] != 0 && impChord[5] == 0 )
        {
            int resizeArray[4];
            for(0 => int i; i < resizeArray.cap()-1; i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            impChord[4] @=> resizeArray[3];
            resizeArray @=> impChord;
        }
        else if (impChord[3] == 0 && impChord[4] != 0 && impChord[5] != 0 )
        {
            int resizeArray[5];
            for(0 => int i; i <resizeArray.cap()-2; i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            impChord[4] @=> resizeArray[3];
            impChord[5] @=> resizeArray[4];
            resizeArray @=> impChord;
        }
        
        if (impChord[3] != 0 && impChord[4] == 0 && impChord[5] == 0 )
        {
            int resizeArray[4];
            for(0 => int i; i <resizeArray.cap(); i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            resizeArray @=> impChord;
        }
        
        else if (impChord[3] != 0 && impChord[4] == 0 && impChord[5] != 0 )
        {
            int resizeArray[5];
            for(0 => int i; i <resizeArray.cap()-1; i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            impChord[5] @=> resizeArray[4];
            resizeArray @=> impChord;
        }
        
        
        else if (impChord[3] != 0 && impChord[4] != 0 && impChord[5] == 0 )
        {
            int resizeArray[5];
            for(0 => int i; i <resizeArray.cap(); i++)
            {
                impChord[i] @=> resizeArray[i];
            }
            resizeArray @=> impChord;
        }        
        
        //SPACING Parameter
        if (spacing == 1 ) 
        {
            impChord[impChord.cap()-1] + 12 => impChord[impChord.cap()-1];
        }
        
        if (spacing == 2)
        {
            impChord[impChord.cap()-1] + 12 => impChord[impChord.cap()-1];
            impChord[impChord.cap()-2] + 12 => impChord[impChord.cap()-2];
        }
        if (spacing == 3)
        {
            impChord[impChord.cap()-1] + 12 => impChord[impChord.cap()-1];
            impChord[impChord.cap()-2] + 12 => impChord[impChord.cap()-2];
            impChord[impChord.cap()-3] + 12 => impChord[impChord.cap()-3];
        }
        
    
        return impChord;    
               
    }
    
    //--------done.-----------
    
    
    
    //Quick Blues Chord Modifier, should be used on major scales but is cool on others
    
    fun int[] blueChord(int chord[])
    {
        //  Std.rand() => int <<<blueschance>>>;
        if(maybe){chord[2]-1@=>chord[2];}
        if(maybe){chord[6]-1@=>chord[6];}
        return chord;
    }
}