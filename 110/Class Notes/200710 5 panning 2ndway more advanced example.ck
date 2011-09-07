//white noise to Pan to Dac
noise n => pan2 p => dac;

//infinite loop
while (true)
{
    Math.sin(now/1::second *2*pi) => p.pan;
    //advance time
    10::ms => now;
    
}

