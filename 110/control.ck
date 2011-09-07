TIME bpm;

SndBuf openHat => ADSR hatenv => Gain master => dac;
SndBuf openHat2 => ADSR hat2env => master;

SinOsc voc0 => Gain rhgain => ADSR Rhodenv => Echo e =>  master;
SinOsc voc1 => rhgain;
SinOsc voc2 => rhgain;
SinOsc voc3 => rhgain;
Clarinet clar => JCRev clarrev => master;

0=>voc0.gain;
0=>voc1.gain;
0=>voc2.gain;
0=>voc3.gain;

"data/ge/hihat-open.wav" => openHat.read;
"data/ge/hihat-open.wav" => openHat2.read;

.3 => clar.reed;
329.6276  => clar.vibratoFreq;
.3=> clar.vibratoGain;
0.2 => clar.gain;

Rhodenv.set( 400::ms, 620::ms, 1, 2000::ms );  

.4=> rhgain.gain;

100::ms => e.delay;

0 => openHat.gain;
0 => openHat2.gain;
1 => master.gain;

bpm.tempo(55.0);

8.33333333333333333333333333333333333334::bpm.myDurations["eighth"] => dur sync;
sync - (now % sync) => now;

0 => int hatcounter;
0 => int flag;