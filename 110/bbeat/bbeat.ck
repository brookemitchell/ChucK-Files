// sound file
"./Shacky.wav" => string filename;
if( me.args() ) me.arg(0) => filename;
Gain M;
.6 => M.gain;
Gain ss;
Gain ch;
Gain dr;
Gain fl;
Gain sitgg;
.5 => sitgg.gain;
1 => int sw;

// the patch 
SndBuf buf => Gain g => M => dac;
0 => g.gain;
// load the file
filename => buf.read;
buf.samples() =>  int xxx;
xxx::samp => dur bar;
.125::bar => dur slice;
xxx / 8 => int slicex;


////"Score"
spork ~ beat();
1::bar => now;
spork ~ chord();
3.5::bar => now;
.25 => g.gain;
spork ~ bbeat();
.5::bar => now;
spork ~ melo();
8::bar => now;
0 => g.gain;  
.1 => ss.gain;
spork ~ thing1();
6::bar => now;
spork ~ melo();
spork ~ melo();
spork ~ melo();
.3 => g.gain;
.4 => ss.gain;
24::bar => now;
0 => g.gain;
0 => dr.gain;
24::bar => now;
spork ~ thing2();
4::bar => now;
spork ~ thing2();
.2 => ss.gain;
.1 => ch.gain;
4::bar => now;
.08 => ss.gain; 
spork ~ thing2();
0 => sw;
2::bar => now;
.2 => fl.gain;
spork ~ thing2();
spork ~ thing2();
spork ~ thing2();
4::bar => now;
0 => ss.gain => fl.gain;
1 => sw;
.7 => g.gain;
spork ~ bbeat();
20::bar => now;
.7 => ss.gain;
.3 => ch.gain;
0 => sitgg.gain;
.65 => fl.gain => dr.gain;
//LOOP forevagg
while( true )
{
1::second => now;
}







///sporkzz

fun void bbeat()
{
//breakbeat start
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
1  => buf.pos;
.25::slice => now;
-1 => buf.rate;
slicex => buf.pos;
1::slice => now;

// loop random slices
while( sw == 1 )
{
	Std.rand2(0,7)  => int d;
	slicex * d => int f;
	f => buf.pos;
    Std.rand2f(.6,.9) => buf.gain;
    1 => buf.rate;
    slice => now;
}
}

//
//melodysporkkk
//
fun void melo()
{
BlitSquare s => JCRev r => ss =>  M => dac;
.2 => s.gain;
.2 => r.mix;
4 => s.harmonics;
[ 0, 2, 4, 7, 9 ] @=> int scale[];
while( true )
	{
    Std.mtof( 33 + Std.rand2(1,4) * 12 +
        scale[Std.rand2(0,scale.cap()-1)] ) => s.freq;
    	.5::slice => now;
	}

}
//
//beatzsporkk
//
fun void beat()
{


SinOsc bd => ADSR bda => dr => M => dac;
Noise sn => ADSR sna => dr => M => dac;
100 => bd.freq;
.8 => bd.gain;
.12 => sn.gain;

bda.set(1::ms, 70::ms, 0, 10::ms );
sna.set(1::ms, 10::ms, 0, 10::ms );
while( true )
	{
 bda.keyOn();
	slice => now;
 bda.keyOff();
 bda.keyOn();
 sna.keyOn();
	slice => now;
 sna.keyOff();
 bda.keyOff();
	}
}


//
//chordspork
//
fun void chord()
{
TriOsc t1 => ch => Envelope e => M => dac;
TriOsc t2 => ch => e => M => dac;
TriOsc t3 => ch => e => M => dac;

.3 => ch.gain;

 
2::slice  => e.duration;
// notes for the chordz
[ 0, 2, 4, 7, 9 ] @=> int chordtone[];

//loop play!
while( true )
{
    Std.mtof( 33 + Std.rand2(1,3) * 12 +
    chordtone[Std.rand2(0,chordtone.cap()-1)] ) => t1.freq;

    Std.mtof( 33 + Std.rand2(1,3) * 12 +
    chordtone[Std.rand2(0,chordtone.cap()-1)] ) => t2.freq;

    Std.mtof( 33 + Std.rand2(1,3) * 12 +
    chordtone[Std.rand2(0,chordtone.cap()-1)] ) => t3.freq; 

		//envelope
		e.keyOn();
		6::slice => now;
		e.keyOff();
		2::slice => now;
}

}
//
///FLUTESPORK

fun void thing1()
{
BlitSaw flute => JCRev flurev => fl => M => dac;
.9 => fl.gain;
6 => flute.harmonics;
.4 => flute.gain;
.40 => flurev.mix;



0 => int i;
[ 2, 4, 7, 9, 11, 12 ] @=> int fluscale[]; 
[ 2, 4, 9, 7, 14, 12 ] @=> int fluscale1[];
[ 0, 2, 4, 7, 9, 7 ] @=> int fluscale2[];
while( true )
{
			Std.rand2(0,5) => int flurand;
if( flurand == 1 )
	{
	Std.mtof(57 + fluscale1[i] ) => flute.freq;
//	.7 => flute.noteOn;
	.5::slice => now;
	i + 1 => i;
		if( i >= fluscale1.cap()  )
			{ 
				0 => i;
			 }


	}

if( flurand == 2 )
	{
	Std.mtof(57 + fluscale2[i] ) => flute.freq;
//	.7 => flute.noteOn;
	.5::slice => now;
	i + 1 => i;
		if( i >= fluscale2.cap()  )
			{ 
				0 => i;
			 }


	}

else
		{	
	Std.mtof(57 + fluscale[i] ) => flute.freq;
//	.7 => flute.noteOn;
	.5::slice => now;
	i + 1 => i;
		if( i >= fluscale.cap()  )
			{ 
				0 => i;
			 }
		}	

	}

}


fun void thing2()
{
Sitar sit => Gain sitg => Envelope siten => sitgg => M => dac;
sitg => Gain feed => DelayL delay => sitg;


//.62 => sit.pluck;
//.68 => sit.gain;
.5::slice => delay.max => delay.delay;
.9 => feed.gain;
1 => delay.gain;
2::slice => siten.duration;


[2, 4, 6, 7, 9, 11] @=> int sitscale[]; 
[2, 3, 4, 5, 9, 10, 13 ] @=> int sitdur[];
while( true )
	{
		Std.rand2(0,5) => int sitnote;
		Std.mtof((21 + sitscale[sitnote]) + (Std.rand2(0,3) * 12)) => sit.freq;
		Std.rand2(0,6) => int sitthang;
		2 => sit.noteOn;
		siten.keyOn();
		sitdur[sitthang]::slice => now;
		siten.keyOff();
		sitdur[sitthang]::slice => now;
	}



}




