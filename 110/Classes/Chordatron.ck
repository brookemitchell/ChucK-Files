public class Chordatron
{
    
    float chord[3];
    int scale[8];
    
    
    fun void generateScale(int rootNote, int scaleQuality)
    {
        rootNote @=> scale[0];
        
        rootNote + 2 @=> scale[1];
        
        (rootNote + 4) - qualityCheck(scaleQuality) @=> scale[2];
        
        rootNote + 5 @=> scale[3];
        
        rootNote + 7 @=> scale[4];
        
        (rootNote + 9) - qualityCheck(scaleQuality) @=> scale[5];
        
        (rootNote + 11) - qualityCheck(scaleQuality) @=> scale[6];
        
        rootNote + 12 @=> scale[7];        
    }
    
    fun void majorChordArp(int rootNote)
    {
        (scale[2] - scale[0]) => int majorMinor;
       
        
        if(majorMinor == 3)// major
        {
            std.mtof(rootNote) @=> chord[0];
            
            if(rootNote == scale[0] || rootNote == scale[3] || rootNote == scale[4])
            {
                
                std.mtof((rootNote + 4) - 1) @=> chord[1];
            }
            
            std.mtof(rootNote + 7) @=> chord[2];
        }
        else // minor
        {
            std.mtof(rootNote) @=> chord[0];
            
            if(rootNote == scale[1] || rootNote == scale[5] || rootNote == scale[6])
            {
                
                std.mtof((rootNote + 4) - 1) @=> chord[1];
            }
            
            std.mtof(rootNote + 7) @=> chord[2];
        }
        
    }
    
    fun int qualityCheck(int theQualityToCheck)
    {
        if(theQualityToCheck <= 0)
        {
            return 0;
        } 
        else 
        {
            return 1;
        }
    }
    
    
}