import java.util.*;

class Book {
    private String title;
    private String author;
    private boolean isBorrowed;

    public Book(String title, String author) {
        this.title = title;
        this.author = author;
        this.isBorrowed = false;
    }

    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public boolean isBorrowed() { return isBorrowed; }

    public void borrow() { isBorrowed = true; }
    public void returnBook() { isBorrowed = false; }

    @Override
    public String toString() {
        return "\"" + title + "\" by " + author + (isBorrowed ? " [Borrowed]" : " [Available]");
    }
}

class Library {
    private List<Book> books = new ArrayList<>();

    public void addBook(String title, String author) {
        books.add(new Book(title, author));
        System.out.println("Book added successfully.");
    }

    public void showBooks() {
        if (books.isEmpty()) {
            System.out.println("No books in library.");
            return;
        }
        for (int i = 0; i < books.size(); i++) {
            System.out.println((i+1) + ". " + books.get(i));
        }
    }

    public void searchBook(String title) {
        boolean found = false;
        for (Book b : books) {
            if (b.getTitle().equalsIgnoreCase(title)) {
                System.out.println(b);
                found = true;
            }
        }
        if (!found) System.out.println("Book not found.");
    }

    public void borrowBook(String title) {
        for (Book b : books) {
            if (b.getTitle().equalsIgnoreCase(title)) {
                if (!b.isBorrowed()) {
                    b.borrow();
                    System.out.println("You borrowed: " + b.getTitle());
                } else {
                    System.out.println("Book is already borrowed.");
                }
                return;
            }
        }
        System.out.println("Book not found.");
    }

    public void returnBook(String title) {
        for (Book b : books) {
            if (b.getTitle().equalsIgnoreCase(title)) {
                if (b.isBorrowed()) {
                    b.returnBook();
                    System.out.println("Book returned: " + b.getTitle());
                } else {
                    System.out.println("Book was not borrowed.");
                }
                return;
            }
        }
        System.out.println("Book not found.");
    }
}

public class LibraryManagement {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Library lib = new Library();
        int choice;
        do {
            System.out.println("\n--- Library Menu ---");
            System.out.println("1. Add Book");
            System.out.println("2. Show All Books");
            System.out.println("3. Search Book by Title");
            System.out.println("4. Borrow Book");
            System.out.println("5. Return Book");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            choice = sc.nextInt();
            sc.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    System.out.print("Enter book title: ");
                    String title = sc.nextLine();
                    System.out.print("Enter author name: ");
                    String author = sc.nextLine();
                    lib.addBook(title, author);
                    break;
                case 2:
                    lib.showBooks();
                    break;
                case 3:
                    System.out.print("Enter book title to search: ");
                    String searchTitle = sc.nextLine();
                    lib.searchBook(searchTitle);
                    break;
                case 4:
                    System.out.print("Enter book title to borrow: ");
                    String borrowTitle = sc.nextLine();
                    lib.borrowBook(borrowTitle);
                    break;
                case 5:
                    System.out.print("Enter book title to return: ");
                    String returnTitle = sc.nextLine();
                    lib.returnBook(returnTitle);
                    break;
                case 6:
                    System.out.println("Exiting Library. Goodbye!");
                    break;
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        } while (choice != 6);
        sc.close();
    }
}