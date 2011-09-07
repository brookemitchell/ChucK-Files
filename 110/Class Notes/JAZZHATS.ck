SndBuf openHat => Gain master => dac;
Saxofony sax => master;




"data/ge/hihat-open.wav" => openHat.read;

0 => openHat.gain;
0.6 => master.gain;

//note durations calculations
60 => float bpm;
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

0 => int hatcounter;
0 => int flag;

while (true)
{
    spork ~ tophats() @=> Shred @ hh;    
    8::sync => now;        
    //unspork out functions to start back at sync every 8 bars
    Machine.remove(hh.id());
}

fun void tophats()
{
    1 => flag;
    while (true)
    {
        12 %=> hatcounter;
        if ( hatcounter == 0 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12)
            0 => openHat.pos;
        1 => openHat.gain; 
        swing(tSixteenth, 1::sixtyfourth, 1::tSixteenth, 0.009, "pull") => now;  
        hatcounter++;
        <<<hatcounter>>>;
        0 => flag;
    } 
}



//fun void sax(

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