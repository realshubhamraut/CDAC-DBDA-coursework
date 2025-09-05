// passing method

class Student {
    int id;             //instance variable are inside the class outside the method
    String name;
    public void setValues(int a, String b){ //local variables are inside the metho
        id = a;
        name = b;

    }
    
    public void display(){
        System.out.println("Id: " +id + " & Name: " + name);

    }
}
public class StudyStudent{
    public static void main(String args[]){
        Student std = new Student();
        std.setValues(1,"Shubham");
        std.display();
    }

}



//customer class
//id, name, unitconsumend, billgenerated

// electricity bill
// if units consumed <= 100,
// then billgenerated = unit consumed * 5 units
// else unit consumed >100 and <200
//then billgenerated = unit consume * 7 units
//if units consume > 200
// then billgenerated = unit consumed * 10