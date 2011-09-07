Gain g => NRev r => Echo e => Echo e2 => dac;
// direct/dry
volcontrol vc;

g => dac;
e => dac;

// set up delay, gain, and mix
.02::sixtyfourth => e.max => e.delay;
.02::sixtyfourth => e2.max => e2.delay;
0 => g.gain;
.5 => e.gain;
.25 => e2.gain;
.1 => r.mix;


imp.connect( g );
// set the radius (should never be more than 1)
imp.radius( .999 );

// an array ( scale)
[ 2, 4, 7, 9, 11 ] @=> int hi[];

// infinite time-loop
while( true )
{
    // trigger
    55 + Std.rand2(2,3) * 12 + 
    hi[Std.rand2(0,hi.cap()-1)] => imp.t;
    // let time pass
    2::sixteenth => now;
    // close the envelope
    vc.get_ivol()=>g.gain;
    imp.c();
    // let a bit more time pass
    4::sixteenth => now;
    
    
}