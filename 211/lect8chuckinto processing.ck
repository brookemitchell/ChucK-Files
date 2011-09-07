//Chuck into processing Lect 8

// Send Osc

"localhost" => string hostname;
12001 => int port;

OscSend xmit; // send object

xmit.setHost(hostname, port); //Aim Transmitter

while (true){
    xmit.startMsg("/knob", "if"); //"ifff" etc
    Std.rand2(1,127) => xmit.addInt; // 
   Std.rand2f(1.0,127.0) => xmit.addFloat; // 
   .2::second=> now;
}