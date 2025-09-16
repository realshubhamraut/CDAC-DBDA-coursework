/**
 * Question 12
 * Write a Java program to create three threads. Each thread
 * should print its own message 3 times.
 */
public class Ques12 implements Runnable {
    // The message this thread will print
    private final String message;
    
    // Constructor to initialize the message
    public Ques12(String message) {
        this.message = message;
    }
    
    @Override
    public void run() {
        Thread currentThread = Thread.currentThread();
        System.out.println(currentThread.getName() + " started");
        
        // Print the message 3 times
        for (int i = 1; i <= 3; i++) {
            System.out.println(currentThread.getName() + ": " + message + " (time " + i + ")");
            
            try {
                // Random delay between 100-300ms to show interleaving
                long sleepTime = 100 + (long)(Math.random() * 200);
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                System.out.println(currentThread.getName() + " was interrupted");
                return;
            }
        }
        
        System.out.println(currentThread.getName() + " finished");
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create three runnable tasks with different messages
        Runnable task1 = new Ques12("Learning Java Threads");
        Runnable task2 = new Ques12("Multithreading is powerful");
        Runnable task3 = new Ques12("Concurrent programming is fun");
        
        // Create three threads with the tasks
        Thread thread1 = new Thread(task1, "Thread-A");
        Thread thread2 = new Thread(task2, "Thread-B");
        Thread thread3 = new Thread(task3, "Thread-C");
        
        // Start all three threads
        System.out.println("Starting all three threads...\n");
        thread1.start();
        thread2.start();
        thread3.start();
        
        // Wait for all threads to complete
        try {
            thread1.join();
            thread2.join();
            thread3.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        System.out.println("\nAll three threads have completed");
    }
}