public class HATNESS
{
    TIME bpm;
    int flag;
    (1/.12)::bpm.dur["eighth"] => dur sync;
    sync - (now % sync) => now;
    fun void hatseq()
    {
        while (true)
        {       
            
            spork ~ tophats() @=> Shred @ hh;    
            1::sync => now;        
            Machine.remove(hh.id());  
        }
    }
    
    fun void tophats()
    {
        1 => flag;
        hatenv.set( 140::ms, 120::ms, .5, 100::ms );        
        hat2env.set( 20::ms, 40::ms, .1, 80::ms );            
        
        while (true)
        {
            12 %=> hatcounter;
            .1 => openHat2.gain;
            hat2env.keyOn();    
            0 => openHat2.pos;
            hatenv.keyOff(); 
            
            if (hatcounter == 0) {
                4::ms => hatenv.attackTime;
                1 => hatenv.keyOn;
                0 => openHat.pos;
                29::ms => now;
                0 => hatenv.keyOff;        
                1 => openHat.gain;
            }
            
            
            else if (  hatcounter == 1 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12 )
            {
                140::ms => hatenv.attackTime;            
                1 => hatenv.keyOn;
                0 => openHat.pos;
                29::ms => now;
                0 => hatenv.keyOff;        
                1 => openHat.gain;
            }
            
            swing(1::bpm.myDurations["tSixteenth"], 1::bpm.myDurations["sixtyfourth"], 1::bpm.myDurations["tThirtysecond"], Std.rand2f(0.009, 0.2), "pull") => now;  
            hatcounter++;      
            0 => flag;
        }     
    }
    
    
    fun dur swing(dur initial, dur min, dur max, float amt, string pushPull)
    {
        if (flag == 1){
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
}


