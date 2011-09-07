"./311/wavs/SteelraspTP.wav" => string filename;
if( me.args() ) me.arg(0) => filename;

// the patch 
SndBuf buf => PRCRev rev => dac;
.3 => rev.mix;
// load the file
filename => buf.read;


OscRecv recv;
12000 => recv.port;
recv.listen();

recv.event("/euler, fff") @=> OscEvent eulerEvent;
recv.event("/piezo, iiiiiiiiiiii") @=> OscEvent piezoEvent;


float EulerValues[3];
int PiezoValues[12];
//Event Button;

//fun float[] eulerMap(float Values[]){


fun void eulerPoller(){
    while (true){
        eulerEvent => now;
        if (eulerEvent.nextMsg() != 0){
            for( 0 => int i; i < EulerValues.cap(); i++) //callin' slider values, all f
                eulerEvent.getFloat() => EulerValues[i];
            eulerEvent.broadcast();
        }
//        EulerValues[0], EulerValues[1], EulerValues[2];
    }
}

fun void piezoPoller(){
    while (true){
        piezoEvent => now;
        if (piezoEvent.nextMsg() != 0){
                                0 => buf.pos;

            for( 0 => int i; i < PiezoValues.cap(); i++) //callin' slider values, all i
                piezoEvent.getInt() => PiezoValues[i];
            piezoEvent.broadcast();
            
        }
   //     <<<PiezoValues[0], PiezoValues[1], PiezoValues[2], PiezoValues[3], PiezoValues[4],
     //   PiezoValues[5], PiezoValues[6], PiezoValues[7], PiezoValues[8], PiezoValues[9], 
       // PiezoValues[10], PiezoValues[11]>>>;
    }
}

spork ~eulerPoller();
spork ~piezoPoller();


while(true)
{
    // time loop
    while( true )
    {

        EulerValues[0]/4 => buf.gain;
        EulerValues[1]/400=> buf.rate;
        EulerValues[2] => buf.freq;
        1200::ms => now;
    }
}
