//Rhythmic Phasing using sporking with independent control rates
//Example for CMPO110 
//2010 Jordan Hochenbaum

//Instantiate two sin osc. => envelope (get rid of clicks) =>, etc.
SinOsc s => ADSR env => Pan2 p => Gain master => JCRev rev => dac;
SinOsc s2 => ADSR env2 => Pan2 p2 => master;

//settings (panning, gain, envelope, etc.)
-.67 => p.pan;
.67 => p2.pan;
.5 => master.gain;

.7 => s.gain;
.7=> s2.gain;

//attack, decay, sustain, release
env.set(35::ms, 10::ms, .5, 50::ms);
env2.set(35::ms, 10::ms, .5, 50::ms);
rev.mix(.035);

[63,66,68,70,73]@=> int mel1[]; //main melody (minor pentatonic)

//spork our two functions (they should happen at pretty much the exact same time)
spork ~ melody1(); 
spork ~ melody2(); 

while (true){
    1::second => now;   //this just keeps the main program running forever
}

fun void melody1(){
    while(true){        
        Std.mtof(mel1[Std.rand2(0,4)]) => s.freq;
        //because we are using an env, we use keyOn() and keyOff()
        env.keyOn(); 
        .25::second => now; //short note on to pluck the note
        env.keyOff();
        .15::second => now; //note off for .15 second
    }
}

fun void melody2(){
    while (true){
        //pick a random note from our array, this time a fifth down
        Std.mtof(mel1[Std.rand2(0,4)]-7) => s2.freq;
        //because we are using an env, we use keyOn() and keyOff()
        env2.keyOn();
        .25::second => now; //short note on to pluck the note
        env2.keyOff();
        .155::second => now; //note off for .155 second (slightly longer than melody one-- this will cause the phasing, play with this to change phase duration)
    }
}
