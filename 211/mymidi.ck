SqrOsc s => dac;

0.2=> s.gain;
MicroKey piano;
piano.initPort(0);

while(true){
    piano.keypress => now;
    Std.mtof(piano.pitch) => s.freq;
    //.2 => s.gain;
}

//Midi instrument class

 class MicroKey {
    
    MidiIn min;
    MidiMsg msg;
    
    //Global variable (public_)
    
    int pitch, velocity, wheel;
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
                
                if(msg.data1 == 144){
                    //Keyboard presssed!!!
                    msg.data2 => pitch;
                    msg.data3 => velocity;
                    keypress.broadcast();
                }
                
                else if ((msg.data1 == 176) && (msg.data2 == 8)){
                    msg.data3 => s.freq;
                }
                else if ((msg.data1 == 176) && (msg.data2 == 17)){
                    msg.data3 => s.gain;
                }
            }
        }
    }
}