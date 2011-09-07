SinOsc s => dac;
.5 => s.gain;

int melody[0]; //create array no elements

0 => int counter;

while (counter < 2)
{
    if (counter == 0)
    {        
        melodyMaker(65);
    } 
    else if (counter == 1)
    {
        melody2Maker(65);
    }
    
    for (0 => int i; i < melody.cap(); i++)
    {
        <<< melody[i] >>>;
        Std.mtof(melody [i]) => s.freq;
        .25::second => now;
    }    
            
//    if counter (counter  == 2)
  //  {
    //    0=>counter;
      //  0 => melody.size;
        //counter++;
   // }
}

//functions defined here
fun void melodyMaker(int x)
{    
    melody << x << x +5 << x+12; 
}

fun void melody2Maker(int x)
{    
    melody << x << x+ 12 << x+5;    
}