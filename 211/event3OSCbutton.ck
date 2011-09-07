// Lecture 4

OscRecv recv;
12000 => recv.port; //use port 12000
recv.listen(); //start listening OSC (thread)

// tells it that we're lookin' for 5 sliders
recv.event("/slider, fffff") @=> OscEvent sliderEvent; //the message
// tells chuck we're lookin' for an event button 
recv.event("/button, i") @=> OscEvent buttonEvent; //the message


//Define global variables
float SliderValues[5]; // this many sliders yo!
int buttonState; //create a new button state (to be set up)
Event Button;

fun void sliderPoller()
{
    while(true)
    {
        sliderEvent => now;
        
        if(sliderEvent.nextMsg() != 0) // != does not equal 0, its like a backup in case things go wrong!
        {
            for( 0 => int i; i < SliderValues.cap(); i++) //callin' slider values, all f
                sliderEvent.getFloat() => SliderValues[i];
                        SliderValue.broadcast();
        }
        <<<SliderValues[0], SliderValues[1], SliderValues[2], SliderValues[3], SliderValues[4]>>>;
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
            <<<"Button">>>;
            
        }
        
    }
}


fun void Something()
{
 while (true)
 {
  Button => now;   
 }   
}

spork ~sliderPoller();
spork ~buttonPoller(); 

while (true)
{
    1::second => now;
}
    
 