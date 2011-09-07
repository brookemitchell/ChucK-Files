SinOsc s => dac;

440 => s.freq;
0 => int i;

[.23, .5, 0, 1, 2, 3] @=> float freqMod[];

while (true) {
    
    200::ms => now;
    (i + 1) % 6 => i;
    <<<i>>>;
    440 * freqMod[i] => s.freq; // i represents position in array (start pos 0)
}