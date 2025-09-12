// 1.basic

public class Students {
    String name;
    int rollNo;
    String section;

    Students(String name, int rollNo, String section) {
        this.name = name;
        this.rollNo = rollNo;
        this.section = section;
    }

    public void printDetails() {
        System.out.println("Student details:");
        System.out.println(this.name + this.rollNo + this.section);
    }

    public static void main(String[] args) {
    Students std1 = new Students("Shubham", 2, "A");
    Students std2 = new Students("Shubham", 2, "B");
    std1.printDetails();
    std2.printDetails();
    }
}
