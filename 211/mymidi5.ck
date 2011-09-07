AddSynth add;
NanoKontrol nano;
nano.initPort(0);

/*

while(true){
    piano.keypress => now;
    Std.mtof(piano.pitch) => s.freq;
    //.2 => s.gain;
}

*/

//Midi instrument class

class NanoKontrol {
    
    MidiIn min;
    MidiMsg msg;
    
    //Global variable (public_)
    
    int pitch[8];
    int velocity, wheel;
    Event keypress;
    
    fun void initPort(int port){
        if (!min.open(port)){
            <<<"Error: midi port did not Open: ", port>>>;
        }
        
        spork ~ poller();
        
    }
    
    fun void poller(){
        while(true){
            min => now;
            while(min.recv(msg)){
                <<<msg.data1, msg.data2, msg.data3>>>;
                /*
                if (msg.data1 == 176) && (msg.data2 == 17)){
                    //Keyboard presssed!!!
                    //      msg.data2 => pitch;
                    msg.data3 => velocity;
                    keypress.broadcast();
                }
                */
                for (0=> int i; i< 8; i++){
                    if ((msg.data1 == 176) && (msg.data2 == i)){
                        msg.data3 => pitch[i];
                    }
                }
            }
        }
    }
}



class AddSynth{
    
    SinOsc s => ADSR e => dac;
    SinOsc t => e;
    SinOsc u => e;
    SinOsc v => e;
    SinOsc w => e;
    SinOsc x => e;
    SinOsc y => e;
    SinOsc z => e;
    
    0.1 => s.gain => t.gain => u.gain => v.gain => w.gain => x.gain => y.gain => z.gain;
    Std.rand2(90, 300) => int rand;
    
    
    e.set( 10::ms, rand::ms, .3, (rand/2)::ms );
    
    fun void SetFreq(){
        while(true){
            Std.mtof(nano.pitch[0]) => s.freq;
            Std.mtof(nano.pitch[1]) => t.freq;
            Std.mtof(nano.pitch[2]) => u.freq;
            Std.mtof(nano.pitch[3]) => u.freq;
            Std.mtof(nano.pitch[4]) => u.freq;
            Std.mtof(nano.pitch[5]) => u.freq;
            Std.mtof(nano.pitch[6]) => u.freq;
            Std.mtof(nano.pitch[7]) => u.freq;
            
            
            // osc.yMouseValue/2 => t.freq;       
            // osc.yMouseValue*2 => u.freq;
            e.keyOn(); //startAttack > decay
            50::ms => now;  // sustain part
            e.keyOff(); //start release
            80::ms => now; //till start again        
        }
    }
    spork ~ SetFreq();   
}

1::day => now;


