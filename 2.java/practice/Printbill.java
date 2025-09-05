
// Classes, Objects, and Methods in Java (with a focus on real-world modeling and encapsulation)

// Your code demonstrates:

// How to define a class (Customer)
// How to use instance variables and methods
// How to create and use objects
// How to encapsulate logic (like bill calculation) within methods


class Customer{
    int id;
    String name;
    int unit_cons;
    int bill_gen;


    public void electricity_bill(int a, String b, int c){
        id = a;
        name = b;
        unit_cons = c;
        
        if (unit_cons<=100){
            bill_gen = unit_cons * 5;
            // System.out.println("bill generated" + bill_gen)
        }
        else if(unit_cons>100 && unit_cons<200){
            bill_gen = unit_cons * 7;
            // System.out.println("bill generated" + bill_gen)
        }
        else if(unit_cons>=200){
            bill_gen = unit_cons * 10;
            // System.out.println("bill generated" + bill_gen)
        }

    }
    public void display(){
        System.out.println("ID: " + id + " & Name:" + name + "Unit consumed " +unit_cons);

    }

  
    }

public class Printbill{
    public static void main(String args[]){
        Customer cst = new Customer();
        cst.electricity_bill(1,"Shubham",345);
        cst.display();

    }
}