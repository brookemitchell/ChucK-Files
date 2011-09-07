//Recursion
fun int factorial(int x)
{
 if (x <= 1)
 {
     return 1; //usually need a way out
}
else
{
    return (x*factorial(x-1)); //calls itself
    
}
}

<<<factorial(4)>>>;

/*

same as 4!

factorial (4) x=4 ans 4.factorial(3)
factorial (3) x=3 ans 3.factorial(2)
factorial (2) x=2 ans 2.factorial(1)
factorial (1) x=1 ans 1.factorial(1) // hey look we have an snswer

//goes up a step and plugs in
factorial (2) x=2 ans 2.1(1) //becomes
factorial (3) x=3 ans 3.1(2)
factorial (4) x=4 ans 4.2(3)


