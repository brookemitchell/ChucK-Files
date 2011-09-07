//
// CurveTable Envelope
//

class CurveEnvelope
{
	// members and default params
	Phasor drive => CurveTable curvetable => Gain multiplier;
	3 => multiplier.op;				// multiply the curve to the signal to make an envelope
	0. => multiplier.gain;			// we use this to gait the output, so start at 0.
	
	UGen source, out;
	
	-1 => drive.op;					// stop the driver for now
	-1 => multiplier.op;
	
	dac @=> out;
	1. => float gain;
	1::second => dur length;
	[0., 0., 0.,  1., 1., 0.,  2., 0.] => curvetable.coefs;	// triangle window (the sky is the limit!)
	
	// methods
	fun void setEnvelopeCoefs( float _coefs[] )
	{
		_coefs => curvetable.coefs;
	}
	
	fun void connectSource( UGen src )
	{
		src @=> source;
	}
	
	fun void connectOutput( UGen destination )
	{
		destination @=> out;
	}
	
	fun void trigger()
	{
		source => multiplier => out;			// connect things
		gain => multiplier.gain;				// open gait
		1 => drive.op;
		3 => multiplier.op;
		0. => drive.phase;						// reset driver to beginning of envelope curve
		1. / (length / second) => drive.freq;	// calculate speed of driver in Hz
		length => now;							// let it happen...
		0. => multiplier.gain;					// close gait
		-1 => drive.op;
		-1 => multiplier.op;
		source =< multiplier =< out;			// disconnect things
        me.yield();
	}
}


// let's see what Chuck can do...

10 => int n;  // rotating elements (probably don't need this 
              // many for a 50% overlap, but it reduces audible errors)

SinOsc s[n];
CurveEnvelope ce[n];

for( 0 => int i; i < n; i++ )
{
    0.1 => s[i].gain;
    
    // ENVELOPE TYPE //   (un-comment one)
    
    [0., 0., 0.,  1., 1., 0.,  2., 0.] => ce[i].setEnvelopeCoefs;  // triangle (default)
    //[0., 0., 2.,  0.1, 1., -5.,  1., 0.] => ce[i].setEnvelopeCoefs;  // percussive (like Env.perc in SuperCollider)
    //[0., 0., 5.,  0.9, 1., -2.,  1., 0.] => ce[i].setEnvelopeCoefs;  // reversed-percussive (Roads calls this type "rexpodec")
    
}

0 => int i;
0 => int count;

10::second+now => time later;

while(now < later)
{
    Std.rand2f(200., 2000.) => s[i].freq;
    ce[i].connectSource( s[i] );
    ce[i].connectOutput( dac );
    
    // GRAIN EFFICIENCY //  (un-comment one)
    
    Std.rand2f(0.001, 0.005)::second => ce[i].length;  // about 660 grains per second
    //0.0001::second => ce[i].length;                     // a lot more... 
    //1::second => ce[i].length;                        // listen to the envelope...
    
    
    spork ~ ce[i].trigger();
    me.yield();
    count++;
    ce[i].length/2. => now;
    (i+1)%n => i;
}

<<< "Averaged", count/10., "grains per second!" >>>;

1::second => now;  // let the last one finish
