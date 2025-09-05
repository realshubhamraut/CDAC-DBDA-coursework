public class StudyCallClass {
    int req;
    int response;
    StudyCallClass(){
        
        System.out.println("I am unparameterized constructor");
    }
    StudyCallClass(int a){
        this();
        System.out.println("I am unparameterized constructor");

    }
    StudyCallClass(int a, int b){
        this(a);
        System.out.println("I am unparameterized constructor");

    }
}
class Study{
    public static void main(String args[]){
    StudyCallClass std1 = new StudyCallClass(12,151);
    }
}
