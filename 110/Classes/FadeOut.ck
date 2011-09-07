//FadeOut.ck

VControl.vc;

for (1.0 => float i ; i <= 0.1 ; .01 -=> i)
{
    <<<i>>>;
    vc.set_mvolume(i);
    .1::second => now;
}