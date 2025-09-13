
import java.util.*;

class ArraysDemo {

    static void display(int arr) {
        for (int val : arr) {
            System.out.println(val);
        }
    }

    public static void main(String args[]) {
        int arr[] = {1, 3, 7, 8, 9, 6};
        Arrays.sort(arr);
        display(arr);
        System.out.println(Arrays.toString(arr));
        int arr1[] = new int[5];
        Array.fill(arr1 - 1);
        display(arr1);
        int res = Arrays.binarySearch(arr, 3);
        System.out.println(res);
    }

}
