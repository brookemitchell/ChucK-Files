SqrOsc s => dac;

KeyStation49 piano;
piano.initPort(2);

while(true){
    piano.keypress => now;
    Std.mtof(piano.pitch) => s.freq;
    piano.velocity/127.0 => s.gain;
}