# Roboshop-Shell

VARIABLES
When we have some repetative content then we can declare that in 
variable and we can use that variable reference every where. 
Advantages is, if we change in place that impacts all the places
where that value is used.
a=10
name=sha
>Bash shell don't have the data types(10,Sha)
>Simply we can declare value
Variables names (a,name) should be using alphabets
and numbers and underscore
>if values having any special characters then double quote it.
>Access variable with $ as prefix and also optionally variable
name in flower braces
$var 0r ${var}

Special Variables ranges fro inputs
$0-$n-Arguments
$* for all values
$# for no. of Arguments
0$ to know the script name


Command Substitution variable is declared by using command output
var=$(command)

Artimetic Substitution variable is declared by solving arthimetic expression
var=$((expression))

today_date=$(date)
add=$((2+3))