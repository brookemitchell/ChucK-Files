//Controlling SndBuf rate with a swell function
//2010 Jordan Hochenbaum

"data/ge/snare-hop.wav" => string snarefile;
SndBuf snare => dac;
snarefile => snare.read;
0 => int swellCounter;

snare.samples() => int snareLength; //snarefile length in samples

while(true){
    swell(0.2, 2, .1);
    swellCounter++;
    <<<"I have swelled ", swellCounter, "times">>>;
}

fun void swell(float begin, float end, float grain)
{
    for (begin => float j; j < end; j+grain => j)
    {
        0 => snare.pos;
        j => snare.rate;
        //.1::second => now;  
        (snareLength/j)::samp => now; 
        <<<"current rate: ",j, "play duration: ", j>>>;
    }
    
    for (end => float j; j > begin; j-grain => j)
    {
        0 => snare.pos;
        j => snare.rate;
        .1::second => now; 
        <<<"current rate: ", j, "play duration .1 sec">>>;
    } 
}
