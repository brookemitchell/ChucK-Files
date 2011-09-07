// Reverse Sample

//PATH
"data/ge/snare.wav" => string snarefile;
"data/ge/kick.wav" => string kickfile;

SndBuf buf => Pan2 p => dac;

// Initialize buf
snarefile => buf.read;
buf.samples() => int numbersamples; //store number of samples in file
numbersamples => buf.pos; // set playback position at end of file
-1.0 => buf.rate; //negative rate to go backwards
<<<buf.samples>>>;

while (true)
{
    numbersamples => buf.pos;
    .1::second => now;
}

// lookup SndBuf parameters, .rate, .samples esp.