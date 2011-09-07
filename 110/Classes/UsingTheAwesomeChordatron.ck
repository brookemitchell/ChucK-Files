// instantiate an instance
Chordatron chr;
BPM bpm;

SinOsc s => dac;
SinOsc b => dac;
SinOsc c => dac;

.3 => s.gain;
.3 => b.gain;
.3 => c.gain;

bpm.tempo(60.0);

while(true){
    
    
    for(0 => int y; y < 12; y++){ 
        
        chr.generateScale(60-y, 0);
        
        for(0 => int x; x < chr.scale.size(); x++){  
            
            chr.majorChordArp(chr.scale[x]);
            
                chr.chord[0] => s.freq;
                chr.chord[1] => b.freq; 
                chr.chord[2] => c.freq;
                
                1::bpm.myDurations[x % 4] => now;
        }
    }
    
}