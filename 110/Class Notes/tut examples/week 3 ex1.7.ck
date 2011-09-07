SinOsc s => Gain g => dac;
SinOsc t => g;
SinOsc z => g;

.5 => s.gain;
.5=> t.gain;
.5=> z.gain;

int melody[0];

while (true){
    .5 => s.freq;    
}

//functions defined here

fun int minorThird (int x) {
    return x+3;
}

fun int majorThird (int x) {
    return x+4;
}

fun int fifth (int x) {
    return x+6;
}