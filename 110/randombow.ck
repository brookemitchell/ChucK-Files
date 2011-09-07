Bowed bow => Echo e => dac;

1000::ms => e.max;
//int scale [5];
//[ 60, 62, 64, 65, 67, 69, 71 ] @=> int scale[];


[ 0, 2, 4, 7, 9 ] @=> int scale[];

while (true);
{
    Std.rand2f(0.2,0.8) => bow.bowPressure;
    //Std.mtof(scale[Std.rand2(0,scale.cap()-1]) => int freq;
    scale[Std.rand2(0,scale.cap()-1)] => int freq;
    220.0 * Math.pow( 1.05946, (Std.rand2(0,2)*12) + freq ) => bow.freq;
    Std.rand2f( 0.2, 0.9) => bow.startBowing; 
 //   Std.rand2f( 0.2, 0.9) => bow.rate; 
    100 => bow.noteOn; 
    
    
    500::ms => now;
    
    
}
