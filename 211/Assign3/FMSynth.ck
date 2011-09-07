class FMSynth{
    
    OscHandler osc;
    osc.init();
    
    //Basic FM synth
    SinOsc m => SinOsc c => ADSR e => dac;
    
    
    //phase mod to make FM
    2 => c.sync;
    1 => c.gain;
    //modulation frequency
    45 => m.freq;
    //index of modulation
    200 => m.gain;
    
    fun void SetFreq(){
        while(true){
            osc.yMouseValue => c.freq;
            e.keyOn(); //startAttack > decay
            500::ms => now;  // sustain part
            e.keyOff(); //start release
            800::ms => now; //till start again      
        }
    }
    spork ~ SetFreq();   
}      