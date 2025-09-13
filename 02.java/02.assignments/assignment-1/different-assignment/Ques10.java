//10. Write a program that would print the information (name, year of joining, salary, address) of
//three employees by creating a class named 'Employee'. The output should be as follows:
//Name Year of joining Address
//Robert 1994 64C- WallsStreat
//Sam 2000 68D- WallsStreat
//John 1999 26B- WallsStreat


class Employee {
    String name;
    int yoj;
    String address;

    Employee(String name, int yoj, String address) {
        this.name = name;
        this.yoj = yoj;
        this.address = address;
    }
    void print() {
        System.out.println(name + " " + yoj + " " + address);
    }
}

public class Ques10 {
    public static void main(String args[]) {
        System.out.println("Name       Year of joining  Address");
        Employee em = new Employee("Robert", 1994, "64C- WallsStreat");
        Employee em1 = new Employee("Sam", 2000, "68D- WallsStreat");
        Employee em2 = new Employee("John", 1999, "26B- WallsStreat");

        em.print();
        em1.print();
        em2.print();
    }
}