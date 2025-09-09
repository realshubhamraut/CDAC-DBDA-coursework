//0. 


class Pen{
    String type;
    String color;
    int price;

    Pen(String type, String color, int price){
        this.type = type;
        this.color = color;
        this.price = price;
    }

    public void print(){
        System.out.println("Pen properties");
        System.out.println(this.type);
        System.out.println(this.color);
    }
}



 
public class OOPs{
    public static void main(String[] args){
        Pen p1 = new Pen("Ball","Pink",34);
        Pen p2 = new Pen("Gel","purple",34);

        p1.print();
        p2.print();

    }
}