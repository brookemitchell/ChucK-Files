// banjo1.ck
// copyright 2007 Les Hall
// attempts to find pluck frequency usig fft

// set parameters
64 * 1024 => int num_samples;
64 => int lpf_freq;  // frequency limit to examine, makes ideal lpf

// our patch
adc => LPF lpf => FFT fft =^ Centroid cent => blackhole;

// set windowing
Windowing.hamming(num_samples) => fft.window;

// low-pass filter the input signal
lpf.freq(100);

// set parameters
num_samples => fft.size;
num_samples / 2  => int num_freq;
0.900 => float peak_threshold;
1 => float overlap_factor;
int peaks[num_samples / 2];
float fft_norm[num_samples / 2];
float max_peak;
int sound;
float ratio;
"" => string prev_sound;
string next_sound;
string fft_string;
string next_char;


// control loop
while( true )
{
    // take fft
    fft.upchuck();

    // find peak value
    0 => int peak;
    for (0 => int i; i < lpf_freq; i++) {
        if (fft.fval(i) > fft.fval(peak)) {
            fft.fval(i) => max_peak;
            i => peak;
        }
    }


    // normalize so that biggest frequency is one
    for (0 => int i; i < lpf_freq; i++) {
        if (max_peak != 0) {
            fft.fval(i) / max_peak => fft_norm[i];
        }
    }

    // print first few fft values
    for (0 => int i; i < lpf_freq; i++) {
        <<< fft_norm[i] >>>;
    }

    // find all peaks above threshold
    0 => int num_peaks;
    for (1 => int i; i < lpf_freq - 1; i++) {
        if ((fft_norm[i] > peak_threshold) && (fft_norm[i-1] < fft_norm[i]) && (fft_norm[i] > fft_norm[i+1])) {
           i => peaks[num_peaks];
           num_peaks++;
        }
    }

    // print output
    if (num_peaks > 0) {
        for (0 => int i; i < num_peaks; i++) {
            <<< i, peaks[i], fft_norm[peaks[i]] >>>;
        }
    }

    // draw crude fft
    " " => fft_string;
    for (0 => int i; i < lpf_freq; i++) {
        "." => next_char;
        for (0 => int j; j < num_peaks; j++) {
            if (peaks[j] == i) {
                if (fft_norm[i] > 0.1) "0" => next_char;
                if (fft_norm[i] > 0.2) "1" => next_char;
                if (fft_norm[i] > 0.3) "2" => next_char;
                if (fft_norm[i] > 0.4) "3" => next_char;
                if (fft_norm[i] > 0.5) "4" => next_char;
                if (fft_norm[i] > 0.6) "5" => next_char;
                if (fft_norm[i] > 0.7) "6" => next_char;
                if (fft_norm[i] > 0.8) "7" => next_char;
                if (fft_norm[i] > 0.9) "8" => next_char;
                if (fft_norm[i] == 1.0) "9" => next_char;
            }
        }
        fft_string + next_char => fft_string;
    }
    cent.upchuck();
    <<< fft_string, cent.fval(0) * second / samp / 2 >>>;

    // advance time
    fft.size()::samp / overlap_factor => now;

}


















