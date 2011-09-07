SinOsc s => ADSR e => dac;

e.set(10::ms, 8::ms, .5, 500::ms)

.5 => s.gain;

while(true){
    Std.rand2(20,60) => s.freq;
    
    e.keyOn(); //startAttack > decay
    500::ms => now;  // sustain part
    e.keyOff(); //start release
    800::ms => now; //till start again
}
    