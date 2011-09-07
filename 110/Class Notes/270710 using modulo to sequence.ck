// sound files, make another folder called 'data' inside ChucK documents folder
//keep samples there

//PATH
"data/ge/snare.wav" => string snarefile;
"data/ge/kick.wav" => string kickfile;

SndBuf snare => Pan2 p => dac;
SndBuf kick => dac;

// Initialize buf
kickfile => kick.read;
snarefile => snare.read;

0 => int counter;

while (true){
counter++;
counter % 4 => int k; // list remainder, 0,1,2,3 etc
<<<counter, k>>>;

if (k == 1)
{
0 => kick.pos;
}

if (k == 3)
{
    
    0 => snare.pos; //set play position
// play with another sound file

}


Std.rand2f(.2,.9) => snare.gain; //rand gain makes things sound cool
Std.rand2f(.2, 1.8) => snare.rate; //float, if set to 1 will play normal, above pitch up, below pitch down
Std.randf() => p.pan;
100::ms => now;

}

//lookup SndBuf parameters, .rate, .samples esp.