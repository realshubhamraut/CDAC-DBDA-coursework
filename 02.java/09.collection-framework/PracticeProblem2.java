
import java.util.Stack;

class PracticeProblem2 {

    public static void main(String[] args) {
        Stack<Integer> dltmid = new Stack<>();
        Stack<Integer> st = new Stack<>();
        Stack<Integer> temp = new Stack<>();
        st.add(22);
        st.add(44);
        st.add(88);
        System.out.println("Stack Before === " + st);
        int mid = st.size() / 2;
        for (int i = 0; i < mid; i++) {
            temp.push(st.pop());
        }
        st.pop();

        while (!temp.isEmpty()) {
            st.push(temp.pop());
        }
        System.out.println(st);
    }
}
