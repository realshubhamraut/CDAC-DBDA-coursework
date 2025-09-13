//1.Create a class named 'Student' with String variable 'name' and integer variable 'roll no'. Assign
//the value of roll _no as '2' and that of name as "John" by creating an object of the class Student.

class Student{
	String name;
	int roll_no;
}

public class Ques1{
	public static void main(String[] args) {
		Student s = new Student();
		s.name = "John";
		s.roll_no = 2;
		
		System.out.println("Name: " +s.name);
		System.out.println("Roll no: " + s.roll_no);

		
	}
}