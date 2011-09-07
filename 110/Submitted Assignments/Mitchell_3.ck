<<< "Allan Mitchell - Assignment 3" >>>;
<<< "Let the IDM Begin!" >>>;

//Bassline Eb minor pentatonic scale Array midi
[51, 54, 56, 58, 61,  63] @=> int scale[]; 

//Time
now + 30::second => time later;

//set bpm &  time divisions
123.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet * 4.0 => dur bar;
crotchet / 4.0 => dur semiquaver;

//PATH
"data/ge/kick.wav" => string kick;
"data/ge/snare.wav" => string snare;
"data/ge/snare-chili.wav" => string snarechili;
"data/ge/snare-hop.wav" => string snarehop;
"data/ge/hihat.wav" => string hihat;
"data/ge/hihat-open.wav" => string highhatopen;

//Mixer
SndBuf bufkick => Pan2 pkick => dac;
SndBuf bufsnare => Pan2 psnare => dac;
SndBuf bufsnarechili => Pan2 psnarechilli => dac;
SndBuf bufsnarehop => Pan2 psnarehop => dac;
SndBuf bufhihat => Pan2 phihat => dac;
SndBuf bufhighhatopen => Pan2 phighhatopen => dac;
SinOsc bass => Pan2 pbass =>  dac;
SinOsc bass2 => Pan2 pbass2 =>  dac;

// Initialize buf
kick => bufkick.read;
snare => bufsnare.read;
snarechili => bufsnarechili.read;
snarehop => bufsnarehop.read;
hihat => bufhihat.read;
highhatopen => bufhighhatopen.read;

bufhighhatopen.samples() => int numbersamples;

0 => bass.gain => bufkick.gain => bufsnare.gain => bufsnarechili.gain => bufsnarehop.gain => bufhihat.gain => bufhighhatopen.gain;

while (now < later){
    //Part A     
    //number of times looped
    for (0 => int x; x < 1; x++){
        //kill switch
        if (now >= later) {break;}
        //16 beat division
        for (0 => int i; i < 16; i++){
            if (now >= later) {break;}
            //Kick
            if( i == 0 || i == 4 || i == 8 || i == 12){
                1000 => bufkick.pos;
                .7 => bufkick.gain;
            }
            // kick quiet
            if( i == 7){
                2000 => bufkick.pos;
                .3 => bufkick.gain; 
            }
            //HiHat pulse
            if (i % 2) {
                0 => bufhihat.pos;
                .4 => bufhihat.gain;}
                else{
                    0 => bufhihat.pos;
                    .2 => bufhihat.gain;
                }
                //snare
                if( i == 8 || i == 15){
                    0 => bufsnare.pos;
                    Std.rand2f(.2,.9) => bufsnare.gain;
                    Std.rand2f(.2, 1.8) => bufsnare.rate;
                    
                }
                //Bass
                bass.freq() /2 - Std.rand2(0,i % 10) => bass2.freq;
                .1 => bass2.gain;
                if ( i==1 || i == 7 || i == 12 || i == 15){  
                    for (0 => int z; z < scale.cap(); z++){
                        Std.mtof(scale[z % scale.cap()]) => bass.freq;
                        Std.rand2f(.2, 1.8) => bufkick.rate;
                        .5 => bass.gain;
                    } }
                    else if (i == 5 || i == 6 || i == 13){
                        for (0 => int z; z < scale.cap(); z++){
                            Std.mtof(scale[Std.rand2(0, z)]) => bass.freq;
                            .5 => bass.gain;}}
                            else { 0 => bass.gain; } 
                            semiquaver => now;   
                        }}
                        //Part B                        
                        //number of times looped
                        for (0 => int x; x < 1; x++){
                            //16 beat division
                            for (0 => int i; i < 16; i++){
                                //kill switch
                                if (now >= later) {break;}
                                //HiHat-Open
                                if( i >= 1 ){
                                    numbersamples => bufhighhatopen.pos;
                                    Std.rand2f(-.2, -1.8) => bufhighhatopen.rate;
                                    Std.randf() => phighhatopen.pan;
                                    0.3  => bufhighhatopen.gain;
                                    //Snare Chilli
                                    if( i <= 12 ){
                                        9000 => bufsnarechili.pos;
                                        Std.rand2f(0.1, .3) => bufsnarechili.rate;
                                        Std.randf() => psnarechilli.pan;
                                        
                                    }
                                    //SnareHop
                                    if( i >= 1 ){
                                        200 => bufsnarehop.pos; 
                                        Std.rand2f(1, 18) => bufsnarehop.rate;        
                                        Std.rand2f(0.1, .3) => bufsnarehop.rate;
                                    }}}
                                    //Part C
                                    // number of times looped
                                    for (0 => int x; x < 3; x++){
                                        //16 beat division
                                        for (0 => int i; i < 16; i++){
                                            if (now >= later) {break;}
                                            //Kick
                                            if( i == 1 || i == 5){
                                                60 => bufkick.pos;
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
                                                    //Bass
                                                    if (i==1 || i == 7 || i == 12 || i == 15){  
                                                        for (0 => int z; z < scale.cap(); z++){
                                                            Std.mtof(scale[Std.rand2(0, z)]) => bass.freq;
                                                            Std.rand2f(.2, 1.8) => bufkick.rate;
                                                            .3 => bass.gain;
                                                        } }
                                                        else if (i == 5 || i == 6 || i == 13 || i == 16){
                                                            for (0 => int z; z < scale.cap(); z++){
                                                                Std.mtof(scale[z % scale.cap()]) => bass.freq;
                                                                .5 => bass.gain;}}
                                                                else { 0 => bass.gain; } 
                                                                bass.freq() / 1.5  - Std.rand2(0,i % 25) => bass2.freq;
                                                                .1 => bass2.gain;
                                                            }}}
                                                            semiquaver => now;   
                                                        }
