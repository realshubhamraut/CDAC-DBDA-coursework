
import java.util.*;

class Student implements Comparable<Student> {

    int roll;
    String name;
    double marks;

    Student(int r, String n, double m) {
        this.roll = r;
        this.name = n;
        this.marks = m;
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

class NameComparator implements Comparable<Student> {

    public int compare(Student s1, Student s2) {

        return s1.name.compareTo(s2.name);
    }
}

class StudentListDemo {

    static void display(Collection<?> c) {
        for (Object o : c) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {
        List<Student> list1 = new ArrayList<>();
        Student s = new Student(4, "ee", 90);
        list1.add(s);
        list1.add(new Student(1, "aa", 60.7));
        list1.add(new Student(2, "aa", 68.8));
        list1.add(new Student(3, "bb", 88.9));
        System.out.println("Student List==");
        display(list1);
        Collections.sort(list1);
        display(list1);
        NameComparator n = new NameComparator();
        //ollections.sort(list1, n);
        //   Collections.sort(list1,new NameComparator());

    }

}
