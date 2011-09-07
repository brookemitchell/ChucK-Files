OscRecv recv;//Create OSC reciever
12000 => recv.port;//use port 12000 to recieve
recv.listen();//starts listening thread

//create an address in the recievere, store in event variable
recv.event("/sliders,fffff") @=> OscEvent sliderEvent;//looking for something called sliders with 5 floats
recv.event("/button, i") @=> OscEvent buttonEvent;//when the corresponding OSC message arrives, it's like the event got a broadcast or seng

//define Global Variables
float SliderValues[5];
int buttonState;//get data, store into variables, use those variables to make sound
Event Button;

fun void sliderPoller()
{
    while (true)
    {
        sliderEvent => now;
        if (sliderEvent.nextMsg() != 0)//in case of problems with message
        {
            for (0 => int i; i < SliderValues.cap(); i++)
            {
            sliderEvent.getFloat() => SliderValues[i];
            }
        <<<SliderValues[0],SliderValues[1],SliderValues[2],SliderValues[3],SliderValues[4]>>>;
        }
    }        
}

fun void buttonPoller()
{
    while(true)
    {
        buttonEvent => now;
        if (buttonEvent.nextMsg() != 0)
        {
            buttonEvent.getInt() => buttonState;
            Button.broadcast();
            <<<"Button">>>;
        }
    }
}

spork ~sliderPoller();
spork ~buttonPoller();

while(true)
{
    1::second => now;
}