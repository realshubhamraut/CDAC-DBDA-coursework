package javaProject;
import java.util.*;
interface EmpDatabase{	
	void addEmployee();
	void updateDepartment();
	void removeEmployee();
	void displayDetails();
}
class Employee{
	String empName;
	int empId;
	String department;
	Employee(String empName, int empId, String department){
		this.empName = empName;
		this.empId = empId;
		this.department=department;
	}
	public String toString() {
		return "["+empName+", "+empId+", "+department+"]";
	}
}
class Manager implements EmpDatabase{
	Scanner sc=new Scanner(System.in);
	List<Employee> emp = new ArrayList<>();
	public void addEmployee() {
		System.out.println("Enter the name of Employee: ");
		String name = sc.nextLine();
		System.out.println("Enter the Id of Employee: ");
		int empId = sc.nextInt();
		sc.nextLine();
		System.out.println("Enter the department of Employee: ");
		String department = sc.nextLine();
		emp.add(new Employee(name, empId, department));
		System.out.println("Employee is added to the database");
	}
	public void updateDepartment() {
		System.out.println("Enter employee id for updating department: ");
		int empId = sc.nextInt();
		sc.nextLine();
		boolean updated = false;
		for(Employee e:emp) {
			if(empId==e.empId) {
				System.out.println("Enter the new Department");
				String newDepartment = sc.nextLine();
				e.department = newDepartment;
				updated = true;
				System.out.println("Department updated successfully");
				break;
			}
		}
		if(!updated) {
			System.out.println("Emplioyee not found");
		}
	}
	public void removeEmployee() {
		System.out.println("Enter the employee ID to remove: ");
		int empId = sc.nextInt();
		boolean isRemoved = false;
		for(Employee e: emp) {
			if(empId==e.empId) {
				emp.remove(e);
				isRemoved=true;
				System.out.println("Employee removed successfully");
				break;
			}
		}
		if(!isRemoved) {
			System.out.println("Employee not exist");
		}
	}
	public void displayDetails() {
		if(emp.isEmpty()) {
			System.out.println("The database is empty");
		}
		for(Employee e: emp) {
			System.out.println(e.toString());
		}
	}
}
public class EmployeeManagement {
	public static void main(String[] args) {
		Manager m1=new Manager();
		Scanner sc=new Scanner(System.in);
		int choice=0;
		do {
			System.out.println("--Employee Database--");
			System.out.println("1. Add new Employee");
			System.out.println("2. Update department");
			System.out.println("3. Remove Employee");
			System.out.println("4. Display all details");
			System.out.println("5. Exit");
			System.out.println();
			System.out.println("Enter your choice");
			try {
			choice=sc.nextInt();
			
			switch(choice) {
			case 1:
				m1.addEmployee();
				System.out.println();
				break;
			case 2:
				m1.updateDepartment();;
				System.out.println();
				break;
			case 3:
				m1.removeEmployee();;
				System.out.println();
				break;
			case 4:
				m1.displayDetails();
				System.out.println();
				break;
			default:
				System.out.println("Invalid choice! please try again");
			}
			}catch(InputMismatchException e) {
				System.out.println("Input mismatch. Please enter no. between 1 to 5");
				sc.nextLine();
			}
			System.out.println();
		}while(choice!=5);
		sc.close();
	}
}