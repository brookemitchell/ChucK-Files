public class blast
{
    // impulse to filter to dac
    Impulse i => BiQuad f => Envelope e;
    // set the filter's pole radius
    .99 => f.prad;
    // set equal gain zeros
    9=> f.eqzs;
    // set filter gain
    .2 => f.gain;
    // set the envelope
    .002::sixteenth => e.duration;
    
    public void radius( float rad )
    { rad => f.prad; }
    
    public void gain( float g )
    { g => i.gain; }
    
    public void connect( UGen ugen )
    { e => ugen; }
    
    // t is for trigger
    public void t( float freq )
    {
        // set the current sample/impulse
        1.0 => i.next;
        // set filter resonant frequency
        freq => f.pfreq;
        // open the envelope
        e.keyOn();
    }
    
    // t is for trigger (using MIDI notes)
    public void t( int note )
    { t( Std.mtof( note ) ); }
    
    // another lazy name: c (for close)
    public void c() { e.keyOff(); }
}