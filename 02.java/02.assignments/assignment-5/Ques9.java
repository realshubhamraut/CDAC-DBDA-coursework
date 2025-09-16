/**
 * Question 9
 * Write a Java program to check whether a thread is alive
 * or not using the isAlive() method.
 */
public class Ques9 implements Runnable {
    
    @Override
    public void run() {
        // Simulate some work
        System.out.println("Thread task started");
        
        try {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Working... step " + i + "/5");
                Thread.sleep(500);
            }
        } catch (InterruptedException e) {
            System.out.println("Thread was interrupted");
        }
        
        System.out.println("Thread task completed");
    }
    
    // Utility method to check and print thread status
    private static void checkThreadStatus(Thread thread) {
        boolean isAlive = thread.isAlive();
        System.out.println("Thread " + thread.getName() + " is alive: " + isAlive);
    }
    
    public static void main(String[] args) {
        // Create a runnable task
        Ques9 task = new Ques9();
        
        // Create a thread with the task
        Thread thread = new Thread(task, "Worker-Thread");
        
        System.out.println("Thread created but not started yet");
        
        // Check if thread is alive before starting
        System.out.println("\nBefore starting the thread:");
        checkThreadStatus(thread);
        
        // Start the thread
        System.out.println("\nStarting the thread...");
        thread.start();
        
        // Check if thread is alive right after starting
        System.out.println("\nImmediately after starting:");
        checkThreadStatus(thread);
        
        // Wait for a moment while the thread is running
        try {
            Thread.sleep(1000); // Sleep for 1 second
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        // Check if thread is alive during execution
        System.out.println("\nDuring thread execution:");
        checkThreadStatus(thread);
        
        // Wait for the thread to complete
        try {
            thread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted while waiting");
        }
        
        // Check if thread is alive after completion
        System.out.println("\nAfter thread completion:");
        checkThreadStatus(thread);
        
        // Demonstrate that you cannot restart a thread
        System.out.println("\nAttempting to restart the completed thread:");
        try {
            thread.start(); // This will throw IllegalThreadStateException
        } catch (IllegalThreadStateException e) {
            System.out.println("Error: " + e.getMessage());
            System.out.println("Cannot restart a thread that has already completed");
        }
        
        System.out.println("\nMain thread finished");
    }
}