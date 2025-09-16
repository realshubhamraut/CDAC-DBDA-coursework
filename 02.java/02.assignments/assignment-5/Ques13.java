/**
 * Question 13
 * Write a Java program to demonstrate the difference
 * between calling run() directly and calling start() on a
 * thread.
 */
public class Ques13 extends Thread {
    private final String methodCalled;
    
    public Ques13(String name, String methodCalled) {
        super(name);
        this.methodCalled = methodCalled;
    }
    
    @Override
    public void run() {
        // Get information about the current execution context
        Thread currentThread = Thread.currentThread();
        System.out.println("Currently executing in thread: " + currentThread.getName());
        
        System.out.println("Method called was: " + methodCalled);
        System.out.println("Is this the same as the thread object? " + 
                          (currentThread == this ? "Yes" : "No"));
        
        // Show thread's state information
        System.out.println("Thread ID: " + currentThread.getId());
        System.out.println("Thread Priority: " + currentThread.getPriority());
        System.out.println("Thread State: " + currentThread.getState());
        
        // Print stack trace to show call hierarchy
        System.out.println("\nCall Stack Trace:");
        StackTraceElement[] stackTrace = Thread.currentThread().getStackTrace();
        for (int i = 0; i < stackTrace.length && i < 5; i++) {
            System.out.println("  " + stackTrace[i]);
        }
        
        System.out.println("\n" + currentThread.getName() + " execution complete\n");
    }
    
    public static void main(String[] args) {
        System.out.println("Main thread started\n");
        System.out.println("====== DEMONSTRATION ======");
        
        // Create two thread instances
        Ques13 thread1 = new Ques13("Custom-Thread", "start()");
        Ques13 thread2 = new Ques13("Main-Thread-Run", "run()");
        
        // CASE 1: Using start() method - creates a new thread
        System.out.println("\n=== CASE 1: Calling start() ===");
        System.out.println("This will create a new thread and call run() in that thread context");
        thread1.start();
        
        // Wait for thread1 to complete
        try {
            thread1.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted");
        }
        
        // CASE 2: Calling run() directly - executes in the current thread (main)
        System.out.println("\n=== CASE 2: Calling run() directly ===");
        System.out.println("This will execute in the current thread context (main) like a regular method call");
        thread2.run();
        
        System.out.println("\n====== SUMMARY ======");
        System.out.println("1. start() - Creates a new thread and calls run() in that new thread's context");
        System.out.println("   - Enables concurrent execution");
        System.out.println("   - The thread goes through proper lifecycle states");
        System.out.println("   - run() is executed asynchronously");
        
        System.out.println("\n2. run() called directly - No new thread is created");
        System.out.println("   - Executes in the current thread context (like a normal method call)");
        System.out.println("   - No concurrency/parallelism");
        System.out.println("   - The code is executed synchronously in the calling thread");
        
        System.out.println("\nMain thread finished");
    }
}