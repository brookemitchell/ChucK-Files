public class OSC_Animate(){
    OscRecv recv; // Create Osc Reciever
    12000 => recv.port;
    recv.listen();
    
    // Setup address for receiver
    recv.event("slider, fffff") @=> OscEvent sliderEvent;
    recv.event("slider, i") @=> OscEvent buttonEvent;
    
    float Sliders[5];
    int ButtonState;
    Event ButtonEvent;
    
    fun void init(){
        spork ~ sliderPoller();
        spork ~ ButtonPoller();
    }
    
    fun void SliderPoller(){
        while(true){
            sliderEvent => now;
            
            if (sliderEvent != 0){
                for( 0 => int i; i < SliderValues.cap(); i++) //callin' slider values, all f
                    sliderEvent.getFloat() => SliderValues[i];
            }
        }
    }
    
    fun void buttonPoller()
    {
        while(true)
        {
            buttonEvent => now;
            
            if(buttonEvent.nextMsg() != 0) // does not equal 0
            {
                buttonEvent.getInt() => buttonState;
                Button.broadcast();                
            }            
        }
    }
}