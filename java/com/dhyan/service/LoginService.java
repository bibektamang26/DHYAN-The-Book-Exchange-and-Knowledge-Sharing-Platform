package com.dhyan.service;

import java.sql.SQLException;
import org.apache.commons.codec.digest.DigestUtils;

import com.dhyan.dao.LoginDAO;
import com.dhyan.dao.UserDAO;
import com.dhyan.model.User;

public class LoginService {
	
	private LoginDAO loginDAO = new LoginDAO();
	
    private UserDAO userDAO = new UserDAO(); 
    
    public boolean loginUserService(String email, String password) throws SQLException {
        String hashedPassword = DigestUtils.sha256Hex(password);
        return loginDAO.loginUser(email, hashedPassword);
    }
    public User getUserInfo(String email, String password) throws SQLException {
        String hashedPassword = DigestUtils.sha256Hex(password);
        return userDAO.userInfo(email, hashedPassword);
    }
}
