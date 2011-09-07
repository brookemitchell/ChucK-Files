//Score follower for GameTrak

Flute f => dac;

//Object Initialisation
GameTrak g;
g.init(0);

//Melody
[45,47,49,52,48,45,47,49,52,53,52,47,45,47] @=> int A[];
A.cap() => int maxSize;
-1 => int current;
int buttonState;

fun void play(){
    while(true){
        g.button => now;
        (buttonState+1)%2 => buttonState;
        if (buttonState == 1){
            (current+1)%maxSize => current;
            Std.mtof(A[current]) => f.freq;
            f.noteOn(1.0);
        }
    }
}

fun void Effects(){
    while(true){
        (g.aY+1.0)/2 => f.jetReflection;
        (g.aX+1.0)/2 => f.endReflection;
        (g.aZ+1.0)/2 => f.gain;
        (g.bY+1.0)/2 => f.pressure;
        (g.bZ+1.0)/2 => f.noiseGain;
        ((g.bZ+1.0)/2)*100 => s.vibratoFreq; 
        20::ms => now;
    }
}
spork ~Effects();
spork ~play();

while(true)
{1::minute => now;}
