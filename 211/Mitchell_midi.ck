AddSynth add;
NanoKontrol nano;
FMSynth fm;
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
    
    int pitch[9];
    int velocity, wheel;
    int a,d,s,r;
    int a2,d2,s2,r2;
    
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
                for (0=> int i; i< 9; i++){
                    if ((msg.data1 == 176) && (msg.data2 == i)){
                        msg.data3 => pitch[i];
                    }
                    
                }
                if ((msg.data1 == 176) && (msg.data2 == 9)){
                    msg.data3 => a;
                }
                else if ((msg.data1 == 176) && (msg.data2 == 10)){
                    msg.data3 => d;
                }
                else if ((msg.data1 == 176) && (msg.data2 == 11)){
                    msg.data3 => s;
                }
                else if ((msg.data1 == 176) && (msg.data2 == 12)){
                    msg.data3 => r;
                }
                else if ((msg.data1 == 176) && (msg.data2 == 13)){
                    msg.data3 => a2;
                } 
                else if ((msg.data1 == 176) && (msg.data2 == 14)){
                    msg.data3 => d2;
                } 
                else if ((msg.data1 == 176) && (msg.data2 == 15)){
                    msg.data3 => s2;
                } 
                else if ((msg.data1 == 176) && (msg.data2 == 16)){
                    msg.data3 => r2;
                } 
            }
            
        }
    }
}

class FMSynth{
    
    
    //Basic FM synth
    SinOsc m => SinOsc c => ADSR e => dac;
    Std.rand2(1, 300) => int rand;
    e.set( (nano.a2/5)::ms, 10::ms, .3, nano.r2*rand::ms);
    
    
    //phase mod to make FM
    2 => c.sync;
    .4 => c.gain;
    //modulation frequency
    nano.pitch[8]*2 => m.freq;
    //index of modulation
    200*(rand+(nano.d2/4)) => m.gain;
    
    fun void SetFreq(){
        while(true){
            Std.mtof(nano.pitch[8]) => c.freq;
            e.keyOn(); //startAttack > decay
            (rand/2)::ms => now;  // sustain part
            e.keyOff(); //start release
            rand::ms => now; //till start again      
        }
    }
    spork ~ SetFreq();   
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
    
    0.2 => s.gain => t.gain => u.gain => v.gain => w.gain => x.gain => y.gain => z.gain;
    Std.rand2(70, 300) => int rand;
    
    
    
    fun void SetFreq2(){
        while(true){
            Std.mtof(nano.pitch[0]) => s.freq;
            Std.mtof(nano.pitch[1]) => t.freq;
            Std.mtof(nano.pitch[2]) => u.freq;
            Std.mtof(nano.pitch[3]) => u.freq;
            Std.mtof(nano.pitch[4]) => u.freq;
            Std.mtof(nano.pitch[5]) => u.freq;
            Std.mtof(nano.pitch[6]) => u.freq;
            Std.mtof(nano.pitch[7]) => u.freq;
            
            e.set(((nano.a)/10)::ms, nano.d::ms, .7, (nano.r)*(rand/2)::ms );
            
            
            e.keyOn(); //startAttack > decay
            (nano.s)*2::ms => now;  // sustain part
            e.keyOff(); //start release
           Std.rand2(15,350)::ms => now; //till start again        
        }
    }
    spork ~ SetFreq2();   
}

1::day => now;


