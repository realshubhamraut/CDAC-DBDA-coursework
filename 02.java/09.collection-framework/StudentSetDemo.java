
import java.util.*;

class Student implements Comparator<Student> {

    int roll;
    String name;
    double marks;

    Student(int r, String n, double m) {
        this.roll = r;
        this.name = n;
        this.marks = m;
    }

    public boolean equals(Object ob) {//ob has reference of student
        if (ob == null) {
            return false;
        }
        Student s = (Student) ob;
        if (this.roll == s.roll && this.name.equals(s.name) && this.marks == s.marks) {
            return true;
        }
        return false;
    }

    public int hashCode() {
        return Objects.hash(roll, name, marks);
    }

    public int CompareTo(Student s) {
        double m = this.marks - s.marks;
        if (m > 0) {
            return 1;
        } else if (m < 0) {
            return -1;
        } else {
            return 0;
        }
    }

    public String toString() {
        return "Sturoll =" + roll + " Name=" + name + " Marks=" + marks;
    }

}

class NameComparator implements Comparator<Student> {

    public int compare(Student s1, Student s2) {

        return s1.name.compareTo(s2.name);
    }
}

class StudentSetDemo {

    static void display(Collection<?> c) {
        for (Object o : c) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        Set<Student> set1 = new HashSet<>();

        //Set<Student> set1 = new TreeSet<>();
        Student s = new Student(6, "ff", 90);
        set1.add(s);
        set1.add(new Student(1, "aa", 60.7));
        set1.add(new Student(2, "aa", 68.8));
        set1.add(new Student(3, "bb", 88.9));
        System.out.println("Student set==");
        display(set1);
        set1.add(new Student(2, "aa", 68.8));
        display(set1);
        //   Collections.sort(set1,new NameComparator());

    }

}
