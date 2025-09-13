import java.util.ArrayList;
import java.util.Scanner;

class Book {
    private String title;
    private String author;
    private String isbn;

    public Book(String title, String author, String isbn) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }
    public String getAuthor() {
        return author;
    }
    public String getIsbn() {
        return isbn;
    }

    public void display() {
        System.out.println("Title: " + title + ", Author: " + author + ", ISBN: " + isbn);
    }
}

public class LibraryManagementSystem {
    private ArrayList<Book> books;

    public LibraryManagementSystem() {
        books = new ArrayList<>();
    }

    public void addBook(Book book) {
        books.add(book);
        System.out.println("Book added successfully.");
    }

    public void removeBook(String isbn) {
        boolean removed = books.removeIf(book -> book.getIsbn().equals(isbn));
        if (removed) {
            System.out.println("Book with ISBN " + isbn + " removed successfully.");
        } else {
            System.out.println("Book with ISBN " + isbn + " not found.");
        }
    }

    public void searchBookByTitle(String title) {
        boolean found = false;
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                book.display();
                found = true;
            }
        }
        if (!found) {
            System.out.println("Book with title \"" + title + "\" not found.");
        }
    }

    public void displayAllBooks() {
        if (books.isEmpty()) {
            System.out.println("No books in the library.");
            return;
        }
        for (Book book : books) {
            book.display();
        }
    }

    public static void main(String[] args) {
        LibraryManagementSystem library = new LibraryManagementSystem();
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("\nLibrary Management System Menu");
            System.out.println("1. Add a book");
            System.out.println("2. Remove a book by ISBN");
            System.out.println("3. Search a book by title");
            System.out.println("4. Display all books");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();  

            switch (choice) {
                case 1:
                    System.out.print("Enter book title: ");
                    String title = scanner.nextLine();
                    System.out.print("Enter author name: ");
                    String author = scanner.nextLine();
                    System.out.print("Enter ISBN number: ");
                    String isbn = scanner.nextLine();
                    Book book = new Book(title, author, isbn);
                    library.addBook(book);
                    break;
                case 2:
                    System.out.print("Enter ISBN number to remove: ");
                    String removeIsbn = scanner.nextLine();
                    library.removeBook(removeIsbn);
                    break;
                case 3:
                    System.out.print("Enter book title to search: ");
                    String searchTitle = scanner.nextLine();
                    library.searchBookByTitle(searchTitle);
                    break;
                case 4:
                    library.displayAllBooks();
                    break;
                case 5:
                    System.out.println("Exiting Library Management System.");
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("Invalid choice, please try again.");
            }
        }
    }
}
