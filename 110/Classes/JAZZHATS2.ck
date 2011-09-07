SndBuf openHat => ADSR env => Gain master => dac;
Saxofony sax => master;

BPM bpm;

"data/ge/hihat-open.wav" => openHat.read;

0 => openHat.gain;
0.6 => master.gain;

bpm.tempo(60.0);

4::bpm.myDurations["quarter"] => dur sync;
sync - (now % sync) => now;

0 => int hatcounter;
0 => int flag;

while (true)
{    
    spork ~ tophats() @=> Shred @ hh;    
    1::sync => now;        
    Machine.remove(hh.id());
    //unspork out functions to start back at sync every 8 bars
    
}

fun void tophats()
{
    1 => flag;
    env.set( 10::ms, 8::ms, .5, 500::ms );        
    
    while (true)
    {
        12 %=> hatcounter;
        if ( hatcounter == 0 ||  hatcounter == 1 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12 )
        0 => openHat.pos;
        1 => openHat.gain; 
        swing(1::bpm.myDurations["tSixteenth"], 1::bpm.myDurations["sixtyfourth"], 1::bpm.myDurations["tThirtysecond"], Std.rand2f(0.009, 0.2), "pull") => now;  
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