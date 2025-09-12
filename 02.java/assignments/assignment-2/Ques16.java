// Create a base class Animal with speak () method. Create subclasses Dog and Cat that
// override speak () to print different sounds.

class Animal{
    public void speak(){
        
    }
}


class Dog extends Animal{
    public void speak(){
        System.out.println("Bark");

    }

}


class Cat extends Animal{
    public void speak(){
        System.out.println("Meow");
    }

}

public class Ques16 {
    public static void main (String[] args){
        Dog d = new Dog();
        Cat c = new Cat();

        c.speak();
        d.speak();

    }
    
}
