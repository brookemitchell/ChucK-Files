//Swing function example
//CMPO110
//Jordan Hochenbaum

SndBuf hatTiny => Gain drumBuss => dac;
SndBuf kick => drumBuss;
"data/ge/mth_hat_tiny.wav" => hatTiny.read;
"data/ge/mth_bd_electro.wav" => kick.read;
0 => hatTiny.gain;
0 => kick.gain;
0.6 => drumBuss.gain;

//note durations calculations
120 => float bpm;
(120.0 / bpm)::second => dur half;
(60 / bpm)::second => dur quarter;
(30 / bpm)::second => dur eighth;
(15 / bpm)::second => dur sixteenth;
(7.5 / bpm)::second => dur thirtysecond;
(3.75 / bpm)::second => dur sixtyfourth;
(90 / bpm)::second => dur dQuarter;
(45 / bpm)::second => dur dEighth;
(22.5 / bpm)::second => dur dSixteenth;
(40 / bpm)::second => dur tQuarter;
(20 / bpm)::second => dur tEighth;
(10 / bpm)::second => dur tSixteenth;

4::quarter => dur sync;
sync - (now % sync) => now;

0 => int flag;
//spork ~ kickPattern();
//spork ~ basicHiHatsSwung();


while (true){
    //spork our functions on a sync
    spork ~ kickPattern() @=> Shred @ k;
    spork ~ hihats() @=> Shred @ hh;
    1::sync => now;
    
    //unspork out functions
    Machine.remove(k.id());
    Machine.remove(hh.id());
}

fun void kickPattern(){
    while (true){
        0 => kick.pos;
        1=>kick.gain;
        1::quarter => now;  
    }   
}

fun void hihats(){
    1 => flag;
    while (true){
        0 => hatTiny.pos;
        1=>hatTiny.gain; 
        swing(sixteenth, 1::sixtyfourth, 1::thirtysecond, 0.05, "pull") => now;  
        0 => flag;
    } 
}

fun dur swing(dur initial, dur min, dur max, float amt, string pushPull)
{
    if (flag == 1){
        <<<"flag is 1">>>;
        return initial;
    }else{
        if (pushPull == "push"){
            <<<(initial+(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp)>>>;
            return (initial+(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp) ;
        }
        else if (pushPull == "pull"){
            if (max > initial){
                initial => max;
            }
            <<<(initial-(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp)>>>;
            return (initial-(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp) ;
            
        }
    }
}