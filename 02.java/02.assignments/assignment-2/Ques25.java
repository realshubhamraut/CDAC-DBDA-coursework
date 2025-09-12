// Create an abstract class Appliance with abstract methods turnOn () and turnOff ().
// Implement these in Fan and Light classes.

abstract class Appliance{
    abstract public void turnOn();
    abstract public void turnOff();
}


class Fan extends Appliance{
    Boolean state;
    public Fan(Boolean state){
        this.state = state;
    }

    public void turnOn(){
        System.out.println("The fan is turned on 🔵");
    }

    public void turnOff(){
        System.out.println("The fan is turned off 🔴");
    }
}

class Light extends Appliance{
    Boolean state;
    public Light(Boolean state){
        this.state = state;
    }
    public void turnOn(){
        System.out.println("The light is turned on 🔵");
    }

    public void turnOff(){
        System.out.println("The light is turned off 🔴");
    }


}
public class Ques25 {
    public static void main(String[] args){
        Light li = new Light(true);
        Fan fe = new Fan(false);

        fe.turnOff();
        li.turnOn();
    }
    
}
