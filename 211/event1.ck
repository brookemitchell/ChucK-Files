//Events

Event e;

fun void print()
{
    while(true)
    {
        e => now;
        <<<" I just woke up!">>>;
    }
}

spork ~ print();

5::second => now;
e.signal(); //wake up FIRST shred waiting on event
2::second => now;
e.broadcast(); //wake up all shred waiting on event
1::second => now;