// Create a base class Animal with a method makeSound (). Create a subclass Dog that
// overrides makeSound () to print "Bark".

class Animal{
    void makeSound(){
        System.out.println("Noise");
    }
}

class Dog extends Animal{
    void makeSound(){
        System.out.println("Bark");
    }
}



public class Ques1{
    public static void main(String[] args){
        Animal a = new Animal();
        Dog d = new Dog();
        
        d.makeSound();


    }



}