package com.dhyan.dao;

import com.dhyan.model.User;
import com.dhyan.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    
    public User userInfo(String email, String password) {
        
        String sql = "SELECT userID, full_name, email FROM users WHERE email = ? AND password = ?";
        
        try (Connection conn = DBConnection.dbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    
                    user.setUserID(rs.getInt("userID")); 
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    
                    return user; 
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
