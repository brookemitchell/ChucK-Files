SinOsc s => dac;

440 => s.freq;

//variable to hold index position
0 => int i;

//fancy array
[.23, .5, 0, 1, 2, 3] @=> float freqMod[];

//program loop
while (true) {
    
    200::ms => now;
    (i + 1) % freqMod.cap() => i; //modulos through i values (same as 6)
    <<<i>>>;
    440 * freqMod[i] => s.freq; // i represents position in array (start pos 0)
    
    
}