Techno tec;

1::second => dur sync;
sync - (now % sync) => now;
now % sync => dur beat;


//Time
now + 1::minute => time later;

//set bpm &  time divisions
193.1 => float bpm;
60::second / bpm => dur crotchet;
crotchet * 4.0 => dur bar;
crotchet / 4.0 => dur semiquaver;

// connect the rest of the patch
Gain g => NRev r => Echo e => Echo e2 => dac;
// direct/dry
g => dac;
e => dac;

// set up delay, gain, and mix
1500::ms => e.max => e.delay;
tec.EulerValues[1]*3000::ms => e2.max => e2.delay;
1 => g.gain;
 tec.EulerValues[2] => e.gain;
tec.EulerValues[1] => e2.gain;
tec.EulerValues[0] => r.mix;

tec.connect( g );
// set the radius (should never be more than 1)
tec.radius( .999 );

// an array 
[ 0, 2, 4, 7, 9, 11 ] @=> int hi[];

// infinite time-loop
while( true )
{      
    //  now % 4 => int beat;
   
        tec.EulerValues[0] => tec.buf1.gain;
        tec.EulerValues[1]=> tec.buf1.rate;
        tec.EulerValues[2] => tec.buf1.freq;
        
        //   100::ms => now;
        // trigger
        45 + Std.rand2(0,3) * (12)+ 
        hi[Std.rand2(0,hi.cap()-1)] => tec.t;
        // let time pass
        195::ms => now;
        // close the envelope
        tec.c();
        // let a bit more time pass
        5::ms => now;
        
        //4 hit division
        for (0 => int i; i<4; i++)
        {
            //Kick
            if( i == 0 )
            {
                kickbasic (4,0.4,1);
                .25::second => now;
            }
            //Snare
            if( i == 1 )
            {
                snarebasic (2,0.1,1);
               .5::second => now;
            }
        }
    }

    
    fun void kickbasic (int kickpos, float kickgain, float kickrate)
    {
        kickpos *((tec.EulerValues[0]*200) $ int) => tec.buf1.pos;
        tec.EulerValues[0] + tec.EulerValues[2] => tec.buf1.gain;
        tec.EulerValues[1]=> tec.buf1.rate;
    }
    
    fun void snarebasic (int snarepos, float snaregain, float snarerate)
    {
        snarepos *((tec.EulerValues[1]*40) $ int)  => tec.buf2.pos;
        tec.EulerValues[0] + tec.EulerValues[2] => tec.buf2.gain;
        tec.EulerValues[1]=> tec.buf2.rate;
    }
