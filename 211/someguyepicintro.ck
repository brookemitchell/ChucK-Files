// Gyration Air mouse saxophone instrument
// By Les Hall
// with Drums from the mighty kijjaz
// Rock on!  


GUITAR guitar;
0.5 => guitar.output.gain;
BS bsGuitar;

GUITAR guitar2;
0.5 => guitar2.output.gain;
BS bsGuitar2;

kjz_BDSDHH_02 bassDrum;
2.0 => bassDrum.output.gain;
BS bsBassDrum;

kjz_BDSDHH_02 snareDrum;
0.5 => snareDrum.output.gain;
BS bsSnareDrum;

kjz_BDSDHH_02 tomtomDrum;
0.5 => tomtomDrum.output.gain;
BS bsTomtomDrum;

PLAYER player;
bsGuitar.gate => player.guitarGate;
bsGuitar.output => player.guitarOutput;
bsGuitar2.gate => player.guitar2Gate;
bsGuitar2.output => player.guitar2Output;
bsBassDrum.gate => player.bassDrumGate;
bsBassDrum.output => player.bassDrumOutput;
bsSnareDrum.gate => player.snareDrumGate;
bsSnareDrum.output => player.snareDrumOutput;
bsTomtomDrum.gate => player.tomtomDrumGate;
bsTomtomDrum.output => player.tomtomDrumOutput;

CONTROLLER controller;




// control the music over time
class CONTROLLER
{
    1 => int notesPerSecond;
    16 => int drumsPerSecond;
    int nps;
    
    // guitar
    0.2 => player.bodySize;
    0.0 => player.stringDetune;
    bsGuitar.setTempo(notesPerSecond);
    bsGuitar.setBits(8, 0.5);
    guitar.output => dac.left;
    
    // guitar
    0.2 => player.bodySize2;
    0.0 => player.stringDetune2;
    bsGuitar2.setTempo(notesPerSecond);
    bsGuitar2.setBits(8, 0.5);
    guitar2.output => dac.right;
    
    // bass drum
    bsBassDrum.setTempo(drumsPerSecond/2);
    bsBassDrum.setBits(4, 0.75);
    bassDrum.output => dac;
    
    // snare drum
    bsSnareDrum.setTempo(drumsPerSecond);
    bsSnareDrum.setBits(5, 0.75);
    snareDrum.output => dac;
    
    // tomtom drum
    bsTomtomDrum.setTempo(drumsPerSecond);
    bsTomtomDrum.setBits(5, 0.75);
    tomtomDrum.output => dac;
    
    while(true)
    {
        // select random instrument
        Math.rand2f(0, 6) => float choice;
        
        // change up instruments
        if (choice < 1)
        {
            // guitar
            bsGuitar.setTempo(notesPerSecond);
            bsGuitar.setBits(8, 0.5);
        }
        else if (choice < 2)
        {
            // guitar2
            bsGuitar2.setTempo(notesPerSecond);
            bsGuitar2.setBits(8, 0.5);
        }
        else if (choice < 3)
        {
            // bass drum
            bsBassDrum.setTempo(drumsPerSecond/2);
            bsBassDrum.setBits(4, 0.75);
        }
        else if (choice < 4)
        {
            // snare drum
            bsSnareDrum.setTempo(drumsPerSecond);
            bsSnareDrum.setBits(5, 0.75);
        }
        else if (choice < 5)
        {
            // tomtom drum
            bsTomtomDrum.setTempo(drumsPerSecond);
            bsTomtomDrum.setBits(5, 0.75);
        }
        
        15::second => now;
    }
}




// play the various instruments
// by responding to BS outputs
// and calling instrument functions
class PLAYER
{
    1::ms => dur delay;
    0.2 => float bodySize;
    0.5 => float stringDetune;
    0.6 => float bodySize2;
    0.0 => float stringDetune2;
    
    Gain guitarGate => blackhole;
    Gain guitarOutput => blackhole;
    Gain guitar2Gate => blackhole;
    Gain guitar2Output => blackhole;
    Gain bassDrumGate => blackhole;
    Gain bassDrumOutput => blackhole;
    Gain snareDrumGate => blackhole;
    Gain snareDrumOutput => blackhole;
    Gain tomtomDrumGate => blackhole;
    Gain tomtomDrumOutput => blackhole;
    
    function void playGuitar()
    {
        float lastGate;
        float prevGate;
        float lastOutput;
        float prevOutput;
        
        while(true)
        {
            lastGate => prevGate;
            guitarGate.last() => lastGate;
            lastOutput => prevOutput;
            guitarOutput.last() => lastOutput;
            
            if ( (lastGate == true) && (prevGate == false) )
            {
                if (lastOutput != prevOutput)
                {
                    guitar.strum(20.0 + 310.0 * lastOutput, bodySize, stringDetune);
                }
            }
            
            delay => now;
        }
    }
    spork ~ playGuitar();
    
    function void playGuitar2()
    {
        float lastGate;
        float prevGate;
        float lastOutput;
        float prevOutput;
        
        while(true)
        {
            lastGate => prevGate;
            guitar2Gate.last() => lastGate;
            lastOutput => prevOutput;
            guitar2Output.last() => lastOutput;
            
            if ( (lastGate == true) && (prevGate == false) )
            {
                if (lastOutput != prevOutput)
                {
                    guitar2.strum(20.0 + 310.0 * lastOutput, bodySize2, stringDetune2);
                }
            }
            
            delay => now;
        }
    }
    spork ~ playGuitar2();
    
    function void playBassDrums()
    {
        float lastGate;
        float prevGate;
        
        bassDrum.BD();
        
        while(true)
        {
            lastGate => prevGate;
            bassDrumGate.last() => lastGate;
            
            if ( (lastGate == true) && (prevGate == false) )
            {
                bassDrum.hit(0.5);
            }
            
            delay => now;
        }
    }
    spork ~ playBassDrums();
    
    function void playSnareDrums()
    {
        float lastGate;
        float prevGate;
        
        snareDrum.SD();
        
        while(true)
        {
            lastGate => prevGate;
            snareDrumGate.last() => lastGate;
            
            if ( (lastGate == true) && (prevGate == false) )
            {
                snareDrum.hit(snareDrumOutput.last());
            }
            
            delay => now;
        }
    }
    spork ~ playSnareDrums();
    
    function void playTomtomDrums()
    {
        float lastGate;
        float prevGate;
        
        tomtomDrum.TT1();
        
        while(true)
        {
            lastGate => prevGate;
            tomtomDrumGate.last() => lastGate;
            
            if ( (lastGate == true) && (prevGate == false) )
            {
                tomtomDrum.hit(tomtomDrumOutput.last());
            }
            
            delay => now;
        }
    }
    spork ~ playTomtomDrums();
}




class GUITAR
{
    4 => int s;  // number of strings
    
    Mandolin str[s];
    SinOsc overdrive => Gain output;
    1 => overdrive.sync;
    
    for(int i; i<s; i++)
    {
        str[i] => overdrive;
        0.9 => str[i].stringDamping;
    }
    
    function void strum(float freq, float body, float detune)
    {
        for(int i; i<s; i++)
        {
            freq * (0.5 * i + 1) => str[i].freq;
            body => str[i].bodySize;
            detune => str[i].stringDetune;
        }
        for(int i; i<s; i++)
        {
            0.6 => str[i].pluck;
        }
    }
}






// Kijjaz's Noise+Sine Bass Drum, Snare Drum, Hi Hat machine ver. 0.2 prototype
// source code for ChucK programming language
// Copyright 2008 Kijjasak Triyanond (kijjaz@yahoo.com)
// This software is protected by the GNU General Public License.
// Feel free to use, modify, and distribute.

class kjz_BDSDHH_02
{
    second / samp => float SampleRate;
    
    // use BD(), SD(), TT1(), TT2(), TT3(), CH(), OH(), clave() to select sound preset
    // (note: CH = closed hi hat, OH = opened hi hat)
    // use hit() to just hit with velocity = 1
    // use hit(float) to hit with velocity = float
    // use hit(float1, float2) hit with tone velocity = float1, noise velocity = float2
    
    // to adjust, see tone(float), toneGlide(float), toneDecay(float), noiseDecay(float), noiseGain(float)
    // the noiseGain amount is just like FM index for the main oscillator
    
    // to connect to an output, just use output => ...
    
    // The Patch
    Step freq => LPF freq_f => SinOsc drumtone => Gain drumtone_g =>
    Dyno comp => LPF lpf1 => SinOsc overdrive => Gain output;
    
    Noise n => Gain n_g => drumtone;
    3 => n_g.op => drumtone_g.op;
    
    comp.compress();
    5 => comp.ratio;
    
    1 => overdrive.sync;
    
    Impulse n_i => Gain n_i_g => Gain n_i_g_fb => n_i_g => n_g;
    Impulse drumtone_i => Gain drumtone_i_g => Gain drumtone_i_g_fb => drumtone_i_g => drumtone_g;
    
    // Initiaization
    freq_f.set(500, 1);
    
    fun void BD()
    {
        50 => freq.next;
        lpf1.set(80, 5);
        100 => n_g.gain;
        1.0 - 30.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 100.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void SD()
    {
        300 => freq.next;
        // hpf1.set(30, 1);
        lpf1.set(6000, 4);
        2200 => n_g.gain;
        1.0 - 40.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 20.0/SampleRate => n_i_g_fb.gain;
    }
    
    fun void TT1()
    {
        200 => freq.next;
        lpf1.set(400, 2);
        20 => n_g.gain;
        1.0 - 90.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void TT2()
    {
        150 => freq.next;
        lpf1.set(300, 2);
        20 => n_g.gain;
        1.0 - 80.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void TT3()
    {
        100 => freq.next;
        lpf1.set(300, 2);
        20 => n_g.gain;
        1.0 - 60.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 60.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void CH()
    {
        5000 => freq.next;            
        lpf1.set(12000, 1);
        12000 => n_g.gain;
        1.0 - 200.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 50.0/SampleRate => n_i_g_fb.gain;
    }
    
    fun void OH()
    {
        5000 => freq.next;
        lpf1.set(8000, 3);
        12000 => n_g.gain;
        1.0 - 40.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 10.0/SampleRate => n_i_g_fb.gain;
    }
    
    fun void clave()
    {
        1200 => freq.next;
        lpf1.set(1000, 2);
        200 => n_g.gain;
        1.0 - 150.0/SampleRate => drumtone_i_g_fb.gain;
        1.0 - 120.0/SampleRate => n_i_g_fb.gain;    
    }
    
    fun void hit()
    {
        1 - n_i_g.last() => n_i.next;
        1 - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void hit(float vel)
    {
        vel - n_i_g.last() => n_i.next;
        vel - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void hit(float velTone, float velNoise)
    {
        velTone - n_i_g.last() => n_i.next;
        velNoise - drumtone_i_g.last() => drumtone_i.next;
    }
    
    fun void tone(float f)
    {
        f => freq.next;
    }
    
    fun void toneGlide(float rate)
    {
        rate => freq_f.freq;
    }
    
    fun void toneDecay(float rate)
    {
        1.0 - rate/SampleRate => drumtone_i_g_fb.gain;
    }
    
    fun void noiseDecay(float rate)
    {
        1.0 - rate/SampleRate => n_i_g_fb.gain;
    }
    
    fun void noiseGain(float g)
    {
        g => n_g.gain;
    }
}




// boolean sequencer
class BS
{
    int numBits;
    int maxCount;
    float bps;
    int pattern[32];
    int sync;
    float syncpause;
    
    Step value => Gain output;
    Step gate;
    
    function void setBits(int n, float bitProbability)
    {
        n => numBits;
        Math.pow(2, n) $ int => maxCount;
        for (0=>int i; i<n; i++)
        {
            0 => pattern[i];
            for (0=>int j; j<n; j++)
            {
                Std.rand2f(0, 1) => float p;
                p < bitProbability => int bit;
                bit << j |=> pattern[i];
            }
        }
    }
    setBits(8, 0.5);
    
    function void setTempo(float t)
    {
        1/t => bps;
    }
    setTempo(6);
    
    function void setGain(float g)
    {
        if (g < -2) -2 => g;
        else if (g > 2) 2 => g;
        g => output.gain;
    }
    setGain(1.0);
    
    function void timeLoop()
    {
        int count;
        int logicSum;
        while (true)
        {
            0 => logicSum;
            for (0=>int i; i<numBits; i++)
            {
                if ( (count & pattern[i]) == pattern[i])
                {
                    logicSum++;
                }
            }
            logicSum / (numBits $ float) => value.next;
            (logicSum > 0) => gate.next;
            
            (count + 1) % maxCount => count;
            bps::second => now;
        }
    }
    spork ~ timeLoop();
}




// time loop
while (true)
{
    second => now;
}
