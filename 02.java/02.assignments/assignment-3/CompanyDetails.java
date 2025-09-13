import java.util.*;

class Employee{
    String name;
    String empId;
    String department;

    Employee(String name, String empId,String department){
        this.name=name;
        this.empId=empId;
        this.department=department;
    }

    String getname(){
        return name;
    }
    String getEmpId(){
        return empId;
    }
    String getDepartment(){
        return department;
    }

    void setName(String name){
        this.name=name;
    }

    void setempid(String empId){
        this.empId=empId;
    }
    void setDepartment(String department){
        this.department=department;
    }

    void display(){
        System.out.println("Name : "+name+" EmpId : "+empId+" Department : "+department);
    }
}

public class CompanyDetails{
    ArrayList<Employee> emp ;

    CompanyDetails(){
        emp=new ArrayList<>();
    }

    void addEmployee(Employee com){
        emp.add(com);
        System.out.println("Employee added successfully.");
        //emp.display();
    }

    void updateEmp(String empId,String department){
        boolean found = false;
        for (Employee emps : emp) {
            if (emps.getEmpId().equals(empId)) {
                emps.setDepartment(department);
                System.out.println("Department is Updated");
                found = true;
                break;
            }
        }
        if (!found) {
            System.out.println("Employee with empid \"" + empId + "\" not found.");
        }
    }

    void removeEmp(String id){
        boolean removed = emp.removeIf(emp -> emp.getEmpId().equals(id));
        if (removed) {
            System.out.println("Employee with empId " + id + " removed successfully.");
        } else {
            System.out.println("Employee with empId " + id + " not found.");
        }
    }

    public void displayAllEmp() {
        if (emp.isEmpty()) {
            System.out.println("No Employee in the Database.");
            return;
        }
        for (Employee emp : emp) {
            emp.display();
        }
    }

    public static void main(String args[]){

        CompanyDetails com =new CompanyDetails();
        Scanner scanner = new Scanner(System.in);
        //boolean True;

        while(true)
        {
            System.out.println("1. Add Employee to Database");
            System.out.println("2. Update Employees department using empId ");
            System.out.println("3. Remove Employee from database");
            System.out.println("4. Display Employees Details");
            System.out.println("5. Exit");
            System.out.println("Enter your choice : ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch(choice){

                case 1:
                    System.out.println("Enter Employee Name : ");
                    String n = scanner.nextLine();
                    System.out.println("Enter Employee ID : ");
                    String id = scanner.nextLine();
                    System.out.println("Enter Employee Department : ");
                    String dep = scanner.nextLine();
                    Employee emp =new Employee(n,id,dep);
                    com.addEmployee(emp);
                    break;

                case 2:
                    System.out.println("Enter Employee ID : ");
                    String idn = scanner.nextLine();
                    System.out.println("Enter Employee Department to update: ");
                    String depu = scanner.nextLine();
                    com.updateEmp(idn,depu);
                    break;
                case 3:
                    System.out.println("Enter Employee ID to remove : ");
                    String idp = scanner.nextLine();
                    com.removeEmp(idp);
                    break;
                case 4:
                    com.displayAllEmp();
                    break;
                case 5:
                    System.out.println("Exiting Library Management System.");
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("Invalid choice, please try again.");
            }
        }
    }
}