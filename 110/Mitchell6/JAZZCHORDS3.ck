public class JAZZATRON
{
    int Chord[4];
    
    fun void generateChord(int RootNote, string chordQuality, int inversion) // , string 7thQuality
    {        
        RootNote @=> Chord[0];
        
        if (chordQuality == "major" || chordQuality == "augmented" || chordQuality == "dominant")  
        { RootNote + 4 @=> Chord [1];}
        else if (chordQuality == "minor" || chordQuality == "diminished")        
        {RootNote + 3 @=> Chord [1];}
        if (chordQuality == "minor" || chordQuality == "major")        
        {RootNote + 7 @=> Chord [2];}
        else if (chordQuality == "augmented")        
        {RootNote + 8 @=> Chord [2];}
        else if (chordQuality == "diminished")    
        {RootNote + 6 @=> Chord [2];}
        if ( chordQuality == "major")       
        {RootNote + 11 @=> Chord [3];}
        else if (chordQuality == "minor" || chordQuality == "dominant" || chordQuality == "diminished")
        {RootNote + 10 @=> Chord [3];}
        
        if (inversion == 1 ) 
        {
            Chord [0] + 12 @=> Chord[0]; 
        }
        else if (inversion == 2 ) 
        {
            Chord [0] + 12 @=> Chord[0];
            Chord [1] + 12 @=> Chord [1]; 
        }
        else if (inversion == 3 ) 
        {
            Chord [0]+12 @=> Chord [0];
            Chord [1]+12 @=> Chord [1];
            Chord [2]+12 @=> Chord [2];
        } 
    }   
    
    //Array Shuffle
    
    fun int[] ShuffleArray (int InputArray[])
    {
        //  int NewArray[];
        InputArray @=> int NewArray[];
        
        for (InputArray.cap() -1 => int n; n > -1; n--)
        {
            Std.rand2(0, n) => int ChangeIndex;
            InputArray[ChangeIndex] => int a;
            InputArray[n] => int b;
            a => InputArray[n];
            b => InputArray[ChangeIndex];
        }
            return NewArray;
    }
}
