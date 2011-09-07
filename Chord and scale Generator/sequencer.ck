//Allan Mitchell 300214807 CMPO 110 Fianl Assign
// Load Classes

Inst inst;
Harmony harm;
TIME bpm;
Arp arp;

//set class function variables
bpm.temposet(116);
inst.detunelfo(100, -20);

//Set initial scale and chord conditions
harm.setScale("Bb","Minor") @=> int scale[];

//Chord Gen Values: 1-5: scale[], Start Degree(1-7),  Flag Add 7ths, Flag Add 9ths, Flag Add 12ths, 
//3-5:  Spacing (0-3), Inversion(-6,6), Octave(-6, 6))
harm.chordGen(scale, 1, 1, 1, 1, 1, -2, -2) @=> int chord[];

//run sequence

circleof5ths();


//--------FUNCTIONS

//A few Differnt types of Arp's strung together for mega arpness

fun void arpspork(){
    while(1)
    {
        if (maybe){
            arp.Arp(chord,bpm.dur[11],"updown"); 
            arp.Arp(chord,bpm.dur[12],"down"); 
            arp.Arp(chord,bpm.dur[11],"downup"); 
            inst.mod();
        }
        else{
            harm.blueChord(scale) @=> scale;
            arp.Arp(chord,bpm.dur[11],"down");
            arp.Arp(chord,bpm.dur[11],"updown");
            arp.Arp(chord,bpm.dur[11],"down"); 
            inst.mod();
        }
    }
}

fun void arpspork2(){
    while(1)
    {
        
        if (maybe){
            harm.blueChord(scale) @=> scale;
            arp.Arp(chord,bpm.dur[12],"up"); 
            arp.Arp(chord,bpm.dur[11],"down"); 
            arp.Arp(chord,bpm.dur[12],"down"); 
            inst.mod();
        }
        else{
            arp.Arp(chord,bpm.dur[11],"updown");
            arp.Arp(chord,bpm.dur[11],"downup"); 
            inst.mod();
        }
    }
}

fun void arpspork3(){
    while(1)
    {
        
        if (maybe){
            harm.blueChord(scale) @=> scale;
            arp.Arp(chord,bpm.dur[11],"up"); 
            arp.Arp(chord,bpm.dur[11],"up"); 
            arp.Arp(chord,bpm.dur[13],"updown"); 
            arp.Arp(chord,bpm.dur[11],"up"); 
            arp.Arp(chord,bpm.dur[11],"updown");
            inst.mod();
        }
        else{
            arp.Arp(chord,bpm.dur[11],"updown");
            arp.Arp(chord,bpm.dur[12],"downup"); 
            arp.Arp(chord,bpm.dur[11],"updown");
            arp.Arp(chord,bpm.dur[13],"down"); 
            arp.Arp(chord,bpm.dur[11],"up"); 
            arp.Arp(chord,bpm.dur[13],"updown");
            inst.mod();
        }
    }
}

fun void circleof5ths(){
    spork ~ arpspork() @=> Shred @ bs;   
    (8)::bpm.dur["bar"] => now;
    
    Machine.remove( bs.id() );
    //set next new scale
    harm.setScale("Ab","Major") @=> scale;
    
    //Chord Gen Values: 1-5: scale[], Start Degree(1-7),  Flag Add 7ths, Flag Add 9ths, Flag Add 12ths, 
    //3-5:  Spacing (0-3), Inversion(-6,6), Octave(-6, 6))
    
    harm.chordGen(scale, 5, 1, 1, 1, 1, -1, 1) @=>  chord;
    spork ~ arpspork2() @=> Shred @ cs;   
    (3)::bpm.dur["bar"] => now;
    
    Machine.remove( cs.id() );
    harm.chordGen(scale, 7, 1, 0, 1, 1, -1, 1) @=>  chord;
    harm.setScale("Eb","Major") @=> scale;
    spork ~ hats() @=> Shred @ ht; 
    spork ~ arpspork() @=> Shred @ ds;  
    (2)::bpm.dur["bar"] => now;
    
    Machine.remove( ds.id() );
    harm.chordGen(scale, 4, 1, 1, 1, 2, 1, -1) @=>  chord;
    harm.setScale("Cb","Minor") @=> scale;
    spork ~ arpspork2() @=> Shred @ es;  
    (3)::bpm.dur["bar"] => now;
    
    Machine.remove( es.id() );
    harm.chordGen(scale, 3, 1, 0, 1, 3, 1, 5) @=>  chord;
    harm.setScale("G","Minor") @=> scale;
    spork ~ arpspork() @=> Shred @ fs;  
    (5)::bpm.dur["bar"] => now;
    
    Machine.remove( fs.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, -2, -1) @=>  chord;
    harm.setScale("D","Minor") @=> scale;
    spork ~ kick() @=> Shred @ kc;
    spork ~ arpspork2() @=> Shred @ gs;  
    (4)::bpm.dur["bar"] => now;
    
    Machine.remove( gs.id() );
    harm.chordGen(scale, 6, 1, 1, 1, 2, -2, -1) @=>  chord;
    harm.setScale("C","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ hs;  
    (2)::bpm.dur["bar"] => now;
    
    Machine.remove( hs.id() );
    harm.chordGen(scale, 7, 1, 1, 1, 2, -2, -1) @=>  chord;
    harm.setScale("E","Minor") @=> scale;
    spork ~ arpspork3() @=> Shred @ is;  
    (2)::bpm.dur["bar"] => now;
    
    Machine.remove( is.id() );
    harm.chordGen(scale, 1, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("D","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ js;  
    (2)::bpm.dur["bar"] => now;
    
    Machine.remove( js.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("A","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ ks;  
    (2)::bpm.dur["bar"] => now;
    
    Machine.remove( ks.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("F#","Minor") @=> scale;
    spork ~ arpspork3() @=> Shred @ ls;  
    (1)::bpm.dur["bar"] => now;
    
    //swap in kick break
    Machine.remove( ls.id() );
    Machine.remove( kc.id() );
    spork ~ kick2() @=> Shred @ kd;
    
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("E","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ ns;  
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( ns.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("G#","Minor") @=> scale;
    spork ~ arpspork3() @=> Shred @ os;  
    (1)::bpm.dur["bar"] => now;
    
    //final kick break
    Machine.remove( kd.id() );
    Machine.remove( os.id() );
    spork ~ kick3() @=> Shred @ ke;
    
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("B","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ ps;  
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( ps.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("F#","Major") @=> scale;
    spork ~ arpspork3() @=> Shred @ qs;  
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( qs.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("Bb","Minor") @=> scale;
    spork ~ arpspork3() @=> Shred @ rs;  
    <<<"HOME AGAIN">>>;
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( rs.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("Bb","Dorian") @=> scale;
    spork ~ arpspork3() @=> Shred @ ss;  
    <<<"For Fun">>>;
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( ss.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("Bb","Mixolydian") @=> scale;
    spork ~ arpspork3() @=> Shred @ ts;  
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( ts.id() );
    harm.chordGen(scale, 5, 1, 1, 1, 2, 2, -1) @=>  chord;
    harm.setScale("Bb","Locrian") @=> scale;
    spork ~ arpspork3() @=> Shred @ us;  
    (1)::bpm.dur["bar"] => now;
    
    Machine.remove( us.id() );
    harm.chordGen(scale, 1, 1, 1, 1, 1, 1, 1) @=>  chord;
    harm.setScale("Bb","Octatonic1") @=> scale;
    spork ~ arpspork3() @=> Shred @ vs;  
    (4)::bpm.dur["bar"] => now;
    
    
    Machine.remove( vs.id() );
    harm.chordGen(scale, 1, 1, 1, 1, 2, 2, 1) @=>  chord;
    harm.setScale("Bb","Octatonic2") @=> scale;
    spork ~ arpspork3() @=> Shred @ ws;  
    (12)::bpm.dur["bar"] => now;
    fadeout();
    <<<"LATERS!">>>;
}  


//Some not amazing pulsing hi-hats
fun void hats(){
    while(1)
    {
        Math.sin(1)* inst.l.Q() => inst.l.Q;
        
        2 %=> int hatcounter;
        hatcounter++;
        
        if ( hatcounter == 1 )
        {
            Std.rand2f(.1, .2) => inst.closeHat.gain;
            1 => inst.hat2env.keyOn;
            0 => inst.closeHat.pos;
            (1)::bpm.dur["sixteenth"] => now;
            0 => inst.hat2env.keyOff;        
        }
        else if ( hatcounter == 2)
        {        
            Std.rand2f(.2, .3) => inst.openHat.gain;
            1 => inst.hatenv.keyOn;
            Std.rand2(0, 100) => inst.openHat.pos;
            (1)::bpm.dur["tSixteenth"] => now;
            0 => inst.hatenv.keyOff;        
        }
        
    }
}
fun void kick(){
    while(1)
    {
        4 %=> int kickcounter;
        if ( kickcounter == 0 )
        {
            Std.rand2f(.1, .2) => inst.kick.gain;
            1 => inst.kickenv.keyOn;
            Std.rand2(1, 100) => inst.kick.pos;
            (1)::bpm.dur["dQuarter"] => now;
            0 => inst.kickenv.keyOff;        
        }
        kickcounter++;
    }
}


//A few kick drum variations
fun void kick2(){
    while(1)
    {
        4 %=> int kickcounter;
        if ( kickcounter == 0 )
        {
            1 => inst.kickenv.keyOn;
            Std.rand2(100, 1000) => inst.kick.pos;
            (1)::bpm.dur["tSixteenth"] => now;
            .01 => inst.kick.gain;
            0 => inst.kickenv.keyOff;        
        }
        kickcounter++;
    }
}

fun void kick3(){
    while(1)
    {
        2 %=> int kickcounter;
        if ( kickcounter == 0 )
        {
            1 => inst.kickenv.keyOn;
            Std.rand2(100, 1000) => inst.kick.pos;
            (1)::bpm.dur["tSixteenth"] => now;
            .09 => inst.kick.gain;
            0 => inst.kickenv.keyOff;        
        }
        kickcounter++;
    }
}

//And the obligatory fade out
fun void fadeout ()
{
    for (1.0 => float i ; i >= 0.01 ; .02 -=> i)
    {
        inst.mastergain(i);
        .01::second => now;
    }
}