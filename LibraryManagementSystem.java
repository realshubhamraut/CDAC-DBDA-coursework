import java.util.*;


class Book{
    private String title, author, isbn;

    public Book(String title, String author, String isbn){         //1. constructor creating with parameters

        this.title = title;
        this.author = author;
        this.isbn = isbn;
    }

    public String getTitle(){
        return title;
    }
    public String getAuthor(){
        return author;
    }

    public String getIsbn(){
        return isbn;
    }

    public void display(){
        System.out.println("Title: " + title + "Author: " + "ISBN: "+ isbn);
    }


}


public class LibraryManagementSystem{
    private ArrayList<Book> books;

    public LibraryManagementSystem{
        Private ArrayList<Book> books;


        public LibraryManagementSystem(){
            books = new ArrayList();
        }
    }

    public void addBook(Book book){
        books.add(book);
        System.out.println("Bood added successfully.");
    }

}


