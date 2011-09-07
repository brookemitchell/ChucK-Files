public class Inst{
    //MASTER CHAIN
    
//------------------------//Pulse Oscillator Synth-----------------
    PulseOsc p1 => Gain g => Dyno comp => Delay d => JCRev r => LPF l => Gain master => dac;
    PulseOsc p2 => g;
    PulseOsc p3 => g;
    0 => p1.gain => p2.gain => p3.gain ;
    
    l.set(6000, 5);
    60::ms => d.delay;
    
    SinOsc lfo1 => blackhole;
    SinOsc lfo2 => blackhole;
    SinOsc lfo3 => blackhole;
    
    fun void connect( UGen ugen )
    {l => ugen;}
        
    600 => lfo1.freq => lfo2.freq => lfo3.freq;
    100 => lfo1.gain => lfo2.gain => lfo3.gain;
    
    fun void mod ()
    {
        lfo1.last()+900 => p1.width;   
        lfo2.last()+900 => p2.width;  
        lfo3.last()+900 => p3.width;  
        1::ms => now;
    }
    
    //detune lfos
    fun void detunelfo(float p1, float p2)
    {
        lfo2.freq() + p1 => lfo1.freq;
        lfo3.freq() + p2 => lfo2.freq;
        1::ms =>now;
    }
    
    // t is for trigger
    public void t( float freq )
    {
        freq => p1.freq; 
        freq/2 => p2.freq => p3.freq;   

    }
    
    // t is for trigger
    public void t( int note )
    {
        t( Std.mtof( note ) );
        gain(.1);
    }
    
    public void gain( float g )
    { g => p1.gain => p2.gain => p3.gain; }
    
}

//__________________________________________________________________________//
//Kick Drum from Scratch

