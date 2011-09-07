//Time Ramp
//use graphing app

1000 => float timer;
0.0 => float x;

while (x<.95)
{
(((1-(X*X)*timer)+1)::ms => now; //+1 is offset to stop 0 time
x+.01 => x;
<<<x>>>;
}