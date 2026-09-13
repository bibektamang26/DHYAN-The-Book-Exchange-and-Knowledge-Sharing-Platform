package com.dhyan.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.service.LoginService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private LoginService loginService = new LoginService();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException { 
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession();
        
        try {
            String fullName = loginService.loginUserService(email, password);
            if (fullName != null) {
                session.setAttribute("fullName", fullName);
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                session.setAttribute("errorMessage", "Invalid email or password.");
                response.sendRedirect("login.jsp?error=InvalidCredentials");
                return;
            }
        }
        catch(SQLException e){
        	System.out.println("Login Failed due to DB error: " + e.getMessage());
        	session.setAttribute("errorMessage", "Invalid Credentials.");
            response.sendRedirect("login.jsp");
        }
   
	}	
}
