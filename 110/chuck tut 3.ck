SawOsc s1 => PRCRev g => dac;
SawOsc s2 => g;
.5 => g.gain => g.mix;
200 => s1.freq;
s1.freq() * 2 => s1.freq;
3::second => now;