// FadeIN.ck

VControl vc;

for (0.0 => float i; i < 1; i + .01 => i)
{    
<<<i>>>;
vc.set_mvolume(i);
.1::second => now;

}