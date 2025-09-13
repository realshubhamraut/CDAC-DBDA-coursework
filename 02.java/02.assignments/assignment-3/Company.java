class Employee{
    String name;
    int empId;
    String Department;

    Employee(String name,int empId,String Department){
        this.name=name;
        this.empId=empId;
        this.Department=Department;
    }
    Employee(String name,int empId){
        this.name=name;
        this.empId=empId;
    }
    void setName(String name){
        this.name=name;
    }
    void setEmpId(int empId){
        this.empId=empId;
    }
    void setDepartment(String Department){
        this.Department=Department;
    }
    String getName(String name){
        return name;
    }
    int getEmpId(int empId){
        return empId;
    }
    String getDepartment(String Department){
        return Department;
    }
    void display1()
    {
        System.out.println("Name : "+name);
        System.out.println("empId : "+empId);
        System.out.println("Department : "+Department);
    }

}
class Manager extends Employee{
    int numOfTManaged;
    Manager(String name,int empId){
        super(name,empId);
    }
    Manager(String name,int empId,String Department,int numOfTManaged){
        super(name,empId,Department);
        this.numOfTManaged=numOfTManaged;
    }

    void setnumOfTManaged(int numOfTManaged){
        this.numOfTManaged=numOfTManaged;
    }
    int getName(int numOfTManaged){
        return numOfTManaged;
    }
    void display()
    {
        System.out.println("Name : "+name);
        System.out.println("empId : "+empId);
        System.out.println("Department : "+Department);
        System.out.println("numOfTManaged : "+numOfTManaged);
    }
}

public class Company{
    public static void main(String[] args) {
        Employee e = new Employee("Alice",143,"IT");
        Manager m =new Manager("Patil",4562);
        m.setnumOfTManaged(3);
        e.display1();
        m.display();
    }
}