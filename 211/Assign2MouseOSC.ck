PulseOsc s => PRCRev r => dac;
.1 => r.mix;

0 => s.sync;
0.2 => s.gain;


OscRecv recv;
12000 => recv.port;
recv.listen();

recv.event("/yMouse, i") @=> OscEvent yMouseEvent;

int yMouseValue;


fun void yMousePoller(){
    while (true){
        yMouseEvent => now;
        if (yMouseEvent.nextMsg() != 0){
            yMouseEvent.getInt() => yMouseValue;
            yMouseValue  => s.freq;
        }
    }
}

spork ~yMousePoller();
            