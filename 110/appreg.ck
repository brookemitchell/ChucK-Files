Sinosc s => dac;

arpeggio

fun void arpeggio(MidiMsg mymsg){
    MidiMsg message;
    mymsg.data1 => message.data1;
    mymsg.data2 => message.data2;
    mymsg.data3 => message.data3;
    
    [0,4,3,4,5,-5,-4,-3] @=>  int scale[];
    for ( 0 => int i; i < scale.cap();  i++){
        144 => message.data1;
        scale[i] +=> message.data2;
        mout.send(message);
        300::ms => now;
        128 => message.data1;
        mout.send(message);
    }}
