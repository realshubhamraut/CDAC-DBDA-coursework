/**
 * Question 2
 * Write a Java program to create and run a thread by
 * implementing the Runnable interface. The thread should
 * print numbers from 1 to 5.
 */
public class Ques2 implements Runnable {
    
    @Override
    public void run() {
        // Print numbers from 1 to 5
        for (int i = 1; i <= 5; i++) {
            System.out.println("Number: " + i);
            
            // Adding a small delay to make the output clearer
            try {
                Thread.sleep(200);
            } catch (InterruptedException e) {
                System.out.println("Thread was interrupted");
            }
        }
    }
    
    public static void main(String[] args) {
        // Create Runnable instance
        Ques2 runnable = new Ques2();
        
        // Create thread with the runnable
        Thread thread = new Thread(runnable);
        
        // Start the thread - this will call the run() method
        thread.start();
        
        System.out.println("Main method finished");
    }
}