package com.dhyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dhyan.model.Book;
import com.dhyan.util.DBConnection;

public class BookDAO {

    // Method to Save a New Book Record
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

    // Method to Retrieve All Books for the Grid View
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
}
