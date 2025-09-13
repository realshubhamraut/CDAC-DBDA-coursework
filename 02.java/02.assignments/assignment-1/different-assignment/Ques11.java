//Write a Java class Clock for dealing with the day time represented by hours, minutes, and 
//seconds. Your class must have the following features:
//● Three instance variables for the hours (range 0 - 23), minutes (range 0 - 59), and 
//seconds (range 0 - 59).
//● Three constructors:
//default (with no parameters passed; is should initialize the represented 
//time to 12:0:0)
//a constructor with three parameters: hours, minutes, and seconds.
//a constructor with one parameter: the value of time in seconds since 
//midnight (it should be converted into the time value in hours, minutes, 
//and seconds)
//● Instance methods:
//a set-method method setClock() with one parameter seconds since 
//midnight (to be converted into the time value in hours, minutes, and 
//seconds as above).
//get-methods getHours(), getMinutes(), getSeconds() with no parameters 
//that return the corresponding values.
//set-methods setHours(), setMinutes(), setSeconds() with one parameter 
//each that set up the corresponding instance variables.
//method tick() with no parameters that increments the time stored in a 
//Clock object by one second.
//method addClock() accepting an object of type Clock as a parameter. 
//The method should add the time represented by the parameter class to 
//the time represented in the current class.
//Add an instance method toString() with no parameters to your class. 
//toString() must return a String representation of the Clock object in the 
//form "(hh:mm:ss)", for example "(03:02:34)".
//Add an instance method tickDown() which decrements the time stored 
//in a Clock object by one second.
//Add an instance method subtractClock() that takes one Clock parameter 
//and returns the difference between the time represented in the current 
//Clock object and the one represented by the Clock parameter. 
//Difference of time should be returned as a clock object.
//Write a separate class ClockDemo with a main() method. The program should:
//● instantiate a Clock object firstClock using one integer seconds since midnight 
//obtained from the keyboard.
//● tick the clock ten times by applying its tick() method and print out the time after 
//each tick.
//● Extend your code by appending to it instructions instantiating a Clock object  
//secondClock by using three integers (hours, minutes, seconds) read from the 
//keyboard.
//● Then tick the clock ten times, printing the time after each tick.
//● Add the secondClock time in firstClock by calling the method addClock.
//● Print both clock objects calling toString method
//Create a reference thirdClock that should reference the object of difference of firstClock and 
//secondClock by calling the method subtractClock()



import java.util.Scanner;

class Clock {
    private int hours;   // 0-23
    private int minutes; // 0-59
    private int seconds; // 0-59

    // Default constructor: 12:00:00
    public Clock() {
        this.hours = 12;
        this.minutes = 0;
        this.seconds = 0;
    }

    // Constructor with hours, minutes, seconds
    public Clock(int hours, int minutes, int seconds) {
        setHours(hours);
        setMinutes(minutes);
        setSeconds(seconds);
    }

    // Constructor with seconds since midnight
    public Clock(int secondsSinceMidnight) {
        setClock(secondsSinceMidnight);
    }

    // setClock: set time from seconds since midnight
    public void setClock(int secondsSinceMidnight) {
        if (secondsSinceMidnight < 0) secondsSinceMidnight = 0;
        this.hours = (secondsSinceMidnight / 3600) % 24;
        this.minutes = (secondsSinceMidnight % 3600) / 60;
        this.seconds = secondsSinceMidnight % 60;
    }

    // Getters
    public int getHours() { return hours; }
    public int getMinutes() { return minutes; }
    public int getSeconds() { return seconds; }

    // Setters
    public void setHours(int hours) {
        this.hours = (hours >= 0 && hours < 24) ? hours : 0;
    }
    public void setMinutes(int minutes) {
        this.minutes = (minutes >= 0 && minutes < 60) ? minutes : 0;
    }
    public void setSeconds(int seconds) {
        this.seconds = (seconds >= 0 && seconds < 60) ? seconds : 0;
    }

    // Increment time by one second
    public void tick() {
        seconds++;
        if (seconds == 60) {
            seconds = 0;
            minutes++;
            if (minutes == 60) {
                minutes = 0;
                hours = (hours + 1) % 24;
            }
        }
    }

    // Decrement time by one second
    public void tickDown() {
        seconds--;
        if (seconds < 0) {
            seconds = 59;
            minutes--;
            if (minutes < 0) {
                minutes = 59;
                hours = (hours - 1 + 24) % 24;
            }
        }
    }

    // Add another clock's time to this clock
    public void addClock(Clock other) {
        int totalSeconds = this.toSeconds() + other.toSeconds();
        setClock(totalSeconds % (24 * 3600)); // wrap around 24 hours
    }

    // Subtract another clock's time from this clock, return as new Clock
    public Clock subtractClock(Clock other) {
        int diff = this.toSeconds() - other.toSeconds();
        if (diff < 0) diff += 24 * 3600; // wrap around
        return new Clock(diff);
    }

    // Convert current time to seconds since midnight
    private int toSeconds() {
        return hours * 3600 + minutes * 60 + seconds;
    }

    // String representation
    public String toString() {
        return String.format("(%02d:%02d:%02d)", hours, minutes, seconds);
    }
}

// Demo class
public class Ques11 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Instantiate firstClock using seconds since midnight
        System.out.print("Enter seconds since midnight for firstClock: ");
        int secSinceMidnight = sc.nextInt();
        Clock firstClock = new Clock(secSinceMidnight);

        // Tick firstClock 10 times
        System.out.println("Ticking firstClock 10 times:");
        for (int i = 0; i < 10; i++) {
            firstClock.tick();
            System.out.println(firstClock);
        }

        // Instantiate secondClock using hours, minutes, seconds
        System.out.print("Enter hours for secondClock: ");
        int h = sc.nextInt();
        System.out.print("Enter minutes for secondClock: ");
        int m = sc.nextInt();
        System.out.print("Enter seconds for secondClock: ");
        int s = sc.nextInt();
        Clock secondClock = new Clock(h, m, s);

        // Tick secondClock 10 times
        System.out.println("Ticking secondClock 10 times:");
        for (int i = 0; i < 10; i++) {
            secondClock.tick();
            System.out.println(secondClock);
        }

        // Add secondClock to firstClock
        firstClock.addClock(secondClock);

        // Print both clocks
        System.out.println("firstClock: " + firstClock);
        System.out.println("secondClock: " + secondClock);

        // Subtract secondClock from firstClock
        Clock thirdClock = firstClock.subtractClock(secondClock);
        System.out.println("thirdClock (firstClock - secondClock): " + thirdClock);

        sc.close();
    }
}