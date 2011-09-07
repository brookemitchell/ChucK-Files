//Chuck into processing Lect 8

// Send Osc

"localhost" => string hostname;
12001 => int port;

OscSend xmit; // send object

xmit.setHost(hostname, port); //Aim Transmitter

KeyStation49 p;

fun void OscKey(string msg, int i,){
    xmit.startMsg(msg, "if);
    i => xmit.addInt;
}

fun void OscKnob(string msg, int i)
{
    f => xmit.addFloat;
    i => xmit.addInt;
}

while (true){
    OscKey("/key", p.key, p.vol);
    OscKnob("/knob", p.knob);
    .2::second=> now;
}