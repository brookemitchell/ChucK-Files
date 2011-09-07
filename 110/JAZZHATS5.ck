SndBuf openHat => ADSR hatenv => Gain master => dac;
SndBuf openHat2 => ADSR hat2env => master;
//Saxofony sax => master;
Rhodey voc0 => Gain rhgain => ADSR Rhodenv => Echo e =>  master;
Rhodey voc1 => rhgain;
Rhodey voc2 => rhgain;
Rhodey voc3 => rhgain;

TIME bpm;
JAZZATRON jazz;

"data/ge/hihat-open.wav" => openHat.read;
"data/ge/hihat-open.wav" => openHat2.read;
.5 => voc0.lfoSpeed => voc1.lfoSpeed => voc2.lfoSpeed => voc3.lfoSpeed ;
.5 => voc0.lfoDepth => voc1.lfoDepth => voc2.lfoDepth => voc3.lfoDepth;
10::ms => e.delay;
0 => openHat.gain;
0 => openHat2.gain;
0.6 => master.gain;

[57, 62, 55, 60, 66, 59, 64, 64, 59, 64, 64, 66, 59, 64, 64, 57, 62] @=> int roots[]; //UP to D7
["minor", "dominant", "major", "major", "minor", "dominant", "dominant", "dominant", "dominant", "dominant", "dominant", "diminished", "minor", "dominant", "dominant", "minor", "dominant" ] @=> string chordquality[];
[0,1,0,1,2,0,1,2,0,1,2,3,2,0,1,3,0] @=> int inversion[];

bpm.tempo(55.0);

8.33333333333333333334::bpm.myDurations["eighth"] => dur sync;
sync - (now % sync) => now;

0 => int hatcounter;
0 => int flag;

while (true)
{    
    spork ~ rhodes() @=> Shred @ rh;
    spork ~ tophats() @=> Shred @ hh;    
    1::sync => now;        
    Machine.remove(hh.id());  
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
            2::ms => hatenv.attackTime;
            hatenv.keyOn();
            0 => openHat.pos;
            29::ms => now;
            hatenv.keyOff();        
            1 => openHat.gain;
        }
        
        
        else if (  hatcounter == 1 || hatcounter == 4 || hatcounter == 6 || hatcounter == 7 || hatcounter == 10 || hatcounter == 12 )
        {
            140::ms => hatenv.attackTime;            
            hatenv.keyOn();
            0 => openHat.pos;
            29::ms => now;
            hatenv.keyOff();        
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

fun void rhodes()
{
    int pianocounter;
    Rhodenv.set( 340::ms, 320::ms, 100, 500::ms );  
    if ( pianocounter % 2 == 0 )
    {
        for (0 => int i; i < inversion.cap(); i++)
        {
            jazz.generateChord(roots[i], chordquality[i], inversion[i]);
            Std.mtof(jazz.chord[0]) => voc0.freq;
            Rhodenv.keyOn();
            1 => voc0.noteOn;
            Std.mtof(jazz.chord[1]) => voc1.freq;
            .5 => voc1.noteOn;
            Std.mtof(jazz.chord[2]) => voc2.freq;
            .7 => voc2.noteOn;
            Std.mtof(jazz.chord[3]) => voc3.freq;
            .7 => voc3.noteOn;
            8::bpm.myDurations["quarter"] => now;
            Rhodenv.keyOff();
            0 => voc0.noteOff => voc1.noteOff => voc2.noteOff => voc3.noteOff;
            
        }
        
    }
}