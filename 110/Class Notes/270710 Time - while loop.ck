5::second + now => time end;
0 => int i;

while (now < end) 
{
    // will actually only run for 6 secs as while loop keeps waiting 2 secs before checking.
    <<<i>>>;
    2::second => now;
    i++;
}

//try parts with different time lengths adding to 30secs