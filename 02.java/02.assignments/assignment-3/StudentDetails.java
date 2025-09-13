class Student1{
    int studentId; 
    String name; 
    double grade;

    Student1(int studentId, String name, double grade){
        this.studentId=studentId;
        this.name=name;
        this.grade=grade;
    }

    void updateGrade(double newGrade){
        try {
            if(grade<=0){
                throw new IllegalArgumentException("Grade must be positive");
            }
            
        } catch (IllegalArgumentException  e) {
            System.out.println("Enter valid Grade");
        }
        this.grade=newGrade;
    }
    void setStudentId(int studentId){
        this.studentId=studentId;
    }
    void setname(String name){
        this.name=name;
    }

    int getstudentId(){
        return studentId;
    }
    String getname(){
        return name;
    }
    double getgrade(){
        return grade;
    }
    void display(){
        System.out.println("Student Id : "+studentId+" Name : "+name+" Grade : "+grade);
    }
}

public class StudentDetails{
    public static void main(String[] args) {
        Student1 std = new Student1(1523,"neha",5);
        std.display();

        std.updateGrade(0);
        std.updateGrade(12);
        std.display();
    }
}