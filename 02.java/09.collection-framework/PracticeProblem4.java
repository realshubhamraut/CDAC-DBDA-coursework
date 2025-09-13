
import java.util.*;

class PracticeProblem4 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("T == ");
        int T = sc.nextInt();
        sc.nextLine();
        List<List<String>> queriesList = new ArrayList<>();
        queriesList.add(Arrays.asList("a10", "a20", "a30", "b"));
        queriesList.add(Arrays.asList("c20", "d20", "e"));
        queriesList.add(Arrays.asList("a40", "a50", "b", "d10", "e"));
        ArrayList<Integer> op = new ArrayList<>();
        for (int i = 0; i < T; i++) {
            System.out.println("query line == ");
            String line = sc.nextLine();
            List<String> query = Arrays.asList(line.split(" "));
            queriesList.add(query);
        }
        for (int t = 0; t < T; t++) {
            TreeSet<Integer> set = new TreeSet<>();
            List<String> queries = queriesList.get(t);
            for (String query : queries) {
                if (query.startsWith("a")) {
                    int x = Integer.parseInt(query.substring(1));
                    set.add(x);
                } else if (query.equals("b")) {
                    op.addAll(set);
                } else if (query.startsWith("c")) {
                    int x = Integer.parseInt(query.substring(1));
                    set.remove(x);
                } else if (query.startsWith("d")) {
                    int x = Integer.parseInt(query.substring(1));
                    op.add(set.contains(x) ? 1 : -1);
                } else if (query.equals("e")) {
                    op.add(set.size());
                }
            }
        }
        System.out.println(op);
    }

}
