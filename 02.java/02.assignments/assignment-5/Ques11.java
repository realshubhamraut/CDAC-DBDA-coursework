/**
 * Question 11
 * Write a Java program where one thread prints even
 * numbers from 2 to 20, and another thread prints odd
 * numbers from 1 to 19.
 */
public class Ques11 {
    
    // Thread for printing even numbers from 2 to 20
    static class EvenThread extends Thread {
        @Override
        public void run() {
            System.out.println(Thread.currentThread().getName() + " started");
            
            // Print all even numbers from 2 to 20
            for (int i = 2; i <= 20; i += 2) {
                System.out.println("Even: " + i);
                
                try {
                    Thread.sleep(200); // Sleep for 200 milliseconds
                } catch (InterruptedException e) {
                    System.out.println("Even thread interrupted");
                    return;
                }
            }
            
            System.out.println(Thread.currentThread().getName() + " finished");
        }
    }
    
    // Thread for printing odd numbers from 1 to 19
    static class OddThread extends Thread {
        @Override
        public void run() {
            System.out.println(Thread.currentThread().getName() + " started");
            
            // Print all odd numbers from 1 to 19
            for (int i = 1; i <= 19; i += 2) {
                System.out.println("Odd: " + i);
                
                try {
                    Thread.sleep(200); // Sleep for 200 milliseconds
                } catch (InterruptedException e) {
                    System.out.println("Odd thread interrupted");
                    return;
                }
            }
            
            System.out.println(Thread.currentThread().getName() + " finished");
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create thread instances
        Thread evenThread = new EvenThread();
        Thread oddThread = new OddThread();
        
        // Set names for the threads
        evenThread.setName("Even-Thread");
        oddThread.setName("Odd-Thread");
        
        // Start both threads
        System.out.println("Starting both threads...\n");
        evenThread.start();
        oddThread.start();
        
        // Wait for both threads to complete
        try {
            evenThread.join();
            oddThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        System.out.println("\nBoth threads have completed");
    }
}