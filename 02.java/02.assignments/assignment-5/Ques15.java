/**
 * Question 15
 * Write a Java program to demonstrate how to stop a
 * thread gracefully using a boolean flag instead of the
 * deprecated stop() method.
 */
public class Ques15 implements Runnable {
    
    // Flag to control thread execution
    private volatile boolean running = true;
    
    // Counter to track work done
    private int counter = 0;
    
    @Override
    public void run() {
        Thread currentThread = Thread.currentThread();
        System.out.println(currentThread.getName() + " started");
        
        // Run until asked to stop
        while (running) {
            // Simulate some work
            counter++;
            
            System.out.println(currentThread.getName() + " - Working... (count: " + counter + ")");
            
            // Check the flag more frequently for faster response to stop request
            try {
                Thread.sleep(500); // Work for 500ms
            } catch (InterruptedException e) {
                System.out.println(currentThread.getName() + " was interrupted");
                // Clean up and exit
                System.out.println(currentThread.getName() + " cleaning up resources after interruption");
                running = false; // Also respond to interrupt by stopping
            }
            
            // Check if we've done enough work or if we should stop
            if (counter >= 10) {
                System.out.println(currentThread.getName() + " completed its work");
                break;
            }
        }
        
        // Perform cleanup before exiting
        System.out.println(currentThread.getName() + " cleaning up resources");
        System.out.println(currentThread.getName() + " finished gracefully");
    }
    
    // Method to request thread to stop
    public void stopThread() {
        System.out.println("Requesting thread to stop gracefully...");
        running = false;
    }
    
    // Get work done so far
    public int getCounter() {
        return counter;
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started");
        
        // Create thread task
        Ques15 task = new Ques15();
        
        // Create and start worker thread
        Thread workerThread = new Thread(task, "Worker-Thread");
        System.out.println("Starting worker thread...");
        workerThread.start();
        
        // Let the thread work for a while
        try {
            Thread.sleep(3000); // Wait for 3 seconds
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        // Stop the thread gracefully
        task.stopThread();
        
        // Wait for worker thread to complete
        try {
            workerThread.join(2000); // Wait up to 2 seconds for thread to finish
            
            // Check if thread is still alive
            if (workerThread.isAlive()) {
                System.out.println("Thread didn't stop in time, sending interrupt signal");
                workerThread.interrupt();
                workerThread.join(1000); // Wait another second
                
                if (workerThread.isAlive()) {
                    System.out.println("WARNING: Thread is still running and not responding to interrupts!");
                }
            }
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted while waiting for worker to finish");
        }
        
        System.out.println("Worker thread completed " + task.getCounter() + " units of work");
        System.out.println("Main thread finished");
    }
}