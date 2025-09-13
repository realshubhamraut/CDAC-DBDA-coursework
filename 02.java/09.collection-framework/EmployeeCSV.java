
import java.io.*;
import java.util.*;

public class EmployeeCSV {

    static class Employee {

        private int empid;
        private String name;
        private double salary;

        public Employee(int empid, String name, double salary) {
            this.empid = empid;
            this.name = name;
            this.salary = salary;
        }

        public int getempid() {
            return empid;
        }

        public String getName() {
            return name;
        }

        public double getsalary() {
            return salary;
        }

        public String toString() {
            return empid + "," + name + "," + salary;
        }
    }

    public static void main(String[] args) throws IOException {
        File inputFile = new File("C:/Users/Shweta/Desktop/Employee.csv");
        File outputFile = new File("C:/Users/Shweta/Desktop/SortedEmp.csv");

        if (!inputFile.exists()) {
            System.out.println("Input file not found.");
            return;
        }
        BufferedReader br = new BufferedReader(new FileReader(inputFile));
        List<Employee> EmployeeList = new ArrayList<>();
        String line = br.readLine();

        while ((line = br.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length == 3) {
                int empid = Integer.parseInt(parts[0].trim());
                String name = parts[1].trim();
                double salary = Double.parseDouble(parts[2].trim());
                Employee employee = new Employee(empid, name, salary);
                EmployeeList.add(employee);
            }
        }
        br.close();
        Collections.sort(EmployeeList, new Comparator<Employee>() {
            public int compare(Employee s1, Employee s2) {
                return Integer.compare(s1.getempid(), s2.getempid());
            }
        });

        BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile));
        bw.write("empid,name,salary");
        bw.newLine();
        for (Employee s : EmployeeList) {
            bw.write(s.toString());
            bw.newLine();
        }
        bw.close();
        System.out.println("Sorted Employee == ");
        for (Employee s : EmployeeList) {
            System.out.println(s);
        }
    }
}
