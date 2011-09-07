//Events
Event e;

fun void eventshred(Event e, string msg)
{
    while(true)
    {
        e => now;
        <<<msg>>>;
    }
}

spork ~ eventshred(e, "fee");
spork ~ eventshred(e, "fi");
spork ~ eventshred(e, "fo");
spork ~ eventshred(e, "fum");

while(true)
{
    <<<maybe>>>;
    if (maybe)
    {
        <<<"signalling...">>>;
        e.signal();
    }
    else
    {
        <<<"broadcasting...">>>;
        e.broadcast();
    }
    1::second=>now;
}