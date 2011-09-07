class INITSETUP
{
    fun string setup()
    {
        return "SinOsc s";
    }
}
class NEWSETUP1 extends INITSETUP
{
    fun string setup()
    {
        return "SawOsc s";
    }
}

//initialize initsetup

INITSETUP initsetup;

initsetup.setup() => dac;
1::second => now;

