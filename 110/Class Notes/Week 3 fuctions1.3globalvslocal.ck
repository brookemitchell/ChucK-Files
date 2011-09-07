fun int myAdd(int x, int y)
{
    //local to function
    x + y => int c;
    return (c);
}
//global to program
//<<<c>>> //no! only exists in name space
myAdd(1, 12) => int c;; //can reuse outside function
<<<c>>>;