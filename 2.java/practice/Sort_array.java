public class Sort_array {
    public static void main(String args[]){
        int arr[] = {23,1,14,5,5,1123,51,511,24};
        int length = arr.length;
        // Bubble Sort
        for(int i = 0; i < length - 1; i++) {
            for(int j = 0; j < length - i - 1; j++) {
                if(arr[j] > arr[j+1]) {
                    // Swap arr[j] and arr[j+1]
                    int temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }
            }
        }
        System.out.println("Sorted array:");
        for(int i = 0; i < length; i++) {
            System.out.print(arr[i] + " ");
        }
    }
}