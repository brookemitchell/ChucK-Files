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