Public class ESitar{
    
    //OSC Setup
    OscRecv recv;
    3335 => recv.port;
    recv.listen();
    
    recv.event("/Sensor_1", i) @=> OscEvent Sen1;
    recv.event("/Sensor_2", i) @=> OscEvent Sen2;
    recv.event("/button", i) @=> OscEvent Button;
    recv.event("/accelX", i) @=> OscEvent AccelX;
    
    //Global Variables
    int Sensor1;
    int Sensor2;
    int ButtonState;
    int AccelX;
    
    Event ButtonOn;
    
    fun void init(){
        spork ~Sensor1_Poller();
        spork ~Sensor2_Poller();
        spork ~Button_Poller();
        spork ~AccelX_Poller();
    }
    
    fun void Sensor1_Poller(){
        while(true){
            Sen1Event => now;
            if (sen1.nextMsg() != 0){
                Sen1Event.getInt() => sensor1;
            }
        }
    }
    
    fun void Sensor2_Poller(){
        while(true)
        {
            Sen2Event => now;
            if (sen1.nextMsg() != 0){
                Sen2Event.getInt() => sensor2;
            }
        }
    }
    
    fun void AccelX_Poller(){
        while(true)
        {
            Sen2Event => now;
            if (sen1.nextMsg() != 0){
                AccelXEvent.getInt() => AccelX;
            }
        }
    }
    
    fun void Button_Poller(){
        while(true){
            ButtonEvent => now;
            if (ButtonEvent.nextMsg() != 0){
                
        }
    