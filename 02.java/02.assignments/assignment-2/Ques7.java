// Write a Java program to create a Student class with private variables name and marks.
// Use getters to retrieve and setters to modify the values.

class Student{
    private String name;
    private int marks;

    public String getName(){
        return name;
    }

    public int getMarks(){
        return marks;
    }

    public void setName(String name){
        this.name = name;
    }

    public void setMarks(int marks){
        this.marks = marks;
    }
}


public class Ques7 {
    public static void main(String[] args){


    Student st = new Student();
    System.out.println("Name: " + st.getName());
    System.out.println("Marks: " + st.getMarks());
    st.setName("Shubham");
    st.setMarks(500);
    System.out.println("Name: " + st.getName());
    System.out.println("Marks: " + st.getMarks());
    

    }
    
}
