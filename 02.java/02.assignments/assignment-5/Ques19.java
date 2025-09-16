/**
 * Question 19
 * Write a Java program to create a thread that prints the
 * current time every 2 seconds, five times.
 */
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Ques19 {
    
    static class TimeDisplayThread extends Thread {
        private final int intervalInSeconds;
        private final int totalPrints;
        private final DateTimeFormatter formatter;
        
        public TimeDisplayThread(int intervalInSeconds, int totalPrints) {
            this.intervalInSeconds = intervalInSeconds;
            this.totalPrints = totalPrints;
            // Define the format for displaying time
            this.formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        }
        
        @Override
        public void run() {
            System.out.println("Time display thread started...");
            
            try {
                for (int i = 0; i < totalPrints; i++) {
                    // Get the current time and format it
                    LocalDateTime now = LocalDateTime.now();
                    String formattedTime = now.format(formatter);
                    
                    // Print the current time
                    System.out.println("Current time: " + formattedTime);
                    
                    // Only sleep if this is not the last iteration
                    if (i < totalPrints - 1) {
                        Thread.sleep(intervalInSeconds * 1000);
                    }
                }
                System.out.println("Time display thread completed successfully.");
            } catch (InterruptedException e) {
                System.out.println("Time display thread was interrupted.");
            }
        }
    }
    
    public static void main(String[] args) {
        System.out.println("Starting the time display program...");
        
        // Create and start the time display thread (2 seconds interval, 5 times)
        TimeDisplayThread timeThread = new TimeDisplayThread(2, 5);
        timeThread.start();
        
        try {
            // Wait for the time thread to complete
            timeThread.join();
            System.out.println("Time display completed. Main thread exiting.");
        } catch (InterruptedException e) {
            System.out.println("Main thread was interrupted while waiting for time display to complete.");
        }
    }
}