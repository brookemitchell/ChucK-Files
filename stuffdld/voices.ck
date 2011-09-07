// voices_from_file.ck
// copyright 2007 Les Hall
// creates multiple voices using FFT/IFFT
// Takes female singer's voice and adds a subharmonic copy that sounds like 
// an additional male singer in synchronization with her.  

// our patch
SndBuf sndbuf => Gain g1 => LPF lpf1 => FFT fft => blackhole;
IFFT ifft => LPF lpf2 => Gain g2 => dac;

// set controlling parameters
1024 => int num_samples;            // number of samples per fft, use binary multiple
2 => float overlap_factor;          // overlaps the fft window, use number > 1
0.50 => float af;                   // amplitude decay factor
0.80 => float k;                    // second voice is at this multiple
1 => int n;                         // number of voices to add in addition to original voice

// sound buffer parameters
0 => sndbuf.loop;
0.5 => sndbuf.gain;
"infile.wav" => sndbuf.read;

// set gains
1.0 / (n + 1) => g1.gain;
1.0 => g2.gain;

// set up filters
lpf1.freq(10000);
lpf2.freq(10000);

// set windowing
Windowing.hamming(num_samples) => fft.window;
Windowing.hamming(num_samples) => ifft.window;

// fft and ifft sizes
num_samples => fft.size;
num_samples / 2 => ifft.size;

// declare variables
num_samples / 2  => int num_freq;
complex spec_in[num_samples/2];
complex spec_out[num_samples/2];
string fft_string;
string next_char;

// control loop
num_samples::samp => now;
while( true )
{
    // take fft, save output as a UAnaBlob, and extract complex spectrum
    fft.upchuck().cvals() @=> spec_in;

    // copy input spectrum into output spectrum  
    spec_in @=> spec_out;

    // copy the voice at fractional harmonic
    for (1 => int ni; ni <= n; ni++) {
        Math.pow (k, ni) => float fraction;
        for (0 => int i; i < num_freq; i++) {
            (fraction * i) $ int => int i_out;
            if ((i_out > 0) && (i_out < num_freq)) {
                2 / ni * spec_in[i] +=> spec_out[i_out];
            }
        }
    }

    // do ifft on the transformed spectrum
    ifft.transform(spec_out);

    // advance time
    fft.size()::samp / overlap_factor => now;
}



