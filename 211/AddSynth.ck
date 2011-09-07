//Addsynth.ck
SinOsc s => dac;
SinOsc t => dac;
SinOsc u => dac;

//Initiate our class
OSC_animate a;
a.init();

fun void SetFreq(){
    while(true){
        100::ms => now;
        a.Sliders[0] => s.freq;
        a.Sliders[1] => t.freq;
        a.Sliders[0] => u.freq;
    }
}

fun void Mute(){
 while (true)
 {
  a.buttonEvent => now;
  a.ButtonState => s.gain;      
}

while (true)
{
    1::day => now;
}

spork ~ SetFreq();