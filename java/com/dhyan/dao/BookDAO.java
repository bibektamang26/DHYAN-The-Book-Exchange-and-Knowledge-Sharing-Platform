package com.dhyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dhyan.model.Book;
import com.dhyan.util.DBConnection;

public class BookDAO {

    // Method add a book
    public boolean insertBook(Book book) {
        String sql = "INSERT INTO books (title, author, category, area, cover_image_path, userID, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.dbConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getCategory());
            stmt.setString(4, book.getArea());
            stmt.setString(5, book.getCoverImagePath());
            stmt.setInt(6, book.getUserID());
            stmt.setString(7, book.getStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to Retrieve All Books
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY bookID DESC";
        
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookID(rs.getInt("bookID"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setArea(rs.getString("area"));
                book.setCoverImagePath(rs.getString("cover_image_path"));
                book.setUserID(rs.getInt("userID"));
                book.setStatus(rs.getString("status"));
                books.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // Method to retrieve books by userID
    public List<Book> getBooksByUserID(int userID) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE userID = ? ORDER BY bookID DESC";
        
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userID);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBookID(rs.getInt("bookID"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setCategory(rs.getString("category"));
                    book.setArea(rs.getString("area"));
                    book.setCoverImagePath(rs.getString("cover_image_path"));
                    book.setUserID(rs.getInt("userID"));
                    book.setStatus(rs.getString("status"));
                    books.add(book);
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching user personal library items: " + e.getMessage());
            e.printStackTrace();
        }
        return books;
    }
    
    // Method to delete book
    public boolean deleteBookByID(int bookID, int userID) {
       
        String sql = "DELETE FROM books WHERE bookID = ? AND userID = ?";
        
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookID);
            stmt.setInt(2, userID);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("SQL Exception raised during data row deletion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Method to check the duplicate entry
    public boolean isDuplicateBook(int userID, String title, String author) {
        String sql = "SELECT COUNT(*) FROM books WHERE userID = ? AND LOWER(TRIM(title)) = LOWER(TRIM(?)) AND LOWER(TRIM(author)) = LOWER(TRIM(?))";
        
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userID);
            stmt.setString(2, title);
            stmt.setString(3, author);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Returns true if a match is found
                }
            }
        } catch (Exception e) {
            System.err.println("Error checking for duplicate book: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

}
