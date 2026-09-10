package com.dhyan.service;

import java.sql.SQLException;

import org.apache.commons.codec.digest.DigestUtils;

import com.dhyan.dao.RegisterDAO;

public class RegisterService {

    private RegisterDAO registerDAO = new RegisterDAO();

    public void registerUserService(String fullName, String email, String password)
            throws SQLException {

    	String hashedPassword = DigestUtils.sha256Hex(password);

        registerDAO.registerUser(fullName, email, hashedPassword);
    }
}