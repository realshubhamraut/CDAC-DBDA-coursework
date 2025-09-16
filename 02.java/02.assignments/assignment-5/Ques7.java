/**
 * Question 7
 * Write a Java program to demonstrate the use of the
 * sleep() method by pausing a thread for 1 second after
 * printing each number.
 */
public class Ques7 extends Thread {
    
    @Override
    public void run() {
        System.out.println("Thread started: " + getName());
        
        // Print numbers 1 to 10 with a 1-second pause between each
        for (int i = 1; i <= 10; i++) {
            // Print the current number
            System.out.println(getName() + " - Number: " + i + 
                              " (Timestamp: " + System.currentTimeMillis() + ")");
            
            // Sleep for exactly 1 second (1000 milliseconds)
            try {
                Thread.sleep(1000);
                System.out.println(getName() + " - Woke up after 1 second");
            } catch (InterruptedException e) {
                System.out.println(getName() + " was interrupted during sleep");
                return; // Exit if thread is interrupted
            }
        }
        
        System.out.println(getName() + " has finished execution");
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create and start a thread
        Ques7 thread = new Ques7();
        thread.setName("Sleeping-Thread");
        
        System.out.println("Starting the thread that will demonstrate sleep() method...");
        thread.start();
        
        // Main thread can continue with other work
        System.out.println("Main thread continues to execute while other thread sleeps");
        
        // Wait for the sleeping thread to finish
        try {
            thread.join();
            System.out.println("Sleeping thread has completed its execution");
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting");
        }
        
        System.out.println("Main thread finished");
    }
}