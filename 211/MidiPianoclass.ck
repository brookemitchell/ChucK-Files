//Midi instrument class

public class MicroKey {
    
    MidiIn min;
    MidiMsg msg;
    
    //Global variable (public_)
    
    int pitch, velocity, wheel;
    Event keypress;
    
    fun void initPort(int p){
        if (!min.open(p)){
            <<<"MicroKey Error: midi port did not Open: ", >>>;
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
                    keypress.braodcast();
                }
                
                else if ((msg.data1 == 176) && (msg.data2 == 1)){
                    msg.data3 => wheel;
                }
            }
        }
    }
}