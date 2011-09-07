"data/ge/kick.wav" => string kickfile;                      //Accessing samples
"data/ge/snare-hop.wav" => string hopfile;

SndBuf kick => Pan2 p1 => dac;                              //SndBuf with pan to digital analog conversion
SndBuf hop => Pan2 p2 => dac;
TriOsc z => dac;                                            //Chord Oscillators 
SinOsc y => dac;
SinOsc x => dac;
TriOsc w => Pan2 p4 => dac;                                 //Melody Oscillator with pan

[60,65,65,67,69,69] @=> int a[];                            //Chord Arrays
[64,69,69,71,64,64] @=> int b[];
[67,72,72,74,60,60] @=> int c[];
[0,0,76,76,74,74,71,0,71,71,72,71,0,69,67,69,71,71,72,71,71,69,
67,69,71,71,72,72,71,71,71,71,71,0,0,0,0,0,0,0,0,0,0,0] @=> int d[];        //Verse Melody Array
[82,83,83,83,83,83,83,83,81,81,81,81,81,81,81,81,81,81,81,81,0,0,0,0,
82,83,83,83,83,83,83,81,79,79,79,79,79,79,79,79,0,0,0,0,0]@=> int d1[];     //Chorus Melody Array
[1,0,0,1,0,1,0,0,0,0] @=> int e[];                                          //Arrays for sample triggering
[0,0,1,0,0,0,1,0,0,0] @=> int f[];

326::ms => dur p;                           //Duration Triggering
0=>int i;                                   //Named Variable Integers
0 => int q;
0=> int r;
int c1;

hopfile => hop.read;                        //Initialising samples
kickfile => kick.read;

.3 => kick.gain;                            //Initial volumes
0 => hop.gain;
0 => x.gain;
0 => y.gain;
0 => z.gain;
0 => w.gain;


for (1 => int c; c < 5; c++)                //4 note Count in
{if (c1 ==1)
{<<<"two!">>>;}
if (c1 ==2)
{<<<"three!">>>;}
if (c1 ==3)
{<<<"fo'">>>;}
c%4 => int c1;                          //Modulo to control different print outputs
0 => kick.pos;
Std.rand2f (2.5,2.7) => kick.rate;  //Randomised kick rate
Std.rand2f  (-1,1) => p1.pan;       //Randomised kick pan
p => now;}

0.2 => w.gain;                              //New volumes (for Oscillators only)
0.1 => x.gain;
0.1 => y.gain;
0.1 => z.gain;



for (0 => int k; k<4; k++)                  //Loops for repeating chord progression + drums
{for (0 => int s; s<25;s++)             
    
    {if (e[q] == 1)                     //Kick
    {Std.mtof (a[r]-12) => z.freq;                  //Chords
    Std.mtof (b[r]) => x.freq;
    Std.mtof (c[r]) => y.freq;
    if(k < 2)
    {Std.mtof (d[i]) => w.freq;}                //Verse Melody
    else
    {Std.mtof (d1[i]) => w.freq;}               //Chorus Melody
    Std.rand2f  (-.5,.5) => p4.pan;                  //Random Pan for melody
    Std.rand2f (.2,.4) => kick.rate;               //Random rate for kick sample
    Std.rand2f  (-1,1) => p1.pan;                  // Random pan for kick sample
    Std.rand2f (.3,.5)=> kick.gain;                //Random volume for kick sample
    0 => kick.pos;                                 //Triggering sample from 0 position
    p/2 => now;
    q++;                                           //Add to q
    i++;}                                          //Add to i
    
    if (f[q] == 1)                      //Snare
    {if(k < 2)                                      
    {Std.mtof (d[i]) => w.freq;}                //Verse melody
    else
    {Std.mtof (d1[i]) => w.freq;}               //Chorus
    Std.rand2f  (-1,1) => p4.pan;
    Std.rand2f (1.0,1.1) => hop.rate;              //Random rate for snare sample
    Std.rand2f  (-1,1) => p2.pan;                  // Random pan for snare sample
    Std.rand2f (.3,.5)=> hop.gain;                 //random volume for snare sample
    0 => hop.pos;                                  //Triggering sample from 0 position
    p/2 => now;                         
    q++;                                                                                                       
    i++;}  
    
    else
    {if(k < 2)                                      //Gaps between samples
    {Std.mtof (d[i]) => w.freq;}                //verse melody
    else
    {Std.mtof (d1[i]) => w.freq;}               //chorus melody
    Std.rand2f  (-.5,.5) => p4.pan;                  //melody pan
    p/2 => now;
    q++;                        
    i++;}
    
    if (q == 8)
    {r++;
    q -8 => q;}                                 //q reduced to 0 every 8 quavers to repeat beat
    
    if (s == 14)                                        // 2/4 Bar to play as 4th bar of measure
    {Std.mtof (a[r]-12) => z.freq;                  //Chords for bar
    Std.mtof (b[r]) => x.freq;
    Std.mtof (c[r]) => y.freq;
    if(k < 2)
    {Std.mtof (d[i]) => w.freq;}               //Verse melody
    else
    {Std.mtof (d1[i]) => w.freq;}              //Chorus melody
    Std.rand2f  (-.5,.5) => p4.pan;
    0 => kick.pos;                                 //Kick sample
    i++;
    p/2 => now;
    Std.mtof (a[r]-12) => z.freq;                  //Chords
    Std.mtof (b[r]) => x.freq;
    Std.mtof (c[r]) => y.freq;
    if(k < 2)                                      //Melodies
    {Std.mtof (d[i]) => w.freq;}
    else
    {Std.mtof (d1[i]) => w.freq;}
    Std.rand2f  (-.5,.5) => p4.pan;
    i++;
    p/2 => now;
    Std.mtof (d[i]) => w.freq;                     //Chords
    Std.mtof (a[r]-12) => z.freq;          
    Std.mtof (b[r]) => x.freq;
    if(k < 2)
    {Std.mtof (d[i]) => w.freq;}               //Melodies
    else
    {Std.mtof (d1[i]) => w.freq;}
    Std.rand2f  (-.5,.5) => p4.pan;
    0 => hop.pos;                                  //Snare Sample
    p/2 => now;
    Std.mtof (d[i]) => w.freq;                     //Chords
    Std.mtof (a[r]-12) => z.freq;
    Std.mtof (b[r]) => x.freq;
    if(k < 2)                                      //Melodies
    {Std.mtof (d[i]) => w.freq;}
    else
    {Std.mtof (d1[i]) => w.freq;}
    Std.rand2f  (-.5,.5) => p4.pan;
    i++;
    p/2 => now;
    i++;
    r++;}}
    i - d.cap () => i;                                    //i (melody) to 0 to repeat measure
    r - a.cap () => r; }                                  //r (harmony) to 0 to repeat chord progression
    
    
