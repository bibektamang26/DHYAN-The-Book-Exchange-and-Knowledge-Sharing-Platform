package com.dhyan.service;

import java.sql.SQLException;

import org.apache.commons.codec.digest.DigestUtils;

import com.dhyan.dao.LoginDAO;

public class LoginService {
	
	private LoginDAO loginDAO = new LoginDAO();
	
	public boolean loginUserService(String email, String password) throws SQLException {
		String hashedPassword = DigestUtils.sha256Hex(password);
		
		return loginDAO.loginUser(email, hashedPassword);
	}
}
