SinOsc s => dac;

440 => s.freq;

//variable to hold index position
0 => int i;

//fancy array
[.23, .5, 0, 1, 2, 3] @=> float freqMod[];

//program loop
while (true) {
    
  //  (i + 1) % freqMod.cap() => i; //modulos through i values (same as 6)

 // i represents position in array (start pos 0)
    for (0 => int i; i < freqMod.cap(); i++){ //does same thing as modulo version
            <<<i>>>;
            200::ms => now;
            440 * freqMod[i] => s.freq;
        }
}