
class AddSynth{
    
    PulseOsc s => ADSR e => dac;
    SinOsc t => e;
    SinOsc u => e;
    0.2 => s.gain;
    
    //Initiate our class
    OscHandler osc;
osc.init();

fun void SetFreq(){
    while(true){
        osc.yMouseValue => s.freq;
        osc.yMouseValue/2 => t.freq;       
        osc.yMouseValue*2 => u.freq;
        e.keyOn(); //startAttack > decay
        500::ms => now;  // sustain part
        e.keyOff(); //start release
        800::ms => now; //till start again        
    }
}
spork ~ SetFreq();   
}

  


