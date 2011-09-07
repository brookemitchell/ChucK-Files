[57, 62, 55, 60, 66, 59, 64, 64, 59, 64, 64, 66, 59, 64, 64, 57, 62] @=> int roots[]; 
["minor", "dominant", "major", "major", "minor", "dominant", "dominant", "dominant", "dominant", "dominant", "dominant", "diminished", "minor", "dominant", "dominant", "minor", "dominant" ] @=> string chordquality[];
[0,1,0,1,0,1,1,2,0,1,2,3,2,0,1,3,0] @=> int inversion[];
[5, -4, 7, -3, 9, 11, 7, 1, 3, 6, -7, 4, 9, 5, 3, 3, 7, -2, 1, 1] @=> int melody[];

TIME bpm;
JAZZATRON jazz;

SndBuf openHat => ADSR hatenv =>  Gain master => dac;
SndBuf openHat2 => ADSR hat2env => master;

SinOsc voc0 => Gain Rhodesgain => ADSR rhodeenv => Delay d => Pan2 p2 =>  master;
SinOsc voc1 =>  Rhodesgain;
SinOsc voc2 =>  Rhodesgain;
SinOsc voc3 =>  Rhodesgain;
BlowHole clar => ADSR clarenv => JCRev R => master;

0 => voc0.gain => voc1.gain => voc2.gain => voc3.gain => clar.gain;
3::bpm.dur["tThirtysecond"] => d.delay;
1 => Rhodesgain.gain;
hatenv.set( 440::ms, 120::ms, .5, 100::ms );
clarenv.set( 600::ms, 10::ms, .1, 100::ms );        
        
"data/ge/hihat-open.wav" => openHat.read;
"data/ge/hihat-open.wav" => openHat2.read;

.3 => clar.reed;
.3 => R.mix;

0 => openHat.gain;
0 => openHat2.gain;
1 => master.gain;

bpm.temposet(55.0);

(1/.12)::bpm.dur["eighth"] => dur sync;
sync - (now % sync) => now;

0 => int hatcounter;
0 => int flag;

now + 60::second => time later;


//StUFF to DO!!!

while (now < later)
{      
    spork ~ rhodes() @=> Shred @ rh;  
    1::bpm.dur["bar"] => now;
    spork ~ hatseq() @=> Shred @ ht;   
    2::bpm.dur["bar"] => now;
    spork ~ clarinet() @=> Shred @ cl;
    later => now;        
}


//--------FUNCTIONS

fun void hatseq()
{
    while(1)
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
        .081 => openHat2.gain;
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
            .81 => openHat.gain;
        }
        
        swing(1::bpm.dur["tSixteenth"], 0.15::bpm.dur["sixtyfourth"], (1/.12)::bpm.dur["tThirtysecond"], Std.rand2f(0.009, 0.2), "pull") => now;  
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
    if (  pianocounter % 2 == 0 )
    {
        for (0 => int i; i < inversion.cap(); i++)
        {
            jazz.generateChord(roots[i], chordquality[i], inversion[i]);
            Std.mtof(jazz.Chord[0]) => voc0.freq;
            Std.mtof(jazz.Chord[1]) => voc1.freq;
            Std.mtof(jazz.Chord[2]) => voc2.freq;
            Std.mtof(jazz.Chord[3]) => voc3.freq;
            .023 => voc0.gain => voc1.gain => voc2.gain => voc3.gain;
            Std.rand2f(-1, 1) => p2.pan;
            (4.12::bpm.dur["quarter"]) + Std.rand2f(.12, 1.12)::bpm.dur["tThirtysecond"] => now;       
        }
    }
}    

fun void clarinet()
{    
    jazz.ShuffleArray(melody) @=> melody;
    
    for (0 => int i ; i < melody.cap(); i++)
    {
        Std.mtof(jazz.Chord[0] + melody[i]) => clar.freq;
        1 => clar.noteOn; 
        .13 => clar.gain;
        swing(Std.rand2(2, 5)::bpm.dur["eighth"], 1::bpm.dur["sixtyfourth"], 1::bpm.dur["tSixteenth"], Std.rand2f(0.12, 0.14), "push") => now;  
        1 => clar.stopBlowing;
    }
}