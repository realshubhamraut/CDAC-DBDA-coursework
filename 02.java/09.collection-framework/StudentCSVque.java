
import java.io.*;
import java.util.*;

public class StudentCSVque {

    static class Student {

        private int rollno;
        private String name;
        private double marks;

        public Student(int rollno, String name, double marks) {
            this.rollno = rollno;
            this.name = name;
            this.marks = marks;
        }

        public int getRollno() {
            return rollno;
        }

        public String getName() {
            return name;
        }

        public double getMarks() {
            return marks;
        }

        public String toString() {
            return rollno + "," + name + "," + marks;
        }
    }

    public static void main(String[] args) throws IOException {
        File inputFile = new File("C:/Users/Shweta/Documents/Student.csv");
        File outputFile = new File("C:/Users/Shweta/Documents/SortedStudent.csv");

        if (!inputFile.exists()) {
            System.out.println("Input file not found.");
            return;
        }

        BufferedReader br = new BufferedReader(new FileReader(inputFile));
        List<Student> studentList = new ArrayList<>();

        String line;
        br.readLine();
        while ((line = br.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length == 3) {
                int rollno = Integer.parseInt(parts[0].trim());
                String name = parts[1].trim();
                double marks = Double.parseDouble(parts[2].trim());
                Student student = new Student(rollno, name, marks);
                studentList.add(student);
            }
        }
        br.close();
        Collections.sort(studentList, new Comparator<Student>() {
            public int compare(Student s1, Student s2) {
                return Double.compare(s1.getMarks(), s2.getMarks());
            }
        });

        BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile));
        bw.write("rollno,name,marks");
        bw.newLine();
        for (Student s : studentList) {
            bw.write(s.toString());
            bw.newLine();
        }
        bw.close();

        System.out.println("Sorted student data:");
        for (Student s : studentList) {
            System.out.println(s);
        }
    }
}
