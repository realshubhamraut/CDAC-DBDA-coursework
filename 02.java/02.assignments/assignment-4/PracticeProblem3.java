
import java.util.ArrayList;
import java.util.Scanner;

class PracticeProblem3 {

    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<>();
        ArrayList<Integer> A = new ArrayList<>();
        A.add(10);
        A.add(20);
        A.add(30);
        A.add(40);

        System.out.println("value of Q (1 or 2) ==");
        Scanner sc = new Scanner(System.in);
        int Q = sc.nextInt();
        ArrayList<Integer> Query = new ArrayList<>();
        if (Q == 1) {
            System.out.print("position to insert == ");
            Query.add(sc.nextInt());
            System.out.print("value to insert == ");
            Query.add(sc.nextInt());

            int p = Query.get(0);
            int r = Query.get(1);
            A.add(p, r);
            System.out.println("Updated List = " + A);

        } else if (Q == 2) {
            System.out.print("value to find last index of == ");
            Query.add(sc.nextInt());

            int p = Query.get(0);
            int lastIndex = -1;
            for (int i = A.size() - 1; i >= 0; i--) {
                if (A.get(i).equals(p)) {
                    lastIndex = i;
                    break;
                }
            }

            ArrayList<Integer> result = new ArrayList<>();
            result.add(lastIndex);
            System.out.println(result
            );
        }
    }
}
