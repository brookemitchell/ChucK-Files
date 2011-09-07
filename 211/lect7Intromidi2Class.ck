public class Keystation49{
    MidiIn min;
    MidiMsg msg;
    
    Event keypress;
    
    int pitch, velocity, slider;
        
    fun void initPort(int p){
        if (!min.open(port))
        {
            <<<"Error: Midi Port did not Open on Port: ", port >>>;
        }
        spork ~poller;
    }
}
        
        fun void Poller(){
            while(true){
                min => now;
                while(min.recv(msg)){
                    <<<msg.data1, msg.data2, msg.data3>>>;
                    if (msg.data1 == 144){
                        msg.data2 => pitch;
                        msg.data3 => velocity;
                        keypress.broadcast();
                    }
                   // else if(msg.data1 == 176){}
                    
                        if(msg.data2 == ){
                            msg.data3 => slider 
                            
                        }
                    }
                }
            }
        }
    }
    