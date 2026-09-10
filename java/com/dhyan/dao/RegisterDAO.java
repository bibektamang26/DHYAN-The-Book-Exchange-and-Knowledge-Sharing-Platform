package com.dhyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dhyan.util.DBConnection;

public class RegisterDAO {

	public void registerNewUser(String fullName, String email, String password) throws SQLException {
		
		String sql = "INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)";

		try (Connection connection = DBConnection.dbConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, fullName);
			ps.setString(2, email);
			ps.setString(3, password);

			ps.executeUpdate();
			
			
		}
	}
}