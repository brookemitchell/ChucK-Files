//Intro to midi
//rememb to use chuck --probe

SinOsc s => dac;
//0 => s.gain;

MidiIn min;
MidiMsg msg;

0 => int port;

//open the port

if (!min.open(port))
{
    <<<"Error: Midi Port did not Open on Port: ", port >>>;
}

while(true){
    min => now;
    while(min.recv(msg)){
        <<<msg.data1, msg.data2, msg.data3>>>;
        if (msg.data1 == 144){
            Std.mtof(msg.data2) => s.freq;
            msg.data3/127.0 => s.gain;
    }
}
}