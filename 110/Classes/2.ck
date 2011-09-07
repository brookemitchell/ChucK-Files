TriOsc t => Gain master => dac;

VControl vc;

while (true)
{
        vc.get_mvolume() => master.gain;

    .1::second => now;
}