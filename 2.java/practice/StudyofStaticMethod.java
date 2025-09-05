//basically updating the value of the instance
class Study {
    int instancevariable =5;
    static int staticVariable = 50;
    
}

public static void main(){

}

public class StudyofStaticMethod{
    public static void main(String args[]){
        Study std1 = new Study();
        Study std3 = new Study();
        std1.instancevariable = 10;  //here the value is changed in this particular only main value in the study class is not going to be changed
        System.out.println(std1.instancevariable);
        // System.out.println(std2.instancevariable);
        // System.out.println(std3.instancevariable);
        std1.staticVariable = 60;
        System.out.println(std3.staticVariable);

    }
    
}


//static variables are property of the class
// we can directly call the instance of the class without creating the object of it
// interview questions - static keyword, static method, and static block
