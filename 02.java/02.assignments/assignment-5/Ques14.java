/**
 * Question 14
 * Write a Java program to create a thread that calculates
 * the sum of numbers from 1 to 100.
 */
public class Ques14 extends Thread {
    
    // Variable to store the sum
    private long sum = 0;
    
    @Override
    public void run() {
        System.out.println(getName() + " started calculation");
        
        // Calculate sum of numbers from 1 to 100
        for (int i = 1; i <= 100; i++) {
            sum += i;
            
            // Print progress every 10 numbers
            if (i % 10 == 0) {
                System.out.println("Progress: Summed up to " + i + ", current sum = " + sum);
                
                try {
                    // Small delay to simulate computation time
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    System.out.println(getName() + " was interrupted");
                    return;
                }
            }
        }
        
        System.out.println(getName() + " finished calculation");
        System.out.println("Final sum of numbers from 1 to 100: " + sum);
    }
    
    // Method to get the calculated sum
    public long getSum() {
        return sum;
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create and start the calculator thread
        Ques14 calculatorThread = new Ques14();
        calculatorThread.setName("Calculator-Thread");
        
        System.out.println("Starting calculation thread...");
        calculatorThread.start();
        
        // Wait for the calculator thread to complete
        try {
            calculatorThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        // Verify the result using the formula: sum = n(n+1)/2
        long expectedSum = 100 * 101 / 2;
        System.out.println("\nVerification:");
        System.out.println("Calculated sum: " + calculatorThread.getSum());
        System.out.println("Expected sum: " + expectedSum);
        System.out.println("Calculation " + 
                         (calculatorThread.getSum() == expectedSum ? "correct" : "incorrect"));
        
        System.out.println("\nMain thread finished");
    }
}