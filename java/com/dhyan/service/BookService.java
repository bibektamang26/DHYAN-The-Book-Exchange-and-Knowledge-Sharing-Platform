package com.dhyan.service;

import java.util.List;
import com.dhyan.dao.BookDAO;
import com.dhyan.model.Book;

public class BookService {
    private BookDAO bookDAO = new BookDAO();

    /**
     * Business Rule: Adds a book to the library, but checks for duplicates first.
     * @return true if successfully inserted, false if it failed or was a duplicate.
     */
    public boolean addBook(Book book) {
        // Validate inputs before processing data layers
        if (book == null || book.getTitle() == null || book.getAuthor() == null) {
            return false;
        }

        // Apply business rule validation check for duplicate entry
        boolean isDuplicate = bookDAO.isDuplicateBook(book.getUserID(), book.getTitle(), book.getAuthor());
        if (isDuplicate) {
            System.out.println("Business Validation Refusal: Book already exists in user's library.");
            return false;
        }

        // Default setting for a new book catalog row if not already provided
        if (book.getStatus() == null || book.getStatus().trim().isEmpty()) {
            book.setStatus("AVAILABLE");
        }

        return bookDAO.insertBook(book);
    }

    /**
     * Retrieves all books uploaded across the platform to display in the global feed/catalog.
     */
    public List<Book> getAllAvailableBooks() {
        return bookDAO.getAllBooks();
    }

    /**
     * Retrieves personal books uploaded by a specific logged-in user for their library management panel.
     */
    public List<Book> getMyPersonalBooks(int userID) {
        if (userID <= 0) {
            return java.util.Collections.emptyList();
        }
        return bookDAO.getBooksByUserID(userID);
    }

    /**
     * Business Rule: Deletes a book but verifies that the book belongs to the user trying to remove it.
     */
    public boolean removeBook(int bookID, int userID) {
        if (bookID <= 0 || userID <= 0) {
            return false;
        }
        return bookDAO.deleteBookByID(bookID, userID);
    }
}
