Harmony harm;
TIME bpm;

bpm.temposet(120);

// instantiate a Dinky (not connected yet)
Dinky imp;

// connect the rest of the patch
Gain g => dac;

//connect the Dinky
imp.connect(g);

harm.setScale("A","Minor") @=> int scale[];
harm.blueChord(scale) @=> scale;
harm.chordGen(scale, 1, 1, 1, 1, 2, 2, -1) @=> int chord[];

while(1){
Arp(chord,bpm.dur[12],"down");
}

class Dinky
{
    // Source
    SinOsc s;
    0 => s.gain;
    
    public void connect( UGen ugen )
    {s => ugen;}
    
    // t is for trigger (using MIDI notes)
    public void t( int note )
    {t(Std.mtof(note));
    <<<note>>>;}
    
    // t is for trigger
    public void t( float freq )
    {freq => s.freq;
    .2 =>s.gain;
    <<<freq>>>;}
    
    
}

//, float gate, int steps, int distance, int repeats

public void Arp(int chord[], dur rate, string style)
{
    
    if (style == "up")
    {
        for (0=>int i; i<chord.cap(); i++){
            chord[i] => imp.t;
            rate => now;
        }
    }
    if (style == "down")
    {
        for (chord.cap()-1=>int i; i>0; i--){
            chord[i] => imp.t;
            rate => now;
        }
    }
    if (style == "updown"){
        for (0=>int i; i<chord.cap(); i++){
            chord[i] => imp.t;
            rate => now;
        }                
        for (chord.cap()=>int i; i>0; i--){
            chord[i] => imp.t;
            rate => now;
        }
    }
    if (style == "downup"){
        for (chord.cap()=>int i; i>0; i--){
            chord[i] => imp.t;
            rate => now;
        }
        for (0=>int i; i<chord.cap(); i++){
            chord[i] => imp.t;
            rate => now;
        }
    }
}