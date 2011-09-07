//Overloading

fun int add(int x)
{
 return(x+x);   
}

fun int add( int x, int y)
{
    return (x+y);
}

add(1) => int foo; // will only use one with 1 variable even though same name
add(1,2) => int bar; //will call second function

<<<foo>>>;
<<<bar>>>;


//way to organise to decide what to do based on which arguments sent