OscCommunicate es;

es.init(); //initialize and spork class functions

//Sound Chain
SndBuf s => dac;

"/myfiles/song.wav" => s.read;

fun void RateControl(){
 while(true) {
     es.Sensor2 => s.rate;
     50::ms => now;
 }   
}

fun void VolumeControl(){
    while(true){
        es.Sensor1 => s.gain;
        100::ms => now; //SAMPLE RATE, test and set
    }
}

fun void Trigger(){
    while(true){
        es.Button => s.gain;
        100::ms => now; //SAMPLE RATE, test and set
    }
}

spork ~ VolumeControl();
spork ~ RateControl();
spork ~ Trigger();

while(true){
    1::minute => now;
}