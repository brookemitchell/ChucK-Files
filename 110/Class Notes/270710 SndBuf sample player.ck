// sound files, make another folder called 'data' inside ChucK documents folder
//keep samples there

//PATH
"data/ge/snare.wav" => string filename;

SndBuf buf => dac;

// Initialize buf
filename => buf.read;
// or "data/ge/snare.wav" => buf.read; (string not needed)
1.0 => buf.read;

0 => buf.pos; //set play position, where you are in 44100 sample/sec soundfile array

1::second => now;
