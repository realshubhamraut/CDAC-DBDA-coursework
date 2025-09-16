/**
 * Question 6
 * Write a Java program where one thread prints numbers
 * from 1 to 10, and another thread prints numbers from 11
 * to 20.
 */
public class Ques6 {
    
    // Thread for printing numbers 1-10
    static class FirstThread extends Thread {
        @Override
        public void run() {
            System.out.println("First thread started - printing numbers 1 to 10:");
            for (int i = 1; i <= 10; i++) {
                System.out.println("First thread: " + i);
                
                // Small delay to make output more readable
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    System.out.println("First thread interrupted");
                }
            }
            System.out.println("First thread finished");
        }
    }
    
    // Thread for printing numbers 11-20
    static class SecondThread extends Thread {
        @Override
        public void run() {
            System.out.println("Second thread started - printing numbers 11 to 20:");
            for (int i = 11; i <= 20; i++) {
                System.out.println("Second thread: " + i);
                
                // Small delay to make output more readable
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    System.out.println("Second thread interrupted");
                }
            }
            System.out.println("Second thread finished");
        }
    }
    
    public static void main(String[] args) {
        // Create thread instances
        FirstThread firstThread = new FirstThread();
        SecondThread secondThread = new SecondThread();
        
        // Start both threads
        System.out.println("Starting both threads...\n");
        firstThread.start();
        secondThread.start();
        
        // Wait for both threads to complete
        try {
            firstThread.join();
            secondThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        System.out.println("\nAll threads have completed");
    }
}