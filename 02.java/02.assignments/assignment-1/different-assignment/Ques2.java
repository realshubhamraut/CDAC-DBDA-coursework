
//2. Assign and print the roll number, phone number and address of two Student2s having names
//"Sam" and "John" respectively by creating two objects of class 'Student2'.


class Student2{
	String name;
	int roll_no;
	int phone_no;
	
	public Student2(String name, int roll_no, int phone_no) {
		this.name = name;
		this.roll_no = roll_no;
		this.phone_no = phone_no;
		
	}
	
	public void print() {
	    System.out.println("Name: " + name + " Roll_no: " + roll_no + " Phone no: " + phone_no);
	}
}

public class Ques2 {
	public static void main(String[] args) {
		Student2 s1 = new Student2("Sam", 23,929391932);
		Student2 s2 = new Student2("John", 21, 292294020);
		
		s1.print();
		s2.print();

		
	}
}
