
import java.util.*;

public class PracticeProblem1 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("T == ");
        int T = sc.nextInt();
        sc.nextLine();
        for (int t = 0; t < T; t++) {
            System.out.print("Q == ");
            int Q = sc.nextInt();
            sc.nextLine();
            System.out.println("enter " + Q + " space-separated queries:");
            String[] que = sc.nextLine().split(" ");
            ArrayList<Integer> A = new ArrayList<>();
            ArrayList<String> output = new ArrayList<>();
            A.add(111);
            A.add(222);
            A.add(333);
            A.add(444);
            for (int i = 0; i < Q; i++) {
                String query = que[i];
                if (query.startsWith("a")) {
                    String numStr = query.substring(1);
                    boolean isDigit = true;
                    for (char ch : numStr.toCharArray()) {
                        if (!Character.isDigit(ch)) {
                            isDigit = false;
                            break;
                        }
                    }
                    if (isDigit) {
                        int num = Integer.parseInt(numStr);
                        A.add(num);
                    }
                } else if (query.equals("b")) {
                    Collections.sort(A);
                } else if (query.equals("c")) {
                    Collections.reverse(A);
                } else if (query.equals("d")) {
                    output.add(String.valueOf(A.size()));
                } else if (query.equals("e")) {
                    for (int val : A) {
                        output.add(String.valueOf(val));
                    }
                } else if (query.equals("f")) {
                    A.sort(Collections.reverseOrder());
                }
            }
            System.out.println(String.join(" ", output));
        }
        sc.close();
    }
}
