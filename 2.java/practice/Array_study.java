public class Array_study {
    public static void main(String args[]) {
        int arr[] ={123,4,15151,1,0,5,5,1};
        int length = arr.length;  
        System.out.println(length);   
        int sum = 0;
        for(int i = 0; i<=arr.length-1; i++){
            sum = sum + arr[i];
        }   
        System.out.println(sum);

    }
    
}
// why using the <=arr.length without -1
// we get the error for out of bonds