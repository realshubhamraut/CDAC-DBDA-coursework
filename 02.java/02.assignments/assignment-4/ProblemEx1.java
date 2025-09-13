import java.util.*;

public class ProblemEx1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int T = sc.nextInt();  
        sc.nextLine();  

        for (int t = 0; t < T; t++) {
            int Q = sc.nextInt();  
            sc.nextLine();  
            ArrayList<Integer> A = new ArrayList<>();

            String[] queries = sc.nextLine().split(" ");
            int i = 0;
            StringBuilder result = new StringBuilder();

            while (i < queries.length) {
                String query = queries[i];

                if (query.equals("a")) {
                    i++;
                    int x = Integer.parseInt(queries[i]);
                    A.add(x);
                } else if (query.equals("b")) {
                    Collections.sort(A);
                } else if (query.equals("c")) {
                    Collections.reverse(A);
                } else if (query.equals("d")) {
                    if (result.length() > 0) result.append(" ");
                    result.append(A.size());
                } else if (query.equals("e")) {
                    if (result.length() > 0) result.append(" ");
                    for (int j = 0; j < A.size(); j++) {
                        result.append(A.get(j));
                        if (j != A.size() - 1) result.append(" ");
                    }
                } else if (query.equals("f")) {
                    A.sort(Collections.reverseOrder());
                }
                i++;
            }

            System.out.println(result.toString());
        }

        sc.close();
    }
}

