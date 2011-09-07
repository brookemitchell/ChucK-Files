//Allan Mitchell 300214807 CMPO 110 Fianl Assign
//Who doesn't like Arpeggiators? 
//This one's crying out for gate, steps, distance, int repeats variables inputs

public class Arp
{   
    Inst midi;
    fun void Arp(int chord[], dur rate, string style)
    {
        
        if (style == "up")
        {
            for (0=>int i; i<chord.cap(); i++){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }
        }
        if (style == "down")
        {
            for (chord.cap()-1=>int i; i>0; i--){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }
        }
        if (style == "updown"){
            for (0=>int i; i<chord.cap(); i++){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }                
            for (chord.cap()-1=>int i; i>0; i--){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }
        }
        if (style == "downup"){
            for (chord.cap()-1=>int i; i>0; i--){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }
            for (0=>int i; i<chord.cap(); i++){
                Std.mtof(chord[i]) => midi.t;
                midi.gain(.1);
                rate => now;
            }
        }
    }
}