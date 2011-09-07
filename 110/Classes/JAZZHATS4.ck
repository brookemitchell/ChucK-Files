SndBuf openHat => ADSR hatenv => Gain master => dac;
SndBuf openHat2 => ADSR hat2env => master;
Saxofony sax => master;

TIME bpm;

"data/ge/hihat-open.wav" => openHat.read;
"data/ge/hihat-open.wav" => openHat2.read;

0 => openHat.gain;
0 => openHat2.gain;
0.3 => master.gain;

bpm.tempo(70.0);

12::bpm.myDurations["eighth"] => dur sync;
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
    hatenv.set( 140::ms, 120::ms, .5, 100::ms );        
    hat2env.set( 320::ms, 40::ms, .5, 200::ms );        
    
    
    while (true)
    {
        12 %=> hatcounter;
        
        .2 => openHat2.gain;
        hat2env.keyOn();    
        0 => openHat2.pos;
        hatenv.keyOff();        
        
        
        if (  hatcounter == 1 || hatcounter == 0 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12 )
        {
            hatenv.keyOn();
            0 => openHat.pos;
            29::ms => now;
            hatenv.keyOff();        
            1 => openHat.gain;
        }
        
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
            return (initial+(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp) ;
        }
        else if (pushPull == "pull"){
            if (max > initial){
                initial => max;
            }
            return (initial-(Std.rand2f((amt*min)/1::samp, (amt*max)/1::samp))::samp) ;
            
        }
    }
}