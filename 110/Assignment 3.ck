<<< "Allan Mitchell - Assignment 3" >>>;

//Time
now + 30::second => time later;

//set bpm &  time divisions
123.1 => float bpm;
60::second / bpm => dur t4;
t4 * 4.0 => dur t1;
t4 * 2.0 => dur t2;
t4 / 2.0 => dur t8;
t4 / 4.0 => dur t16;

// set sync period for beats (16ths)
t16 - (now % t16) => now;

//declare variables
0 => int counter; 
//0 => int barcounter;

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

// Initialize buf
kick => bufkick.read;
snare => bufsnare.read;
snarechili => bufsnarechili.read;
snarehop => bufsnarehop.read;
hihat => bufhihat.read;
highhatopen => bufhighhatopen.read;

while (now < later){
    if (now >= later) {break;}
    counter++;
    counter % 4 => int beat; // list remainder
    
    
//if (counter == 3) {barcounter++};
//<<<beat, barcounter>>>;

}