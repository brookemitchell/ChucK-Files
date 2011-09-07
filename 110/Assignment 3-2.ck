<<< "Allan Mitchell - Assignment 3" >>>;

//Bassline G minor pentatonic scale Array midi
[31, 34, 36, 38, 40] @=> int scale[]; 

//Time
now + 30::second => time later;

//set bpm &  time divisions
123.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet * 4.0 => dur bar;
crotchet * 2.0 => dur minim;
crotchet / 2.0 => dur quaver;
crotchet / 4.0 => dur semiquaver;

// set sync period for beats (16ths)
//t16 - (now % t16) => now;

//declare variables
//0 => int counter; 

//PATH
"data/ge/kick.wav" => string kick;
"data/ge/snare.wav" => string snare;
"data/ge/snare-chili.wav" => string snarechili;
"data/ge/snare-hop.wav" => string snarehop;
"data/ge/hihat.wav" => string hihat;
"data/ge/hihat-open.wav" => string highhatopen;

//Mixer
SndBuf bufkick => Pan2 p1 => dac;
SndBuf bufsnare => Pan2 p2 => dac;
SndBuf bufsnarechili => Pan2 p3 => dac;
SndBuf bufsnarehop => Pan2 p4 => dac;
SndBuf bufhihat => Pan2 p5 => dac;
SndBuf bufhighhatopen => Pan2 p6 => dac;
SinOsc bass => dac;

// Initialize buf
kick => bufkick.read;
snare => bufsnare.read;
snarechili => bufsnarechili.read;
snarehop => bufsnarehop.read;
hihat => bufhihat.read;
highhatopen => bufhighhatopen.read;

0 => bass.gain => bufkick.gain => bufsnare.gain => bufsnarechili.gain => bufsnarehop.gain => bufhihat.gain => bufhighhatopen.gain;

//  if (now >= later) {break;} use in for loop
    //counter++;
    //counter % 4 => int beat; // list remainder
    //<<<counter>>>;

while (now < later){
        
    //number of times looped
    for (0 => int x; x < 2; x++){
        //intro
        for (0 => int i; i < 15; i++){
            //Kick
            if( i == 0 || i == 4 || i == 8 || i == 12){
                0 => bufkick.pos;
                .7 => bufkick.gain;
            }
            //kick quiet
          //  if( i == 7){
          //      0 => bufkick.pos;
          //      .3 => bufkick.gain;
            //}
            //HiHat pulse
            if (i % 3) {
                0 => bufhihat.pos;
                .7 => bufhihat.gain;}
                else{
                    0 => bufhihat.pos;
                    .1 => bufhihat.gain;
                }
                //snare
                if( i == 2 || i == 4){
                    0 => bufsnare.pos;
                    .7 => bufsnare.gain; 
                    //C => bass.freq;
                    .3 => bass.gain;
                }
                //Bass
                if ( i==1 || i == 13){ ///look up  & op as well
               // A => bass.freq;
                .5 => bass.gain;
            } else if (i == 5 || i == 13){
               // E => bass.freq;
                .5 => bass.gain;}
                else { 0 => bass.gain; }
                semiquaver => now;   
            }}
            
            
 /*           //B Section
            for (1 => int i; i < 9; i++){
                //Kick
                if( i == 1 || i == 5){
                    0 => bufkick.pos;
                    .7 => bufkick.gain;
                }
                //kick quiet
                if( i == 7){
                    0 => bufkick.pos;
                    .3 => bufkick.gain;
                }
                //HiHat pulse
                if (i % 3) {
                    0 => bufhihat.pos;
                    .7 => bufhihat.gain;}
                    else{
                        0 => bufhihat.pos;
                        .1 => bufhihat.gain;}
                        //snare
                        if( i == 2 || i == 4){
                            0 => bufsnare.pos;
                            .7 => bufsnare.gain; 
                        }
                        semiquaver => now;   
                    }   */ }