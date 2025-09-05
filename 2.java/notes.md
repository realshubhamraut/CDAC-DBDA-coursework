1. Three main methods to convert boolean to
String:
• String.valueOf (booleanValue) - Most
commonly used, handles null safely
• Boolean. toString (booleanValue) - Static
method from Boolean class
• String concatenation ( booleanValue + ''* )-
Automatic conversion



2. double quotes are required in the Java, unlike the python
while doing System.out.println("text!")


3. this is how we convert boolean value into String

String ligthStatus = String.value0f(isLightOn);
String rainStatus = String.value0f(isRaining);

4. autoboxing is converting primitive to their corresponding wrapper classes

5. 

![referece](/img-refs/autoboxing.png)

booleans can be null primitives cannot

show only methods that are needed is called abstraction
polymorphisms - taking different shapes or as needed evertime


// Write a class Employee Management.
Declaore variables for id, name, slalary, holidays, address
Declare methods for calculating the salary of that emploee based on number of days he hwas worked. Take 3 types of empleyees
1. Manager ( daily salary 500rs)
2. Peon (Dauly sal 100)
3. New Joinee (Daily Sal 200)

Now call all emploee objects form main method class.
Create constructors of 3 types, Initialize ID of employees through consttructor
Display who is getting highest salary for that month and what amoungt?
use this to refer to current object
Use static keyword also.
