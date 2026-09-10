package com.dhyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dhyan.util.DBConnection;

public class LoginDAO {
	public boolean loginUser(String email, String password) throws SQLException {

		String sql = "SELECT * FROM users WHERE email = ? AND password = ?;";
		
		try (Connection connection = DBConnection.dbConnection();
				PreparedStatement ps = connection.prepareStatement(sql)){
			
			ps.setString(1, email);
			ps.setString(2, password);
			try(ResultSet rs = ps.executeQuery()){
				return rs.next();
			}
		}
	}
}
