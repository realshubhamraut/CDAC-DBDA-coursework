/**
 * Question 10
 * Write a Java program to create two threads:
 * • Thread 1 prints "Good Morning" 5 times.
 * • Thread 2 prints "Welcome" 5 times.
 * Run both threads simultaneously.
 */
public class Ques10 {
    
    // Thread 1: Prints "Good Morning" 5 times
    static class MorningThread extends Thread {
        @Override
        public void run() {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Good Morning (" + i + ")");
                
                try {
                    // Small delay for better visualization
                    Thread.sleep(300);
                } catch (InterruptedException e) {
                    System.out.println("MorningThread interrupted");
                }
            }
        }
    }
    
    // Thread 2: Prints "Welcome" 5 times
    static class WelcomeThread extends Thread {
        @Override
        public void run() {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Welcome (" + i + ")");
                
                try {
                    // Different delay to show interleaving
                    Thread.sleep(400);
                } catch (InterruptedException e) {
                    System.out.println("WelcomeThread interrupted");
                }
            }
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create thread instances
        Thread morningThread = new MorningThread();
        Thread welcomeThread = new WelcomeThread();
        
        // Set thread names for better identification
        morningThread.setName("Morning-Thread");
        welcomeThread.setName("Welcome-Thread");
        
        // Start both threads
        System.out.println("Starting both threads...\n");
        morningThread.start();
        welcomeThread.start();
        
        // Wait for both threads to complete
        try {
            morningThread.join();
            welcomeThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        System.out.println("\nBoth threads have completed");
    }
}