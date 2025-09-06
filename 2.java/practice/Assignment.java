//Write a class EmployeeManagement.
// Declare variables for id, name, salary, holidays, address.
// Declare methods for calculating the salary of that employee based on
// number of days he has worked. Take 3 classes for types of employees.
// 1. Manager (Daily Salary 500 rs)
// 2. Peon (Daily Sal 100)
// 3. New Joinee (Daily Sal 200)

// Now call all employee objects from main method class.
// Create COnstructors of 3 types. Initialize ID of employees through
// constructor only

// Display who is getting highest salary for that month and what amount?
// use this to refer to current objcet.

class EmployeeManagement {
    int id;
    String name;
    int holidays;
    String address;
    int salary;

    EmployeeManagement(int id, String name, int holidays, String address) {
        this.id = id;
        this.name = name;
        this.holidays = holidays;
        this.address = address;
    }

    int calculateSalary(int daysWorked, int dailySalary) {
        this.salary = daysWorked * dailySalary;
        return this.salary;
    }

    void display() {
        System.out.println("ID: " + id + ", Name: " + name + ", Salary: " + salary + ", Address: " + address);
    }
}

class Manager extends EmployeeManagement {
    static final int DAILY_SALARY = 500;
    Manager(int id, String name, int holidays, String address) {
        super(id, name, holidays, address);
    }
}

class Peon extends EmployeeManagement {
    static final int DAILY_SALARY = 100;
    Peon(int id, String name, int holidays, String address) {
        super(id, name, holidays, address);
    }
}

class NewJoinee extends EmployeeManagement {
    static final int DAILY_SALARY = 200;
    NewJoinee(int id, String name, int holidays, String address) {
        super(id, name, holidays, address);
    }
}

public class Assignment {
    public static void main(String[] args) {
        int totalDays = 30;

        Manager m = new Manager(1, "Amit", 2, "Pune");
        Peon p = new Peon(2, "Sumit", 1, "Mumbai");
        NewJoinee n = new NewJoinee(3, "Ravi", 0, "Delhi");

        int mSalary = m.calculateSalary(totalDays - m.holidays, Manager.DAILY_SALARY);
        int pSalary = p.calculateSalary(totalDays - p.holidays, Peon.DAILY_SALARY);
        int nSalary = n.calculateSalary(totalDays - n.holidays, NewJoinee.DAILY_SALARY);

        m.display();
        p.display();
        n.display();

        // Find highest salary
        EmployeeManagement highest = m;
        if (p.salary > highest.salary) highest = p;
        if (n.salary > highest.salary) highest = n;

        System.out.println("Highest salary: " + highest.name + " with amount " + highest.salary);
    }