// 2. super constructor parent


//now we are saying that the peron should be in the Person instead of Students
// and we will fetch the name from the Person and also adding indireclty into the Students using inheritance

class Person{
	String name;
	Person(String name){
		this.name = name;
	}
}

public class Student extends Person {
	int rollNo;
	String section;

	Student(String name, int rollNo, String section){
		super(name); // Call parent constructor
		this.rollNo = rollNo;
		this.section = section;
	}
}