/*You are developing a Java program for a simple library management system using an ArrayList  to manage books in the library. Each book should have attributes including the title, author, and  ISBN number. Implement a Book class with methods to perform the following actions: 
1. Allow users to add a new book to the library. 
2. Allow users to remove a book from the library by providing its ISBN number.
3. Enable users to search for a book by title and display its details. 
4. Display the list of all books currently in the library. 
 */
import java.util.*;

class Book {

    String title;
    String author;
    int ISBN;

    Book(String t, String a, int i) {
        this.title = t;
        this.author = a;
        this.ISBN = i;
    }

    public String toString() {
        return "title= " + title + ", Author Name= " + author + ", ISBN= " + ISBN;
    }
}

class LibraryQue1 {

    static void display(Collection<?> c) {
        for (Object o : c) {
            System.out.println(o);
        }
    }

    public static void main(String[] args) {

        List<Book> bk = new ArrayList<>();

        Book b = new Book("C++", "Bjarne Stroustrup", 11);
        bk.add(b);
        bk.add(new Book("C", "Bjarne Stroustrup", 22));
        bk.add(new Book("JAVA", "James Gosling", 33));
        bk.add(new Book("Python", "Guido van Rossum", 44));
        bk.add(new Book("Ppp", "pqr", 44));
        System.out.println("Books List ==");
        display(bk);
        String searchTitle = "Python";
        System.out.println("Search = " + searchTitle);
        if (b.title.equalsIgnoreCase(searchTitle)) {
            System.out.println("Found = " + b);
            //int removeISBN = 33;
            System.out.println("Removing book with ISBN = " + 33);
            bk.remove(b.ISBN == 33);
            display(bk);
            System.out.println("Books after removal = ");
            display(bk);
        }
    }
}
