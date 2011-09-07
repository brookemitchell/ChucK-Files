fun int[] ShuffleArray (int InputArray[])
{
  //  int NewArray[];
    InputArray @=> int NewArray[];
    
    for (InputArray.cap() -1 => int n; n > -1; n--)
    {
        Std.rand2(0, n) => int ChangeIndex;
        InputArray[ChangeIndex] => int a;
        InputArray[n] => int b;
        a => InputArray[n];
        b => InputArray[ChangeIndex];
    }
    return NewArray;
}

// tests below, print results,

[1,2,3,4,5] @=> int MyArray[];

for (0 => int i; i < MyArray.cap(); i++)
{
    <<<"Array " + (i+1) + ":" +MyArray[i]>>>;
}
<<<"SHUFFLE GO!">>>;

ShuffleArray(MyArray) @=> MyArray;

for (0 => int i; i <MyArray.cap(); i++)
{
    <<<"Array " + (i+1) + ":" +MyArray[i]>>>;
}