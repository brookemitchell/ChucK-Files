SndBuf openHat => ADSR env => Gain master => dac;
Saxofony sax => master;

TIME bpm;
bpm.tempo(40.0);

"data/ge/hihat-open.wav" => openHat.read;

0 => openHat.gain;
0.1 => master.gain;

4::bpm.myDurations["quarter"] => dur sync;
sync - (now % sync) => now;

0 => int hatcounter;
0 => int flag;


while (true)
{    
    spork ~ tophats() @=> Shred @ hh;    
    1::sync => now;        
    Machine.remove(hh.id());
}

fun void tophats()
{
    1 => flag;
    
    while (true)
    {
        12 %=> hatcounter;

        
        if ( hatcounter == 0 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12 )
        {
            //  env.set( 10::ms, 18::ms, .5, 50::ms );        
            //  env.keyOn();
            0 => openHat.pos;
            //   29::ms => now;
            //   env.keyOff();
            1 => openHat.gain; 
            swing(bpm.myDurations["tEighth"], .3::(bpm.myDurations["tSixtyfourth"]), .5::bpm.myDurations["sixtyfourth"], Std.rand2f(0.009, 0.2), "pull") => now;  
            
            0 => flag;
        } 
                    <<<hatcounter++>>>;  
    }
}




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


//fun void sax(