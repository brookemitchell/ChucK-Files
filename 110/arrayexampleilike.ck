// the period
.5::second => dur T;
// synchronize to period (for on-the-fly synchronization)
T - (now % T) => now;

// our patch
SinOsc s => JCRev r => dac;
// initialize
.03 => s.gain;
.30 => r.mix;

// scale (pentatonic; in semitones)
[ 0, 2, 4, 7, 9 ] @=> int scale[];

// infinite time loop
while( true )
{
    // pick something from the scale
    scale[ Math.rand2(0,4) ] => float freq;
    // get the final freq
    Std.mtof( 69 + (Std.rand2(0,3)*12 + freq) ) => s.freq;
    // reset phase for extra bandwidth
    0 => s.phase;
    
    // advance time
    if( Std.randf() > -.5 ) .25::T => now;
    else .5::T => now;
}
