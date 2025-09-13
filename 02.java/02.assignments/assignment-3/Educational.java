class Person{
    String name;
    int age;

    Person(String name,int age){
        if(age<=0){
            System.out.println("Provide vaild data...");
        }
        else{
            this.name=name;
            this.age=age;
        }
    }
    void setname(String name){
        this.name=name;
    }
    void setage(int age){
        if(age<0){
            System.out.println("Provide vaild data...");
        }
        else{
            this.age=age;
        }
    }

    String getname(){
        return name;
    }
    int getage(){
        return age;
    }

    void display(){
        System.out.println("Name : "+name+" Age : "+age);
    }
}
class Student extends Person{
    String grade;

    Student(String name,int age,String grade){
        super(name,age);
        this.grade=grade;
    }
    Student(String name,int age){
        super(name,age);
    }

    void setgrade(String grade){
        this.grade=grade;
    }
    String getgrade(){
        return grade;
    }

    void displayAll(){
        super.display();
        System.out.println("Grade : "+grade);
    }
}

public class Educational{
    public static void main(String[] args) {
        Student s=new Student("neha",22,"12th");
        s.displayAll();

        Student s1=new Student("prapti",0);
        s1.display();

        s1.setage(24);
        s1.display();
    }
} 