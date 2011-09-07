// Some Major13(#11) chord progressions 
SinOsc s => NRev r => dac; .2 => s.gain; int x; while(250::ms => now) x * 7 % 121 * 4 % 49 % 24 + 60 => Std.mtof => s.freq, x++;
