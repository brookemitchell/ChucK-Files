public class Inst
{
    // Source
    SinOsc s;
    0.5 => s.gain;
    20 => s.freq;
    
    
    public void connect( UGen ugen )
    {s => ugen;}
    
    
}
