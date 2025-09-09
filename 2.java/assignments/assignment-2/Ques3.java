// Create a base class Employee with attributes name and salary. Create a subclass
// Manager that adds bonus. Write a method to calculate the total salary.

import java.util.*;

class Employee{
    String name;
    int salary;

    Employee(String name, int salary){
        this.name = name;
        this.salary = salary;
    }
}

class Manager extends Employee{
    int bonus;

    Manager(String name, int salary, int bonus){
        super(name, salary);
        this.bonus = bonus;
    }

    int getTotalSalary(){
        return salary + bonus;
    }

    void Print(){
        System.out.println("person details");
        System.out.println("name" + name);
        System.out.println("without bonus " + salary);
        System.out.println("Total Salary " + getTotalSalary());

    }
}

public class Ques3{
    public static void main(String[] args){
        Manager m1 = new Manager("Shubham",2300,5000);
        m1.Print();
    }
    
}