//Allan Mitchell 300214807 CMPO 110 Fianl Assign


//Here we do our patching...

public class Inst{
    TIME bpm;
    
    //MASTER CHAIN
    //------------------------//Pulse Oscillator Synth-----------------
    PulseOsc p1 => Gain g  => Delay d  => JCRev r =>  LPF l => Dyno comp =>  Gain master => dac;
    PulseOsc p2 => g;
    PulseOsc p3 => g;
    0 => p1.gain => p2.gain => p3.gain ;
    
    //filter initial set and reverb mix
    l.set(3000, 14);
    60::ms => d.delay;
    r.gain(.09);
    r.mix(.15);
    
    ///------------------------
    ///Modulators: Pulse WIdth modulation and ADSR to Filter Cutoff via (stepwave set permanently to 1(kinda hacky)
    Step s;
    SinOsc lfo1 => blackhole;
    SinOsc lfo2 => blackhole;
    SinOsc lfo3 => blackhole;
    ADSR filtadsr => Gain filtgain => blackhole;
    
    s => filtadsr;
    1 => s.next;
    
  //  fun void connect( UGen ugen )
    //{l => ugen;}
    
    //Set lfo freq and gain
    60 => lfo1.freq => lfo2.freq => lfo3.freq;
    10 => lfo1.gain => lfo2.gain => lfo3.gain;
    100 => filtgain.gain;
    
    //function to keep modulation running
    fun void mod ()
    {
        lfo2.last()/20 + 400 => p2.width;  
        lfo3.last()/50 + 600 => p3.width;  
        1::ms => now;
    }
    
    //Ways to keep LFO mod by ADSR kinda interesting, mods the mod for acid'y vibe
    fun void filteradsr ()
    {
        while (true)
        {  
            int i;
            if (i % 2)
            {
                filtadsr.set( Std.rand2(40, 200)::ms, Std.rand2(800, 190)::ms, 10, 100::ms );            
                filtadsr.keyOn();
                filtadsr.last() * Std.rand2(60, 800) + 1350 => float currfilt;
                currfilt => l.freq;
                100::ms => now;
                filtadsr.keyOff();
                i++;
            }
            
            else 
            {          
                filtadsr.set( Std.rand2(400, 200)::ms, Std.rand2(800, 1900)::ms, 10, 10::ms );            
                filtadsr.keyOn();
                filtadsr.last() * Std.rand2(100, 1000) + 250 => float currfilt;
                currfilt => l.freq;
                20::ms => now;
                filtadsr.keyOff();
                i++;
            }
            (1)::bpm.dur[12] => now;
        }
    }
    
    //Get those modulations running!
    spork ~ runmods() @=> Shred @ rm;
    fun void runmods()
    {
        while(1)
        {
            mod(); 
            filteradsr();
        }
    }
    
    //detune those lfos!
    fun void detunelfo(float p1, float p2)
    {
        lfo2.freq() + p1 => lfo1.freq;
        lfo3.freq() + p2 => lfo2.freq;
        1::ms =>now;
    }
    
    // Trigger those frequencies! t is for trigger
    public void t( float freq )
    {
        freq => p1.freq; 
        freq/2 => p2.freq => p3.freq;   
        
    }
    
    // Oh the joys of overloading
    public void t( int note )
    {
        t( Std.mtof( note ) );
        gain(.1);
    }
    
    // set the pulseoscs gain, i should have used this function more, this is kinda dumb...
    public void gain( float g )
   { g => p1.gain => p2.gain => p3.gain; }
    
    public void mastergain( float g )
    { g => master.gain; }
    


    //__________________________________________________________________________//
    //Some Drums to patch in, sorry drums I kinda neglected you this time round.
    
    
    ///hats 
    SndBuf openHat => ADSR hatenv =>  master;
    SndBuf closeHat => ADSR hat2env => master; 
    SndBuf kick => ADSR kickenv => master;    
    
    0 => openHat.gain => closeHat.gain => kick.gain;
    
    kickenv.set( 4::ms, Std.rand2(80, 190)::ms, 1, 100::ms );
    hatenv.set( 20::ms, Std.rand2(10, 190)::ms, .2, 100::ms );        
    hat2env.set( Std.rand2(10, 90)::ms, 4::ms, .1, Std.rand2(8, 18)::ms );    
    
    "data/hihat-open.wav" => openHat.read;
    "data/hihat.wav" => closeHat.read;
    "data/kick.wav" => kick.read;
    
    
}