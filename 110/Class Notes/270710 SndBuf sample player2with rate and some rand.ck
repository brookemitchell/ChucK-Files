// sound files, make another folder called 'data' inside ChucK documents folder
//keep samples there

//PATH
"data/ge/snare.wav" => string filename;

SndBuf buf => dac;

// Initialize buf
filename => buf.read;
// or 
//"data/ge/snare.wav" => buf.read; // (string not needed)
//1.0 => buf.read;

while (true)
{
0 => buf.pos; //set play position
Std.rand2f(.2,.9) => buf.gain; //rand gain makes things sound cool
Std.rand2f(.2, 1.8) => buf.rate; //float, if set to 1 will play normal, above pitch up, below pitch down
200::ms => now;
}