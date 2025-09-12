// Write a Java program where a Phone class has a method call (). Create subclasses
// Smartphone and Landline that override call () differently.

class Phone{
    public void call(){
        System.out.println("This is a generic call");
    }
}


class Smartphone extends Phone{
    public void call(){
        System.out.println("This is a Smartphone call");
    }
}
class Landline extends Phone{
    public void call(){
        System.out.println("This is the Landline call");
    }
}
public class Ques19 {
    public static void main(String[] args){
        Phone p = new Phone();
        Smartphone s = new Smartphone();
        Landline l = new Landline();


        l.call();
        s.call();
        p.call();
    }
    
}
