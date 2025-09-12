// Write a Java program with an abstract class Employee that has an abstract method
// calculateSalary (). Implement it in FullTimeEmployee and PartTimeEmployee classes.


abstract class Employee{
    abstract public void calculateSalary();

}


class FullTimeEmployee extends Employee{
    int salary;

    public FullTimeEmployee(int salary){
        this.salary = salary;
    }

    public void calculateSalary(){
        System.out.println("your salary as an Fulltime employee is about : " + salary);
    }
}

class PartTimeEmployee extends Employee{
    int salary;
    public PartTimeEmployee(int salary){
        this.salary = salary;
    }

    public void calculateSalary(){
        System.out.println("Your salaray as the parttime employee is about:" + salary);
    }

}
public class Ques24 {
    public static void main(String[] args){
        FullTimeEmployee ft = new FullTimeEmployee(10000);
        PartTimeEmployee pt = new PartTimeEmployee(4000);

        ft.calculateSalary();
        pt.calculateSalary();
    }
    
}
