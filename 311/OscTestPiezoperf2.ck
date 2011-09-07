// led i prob, + 11
// mic  (kinda ok) sometimes - 10 almost ever 7 none 

// 10 - secs bring in drone
// sample 5 star 
//30 secs cath next part
// same directionh
//1:15 throw
//1:30 improvise

"./311/wavs/0.wav" => string sample0;
"./311/wavs/1.wav" => string sample1;
"./311/wavs/2.wav" => string sample2;
"./311/wavs/3.wav" => string sample3;
"./311/wavs/4.wav" => string sample4;
"./311/wavs/5.wav" => string sample5; // Piano pluck, high sounds good
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
SndBuf buff[12]; 
buff[0] => Gain g => dac;
for (1 => int i; i < buff.cap(); i++){
    buff[i] => g;
}


//.3 => rev.mix;
// load the file
sample0 => buff[0].read;
sample1 => buff[1].read;
sample2 => buff[2].read;
sample3 => buff[3].read;
sample4 => buff[4].read;
sample5 => buff[5].read;
sample6 => buff[6].read;
sample7 => buff[7].read;
sample8 => buff[8].read;
sample9 => buff[9].read;
sample10 => buff[10].read;
sample11 => buff[11].read;


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
            
            for( 0 => int i; i < PiezoValues.cap(); i++) {
                piezoEvent.getInt() => PiezoValues[i];
                piezoEvent.broadcast();            
            }
        }
  //           <<<PiezoValues[0], PiezoValues[1], PiezoValues[2], PiezoValues[3], PiezoValues[4],
    //       PiezoValues[5], PiezoValues[6], PiezoValues[7], PiezoValues[8], PiezoValues[9], 
      //   PiezoValues[10], PiezoValues[11]>>>;
    }
}

spork ~eulerPoller();
spork ~piezoPoller();


while(true)
{
    // time loop
    while( true )
    {
        for( 0 => int i; i < 12 ; i++)
        {
            EulerValues[0]/4 => buff[i].gain;
            EulerValues[1]/400=> buff[i].rate;
            EulerValues[2] => buff[i].freq;
            
            if(PiezoValues[i] > 0)
            {
                PiezoValues[i] => buff[i].pos;
                // <<<i,":",PiezoValues[i]>>>;
            }
        }
        Std.rand2(100,2000)::ms => now;
        
        
    }
}
