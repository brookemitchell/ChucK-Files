//I should break this up into files, but usin this to demo as my Machine.add is being weird

class OscHandler{
    
    OscRecv recv; // Create Osc Reciever
    12000 => recv.port;
    recv.listen();
    
    // Setup address for receiver
    recv.event("/yMouse, i") @=> OscEvent yMouseEvent;
    
    int yMouseValue;
    
    fun void init(){
        spork ~yMousePoller();
    }    
    
    fun void yMousePoller(){
        while (true){
            yMouseEvent => now;
            if (yMouseEvent.nextMsg() != 0){
                yMouseEvent.getInt() => yMouseValue;
            }
        }
    }      
}

class AddSynth{
    
    PulseOsc s => ADSR e => dac;
    SinOsc t => e;
    SinOsc u => e;
    0.1 => s.gain;
    Std.rand2(90, 300) => int rand;
    
    
    e.set( 10::ms, rand::ms, .3, (rand/2)::ms );
    
    
    //Initiate our class
    OscHandler osc;
osc.init();

fun void SetFreq(){
    while(true){
        osc.yMouseValue => s.freq;
        osc.yMouseValue/2 => t.freq;       
        osc.yMouseValue*2 => u.freq;
        e.keyOn(); //startAttack > decay
        50::ms => now;  // sustain part
        e.keyOff(); //start release
        80::ms => now; //till start again        
    }
}
spork ~ SetFreq();   
}

class FMSynth{
    
    OscHandler osc;
    osc.init();
    
    //Basic FM synth
    SinOsc m => SinOsc c => ADSR e => dac;
    Std.rand2(1, 300) => int rand;
    e.set( (20/rand)::ms, 4::ms, .3, rand::ms);
    
    
    //phase mod to make FM
    2 => c.sync;
    .4 => c.gain;
    //modulation frequency
    rand => m.freq;
    //index of modulation
    200*(rand/4) => m.gain;
    
    fun void SetFreq(){
        while(true){
            osc.yMouseValue => c.freq;
            e.keyOn(); //startAttack > decay
            rand::ms => now;  // sustain part
            e.keyOff(); //start release
            rand*2::ms => now; //till start again      
        }
    }
    spork ~ SetFreq();   
}        

//OscHandler osc;
AddSynth add;
FMSynth fm;
1::day => now;
