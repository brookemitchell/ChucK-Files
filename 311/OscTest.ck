"/Users/heyarnold/Documents/CMPO311/ChuckPatches/steel_balls_plastic_1.wav" => string filename;
if( me.args() ) me.arg(0) => filename;

// the patch 
SndBuf buf => dac;
// load the file
filename => buf.read;


OscRecv recv;
12000 => recv.port;
recv.listen();

recv.event("/euler, fff") @=> OscEvent eulerEvent;

float EulerValues[3];
Event Button;

fun void eulerPoller(){
    while (true){
        eulerEvent => now;
        if (eulerEvent.nextMsg() != 0){
            for( 0 => int i; i < EulerValues.cap(); i++) //callin' slider values, all f
                eulerEvent.getFloat() => EulerValues[i];
            eulerEvent.broadcast();
        }
        <<<EulerValues[0], EulerValues[1], EulerValues[2]>>>;
    }
}

spork ~eulerPoller();
while(true)
{
    // time loop
    while( true )
    {
        0 => buf.pos;
        EulerValues[0] => buf.gain;
      EulerValues[1]=> buf.rate;
        EulerValues[2] => buf.freq;
        100::ms => now;
    }
}
