/**
 * Question 4
 * Write a Java program to demonstrate the use of
 * setName() and getName() methods for threads.
 */
public class Ques4 extends Thread {
    
    @Override
    public void run() {
        // Get current thread
        Thread currentThread = Thread.currentThread();
        
        // Display thread name using getName()
        System.out.println("Current thread name: " + currentThread.getName());
        
        // Print a message using the thread name
        for (int i = 0; i < 3; i++) {
            System.out.println(currentThread.getName() + " is running - iteration " + (i+1));
            
            try {
                Thread.sleep(200);
            } catch (InterruptedException e) {
                System.out.println(currentThread.getName() + " was interrupted");
            }
        }
    }
    
    public static void main(String[] args) {
        // Create three threads
        Ques4 thread1 = new Ques4();
        Ques4 thread2 = new Ques4();
        Ques4 thread3 = new Ques4();
        
        // Get and print default thread names
        System.out.println("Default name of thread1: " + thread1.getName());
        System.out.println("Default name of thread2: " + thread2.getName());
        System.out.println("Default name of thread3: " + thread3.getName());
        
        // Set custom names for threads using setName()
        thread1.setName("Database-Thread");
        thread2.setName("Processing-Thread");
        thread3.setName("UI-Thread");
        
        // Print new thread names
        System.out.println("\nAfter renaming:");
        System.out.println("New name of thread1: " + thread1.getName());
        System.out.println("New name of thread2: " + thread2.getName());
        System.out.println("New name of thread3: " + thread3.getName());
        
        // Start the threads
        System.out.println("\nStarting all threads:");
        thread1.start();
        thread2.start();
        thread3.start();
        
        // Get the name of the main thread
        Thread mainThread = Thread.currentThread();
        System.out.println("\nMain thread name: " + mainThread.getName());
        
        // Change the name of the main thread
        mainThread.setName("Controller-Thread");
        System.out.println("Main thread renamed to: " + mainThread.getName());
    }
}