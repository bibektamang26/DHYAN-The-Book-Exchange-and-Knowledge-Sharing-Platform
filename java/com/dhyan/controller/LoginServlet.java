package com.dhyan.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhyan.service.LoginService;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private LoginService loginService = new LoginService();

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException { 
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
        	boolean isValidUser = loginService.loginUserService(email, password);
        	if(isValidUser) {
        		response.sendRedirect("dashboard.jsp");
        	}
        	else {
        		response.sendRedirect("login.jsp?error=InvalidCredentials");
        	}
        }
        catch(SQLException e){
        	System.out.println("Login Failed due to DB error: " + e.getMessage());
    		request.setAttribute("errorMessage", "Database connection error.");
    		request.getRequestDispatcher("login.jsp").forward(request, response);
        }
   
	}	
}
