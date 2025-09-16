/**
 * Question 5
 * Write a Java program to demonstrate the use of
 * setPriority() and getPriority() methods by creating two
 * threads with different priorities.
 */
public class Ques5 extends Thread {
    
    public Ques5(String name) {
        super(name);
    }
    
    @Override
    public void run() {
        // Print thread information including its priority
        System.out.println("Running thread: " + getName() + 
                           " with priority: " + getPriority());
        
        // Execute some work to demonstrate priority effects
        for (int i = 0; i < 5; i++) {
            System.out.println(getName() + " - Count: " + i);
            
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                System.out.println(getName() + " was interrupted");
            }
        }
        
        System.out.println(getName() + " finished execution");
    }
    
    public static void main(String[] args) {
        // Create two threads with different names
        Ques5 lowPriorityThread = new Ques5("Low-Priority-Thread");
        Ques5 highPriorityThread = new Ques5("High-Priority-Thread");
        
        // Display default priorities
        System.out.println("Default priority of " + lowPriorityThread.getName() + 
                           ": " + lowPriorityThread.getPriority());
        System.out.println("Default priority of " + highPriorityThread.getName() + 
                           ": " + highPriorityThread.getPriority());
        
        // Set different priorities
        lowPriorityThread.setPriority(Thread.MIN_PRIORITY);  // Priority 1
        highPriorityThread.setPriority(Thread.MAX_PRIORITY); // Priority 10
        
        // Display new priorities
        System.out.println("New priority of " + lowPriorityThread.getName() + 
                           ": " + lowPriorityThread.getPriority());
        System.out.println("New priority of " + highPriorityThread.getName() + 
                           ": " + highPriorityThread.getPriority());
        
        // Start the threads
        System.out.println("\nStarting threads...\n");
        lowPriorityThread.start();
        highPriorityThread.start();
        
        // Note: The thread scheduler in Java is platform-dependent,
        // so the higher priority thread may not always execute first
        // or get more CPU time on all systems.
        
        // Wait for both threads to finish
        try {
            lowPriorityThread.join();
            highPriorityThread.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        System.out.println("\nAll threads have finished execution");
    }
}