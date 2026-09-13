package com.dhyan.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.service.RegisterService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private RegisterService registerService = new RegisterService();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getRequestDispatcher("register.jsp").forward(request, response);
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            registerService.registerUserService(fullName, email, password);
            request.getSession().setAttribute("successMessage", "Registration Successful, please login!!");
            response.sendRedirect("login.jsp");
            return; 

        } catch (SQLException e) {
            System.out.println("Registration DB Error: " + e.getMessage()); 
            request.setAttribute("errorMessage", "Registration failed due to a database error. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
