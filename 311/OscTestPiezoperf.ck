"./311/wavs/0.wav" => string sample0;
"./311/wavs/1.wav" => string sample1;
"./311/wavs/2.wav" => string sample2;
"./311/wavs/3.wav" => string sample3;
"./311/wavs/4.wav" => string sample4;
"./311/wavs/5.wav" => string sample5;
"./311/wavs/6.wav" => string sample6;
"./311/wavs/7.wav" => string sample7;
"./311/wavs/8.wav" => string sample8;
"./311/wavs/9.wav" => string sample9;
"./311/wavs/10.wav" => string sample10;
"./311/wavs/11.wav" => string sample11;

if( me.args() ) me.arg(0) => sample0;
if( me.args() ) me.arg(0) => sample1;
if( me.args() ) me.arg(0) => sample2;
if( me.args() ) me.arg(0) => sample3;
if( me.args() ) me.arg(0) => sample4;
if( me.args() ) me.arg(0) => sample5;
if( me.args() ) me.arg(0) => sample6;
if( me.args() ) me.arg(0) => sample7;
if( me.args() ) me.arg(0) => sample8;
if( me.args() ) me.arg(0) => sample9;
if( me.args() ) me.arg(0) => sample10;
if( me.args() ) me.arg(0) => sample11;


// the patch 
SndBuf buf1 => Gain g => dac;
SndBuf buf2 => g;

//.3 => rev.mix;
// load the file
sample0 => buf1.read;
sample1 => buf1.read;
sample2 => buf2.read;
sample3 => buf1.read;
sample4 => buf1.read;
sample5 => buf1.read;
sample6 => buf1.read;
sample7 => buf1.read;
sample8 => buf1.read;
sample9 => buf1.read;
sample10 => buf1.read;
sample11 => buf10.read;


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
            
            for( 0 => int i; i < PiezoValues.cap(); i++) //callin' slider values, all i
                piezoEvent.getInt() => PiezoValues[i];
            piezoEvent.broadcast();
            
        }
        <<<PiezoValues[0], PiezoValues[1], PiezoValues[2], PiezoValues[3], PiezoValues[4],
        PiezoValues[5], PiezoValues[6], PiezoValues[7], PiezoValues[8], PiezoValues[9], 
        PiezoValues[10], PiezoValues[11]>>>;
    }
}

spork ~eulerPoller();
spork ~piezoPoller();


while(true)
{
    // time loop
    while( true )
    {
        if (PiezoValues[6] > 0){
        PiezoValues[6]*4 => buf1.pos;    
        PiezoValues[6]*4 => buf2.pos;

    }
        EulerValues[0]/4 => buf1.gain;
        EulerValues[1]/400=> buf1.rate;
        EulerValues[2] => buf1.freq;
        EulerValues[0]/4 => buf2.gain;
        EulerValues[1]/400=> buf2.rate;
        EulerValues[2] => buf2.freq;
        1200::ms => now;
        
        
    }
}
