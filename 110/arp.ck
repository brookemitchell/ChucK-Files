//, float gate, int steps, int distance, int repeats
public class Arp
{   
    Inst midi; 
    
    fun void Arp(int chord[], dur rate, string style)
    {
        
        if (style == "up")
        {
            for (0=>int i; i<chord.cap(); i++){
                midi.t(chord[i]);
                rate => now;
            }
        }
        if (style == "down")
        {
            for (chord.cap()-1=>int i; i>0; i--){
                chord[i] => midi.t;
                rate => now;
            }
        }
        if (style == "updown"){
            for (0=>int i; i<chord.cap(); i++){
                chord[i] => midi.t;
                rate => now;
            }                
            for (chord.cap()-1=>int i; i>0; i--){
                chord[i] => midi.t;
                rate => now;
            }
        }
        if (style == "downup"){
            for (chord.cap()-1=>int i; i>0; i--){
                chord[i] => midi.t;
                rate => now;
            }
            for (0=>int i; i<chord.cap(); i++){
                chord[i] => midi.t;
                rate => now;
            }
        }
    }
}