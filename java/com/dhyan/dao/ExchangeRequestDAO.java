package com.dhyan.dao;

import com.dhyan.model.ExchangeRequest;
import com.dhyan.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExchangeRequestDAO {

    // 1. Submit a brand new book exchange request
    public boolean createRequest(int bookID, int senderID, int receiverID) {
        String sql = "INSERT INTO exchangeRequests (bookID, senderID, receiverID, status) VALUES (?, ?, ?, 'PENDING')";
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookID);
            stmt.setInt(2, senderID);
            stmt.setInt(3, receiverID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. GET RECEIVED REQUESTS (For the logged-in user who is the receiverID)
    public List<ExchangeRequest> getReceivedRequests(int userId) {
        List<ExchangeRequest> list = new ArrayList<>();
        String sql = "SELECT r.requestID, r.bookID, r.senderID, r.receiverID, r.status, r.createdAt, " +
                     "b.title, b.cover_image_path, u.full_name AS sender_name " +
                     "FROM exchangeRequests r " +
                     "JOIN books b ON r.bookID = b.bookID " +
                     "JOIN users u ON r.senderID = u.userID " +
                     "WHERE r.receiverID = ?";
                     
        try (Connection conn = DBConnection.dbConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ExchangeRequest req = new ExchangeRequest();
                    req.setRequestID(rs.getInt("requestID")); // Correctly mapping column row data
                    req.setBookID(rs.getInt("bookID"));
                    req.setSenderID(rs.getInt("senderID"));
                    req.setReceiverID(rs.getInt("receiverID"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getTimestamp("createdAt"));
                    
                    // Join table aliases mapped to helper UI attributes
                    req.setBookTitle(rs.getString("title"));
                    req.setCoverImagePath(rs.getString("cover_image_path"));
                    req.setSenderName(rs.getString("sender_name"));
                    
                    list.add(req);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 3. GET SENT REQUESTS (For the logged-in user who is the senderID)
    public List<ExchangeRequest> getSentRequests(int userId) {
        List<ExchangeRequest> list = new ArrayList<>();
        String sql = "SELECT r.requestID, r.bookID, r.senderID, r.receiverID, r.status, r.createdAt, " +
                     "b.title, b.cover_image_path, u.full_name AS receiver_name " +
                     "FROM exchangeRequests r " +
                     "JOIN books b ON r.bookID = b.bookID " +
                     "JOIN users u ON r.receiverID = u.userID " +
                     "WHERE r.senderID = ?";
                     
        try (Connection conn = DBConnection.dbConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ExchangeRequest req = new ExchangeRequest();
                    req.setRequestID(rs.getInt("requestID"));
                    req.setBookID(rs.getInt("bookID"));
                    req.setSenderID(rs.getInt("senderID"));
                    req.setReceiverID(rs.getInt("receiverID"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getTimestamp("createdAt"));
                    
                    req.setBookTitle(rs.getString("title"));
                    req.setCoverImagePath(rs.getString("cover_image_path"));
                    req.setReceiverName(rs.getString("receiver_name"));
                    
                    list.add(req);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 4. Update request state flags (Accepting, Declining, Canceling)
    public boolean updateStatus(int requestID, String newStatus) {
        String sql = "UPDATE exchangeRequests SET status = ? WHERE requestID = ?";
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, requestID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //5. DELETE request 
    public boolean deleteRequest(int requestID, int senderID) {
    	 String sql = "DELETE FROM exchangeRequests WHERE requestID = ? AND senderID = ?";
         try (Connection conn = DBConnection.dbConnection();
              PreparedStatement stmt = conn.prepareStatement(sql)) {
             stmt.setInt(1, requestID);
             stmt.setInt(2, senderID);
             return stmt.executeUpdate() > 0;
         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
    }
}
