public class Inst
{

    
    // t is for trigger
    public void t( float freq )
    {
        // set filter resonant frequency
        freq => s.freq;
        .5 => s.gain;
    }
    
    // t is for trigger (using MIDI notes)
    public void t( int note )
    { t( Std.mtof( note ) ); }
    
    PulseOsc p1 => Gain g => LPF lpf => Dyno comp => Delay d => dac;
    PulseOsc p2 => g;
    PulseOsc p3 => g;
    0 => p1.gain => p2.gain => p3.gain;
    
    .2 => g.gain;
    10::ms => d.delay;
    lpf.set(10000, 4.5);
    
    SinOsc lfo1 => blackhole;
    SinOsc lfo2 => blackhole;
    SinOsc lfo3 => blackhole;
    
    600 => lfo1.freq;
    300 => lfo1.gain => lfo2.gain =>lfo3.gain;
    
    [33, 55, 17, 41, 39] @=> int scale[];
    
    detunelfo(10, -10);
    play(scale, 31, 41);
    
    while(samp => now) {
        lfo1.last()+ 900 => p1.width;   
        lfo2.last() => p2.width;  
        lfo3.last() => p3.width;  
    }
    
    fun void play(int note[], int det1, int det2) 
    {
        for (0=> int i; i< scale.cap(); i++)
        {  
            Std.mtof(note[i]) => p1.freq;
            Std.mtof(note[i]-12) + det1 => p2.freq;
            Std.mtof(note[i]-12) + det2 => p3.freq;
            1 => p1.gain  => p2.gain => p3.gain;
            1::second => now;
            0 => lfo1.freq => lfo2.freq =>lfo3.freq;
            1::second => now;
        }
    }
    
    //detune lfos
    fun void detunelfo(float p1, float p2)
    {
        lfo2.freq() + p1 => lfo1.freq;
        lfo3.freq() + p2 => lfo2.freq;
    }
    

}

