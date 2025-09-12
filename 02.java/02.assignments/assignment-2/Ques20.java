// • Create a Browser class with a method openWebsite (). Create subclasses Chrome and
// Firefox that override openWebsite () with specific implementation details.


class Broswer{
    public void openWebsite(){
        System.out.println("This is a generic / parent browser");
    }
}


class Firefox extends Broswer{
    public void openWebsite(){
        System.out.println("This is a Firefox Browser");

    }

}

class Chrome extends Broswer{
    public void openWebsite(){
        System.out.println("This is a Chrome broswer");

    }

}
public class Ques20 {
    public static void main(String args[]){
        Broswer b = new Broswer();
        Firefox f = new Firefox();
        Chrome c = new Chrome();

        b.openWebsite();
        f.openWebsite();
        c.openWebsite();
    }
}
