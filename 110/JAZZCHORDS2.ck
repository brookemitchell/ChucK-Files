public class JAZZATRON

{
    int chord[4];
    int rootnote;
    
    fun void generateChord(int rootNote, string chordQuality, int inversion) // , string 7thQuality
    {
        rootnote @=> chord[0];
        
        if (chordQuality == "major" || chordQuality == "augmented" || chordQuality == "dominant")  
            { rootnote + 4 @=> chord [1];}
        else if (chordQuality == "minor" || chordQuality == "diminished")        
            {rootnote + 3 @=> chord [1];}
        if (chordQuality == "minor" || chordQuality == "major")        
            {rootnote + 7 @=> chord [2];}
        else if (chordQuality == "augmented")        
            {rootnote + 8 @=> chord [2];}
        else if (chordQuality == "diminished")    
                {rootnote + 6 @=> chord [2];}
        if ( chordQuality == "major")       
             {rootnote + 11 @=> chord [3];}
        else if (chordQuality == "minor" || chordQuality == "dominant" || chordQuality == "diminished")
        {rootnote + 10 @=> chord [3];}
        
       if (inversion == 1 ) 
        {
            chord [0] +12 @=> chord[0]; 
        }
        else if (inversion == 2 ) 
        {
            chord [0] + 12 @=> chord[0];
            chord [1] + 12 @=> chord [1]; 
        }
        else if (inversion == 3 ) 
        {
            chord [0]+12 @=> chord [0];
            chord [1]+12 @=> chord [1];
            chord [2]+12 @=> chord [2];
        } 
    }   
}
