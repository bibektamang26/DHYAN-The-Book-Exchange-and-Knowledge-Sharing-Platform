
package com.dhyan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.model.User;
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
			User user = loginService.getUserInfo(email, password);

			if (user != null) {
				session.setAttribute("user", user);
				response.sendRedirect("dashboard.jsp");
				return;
			} else {
				session.setAttribute("errorMessage", "Invalid email or password.");
				response.sendRedirect("login.jsp");
				return;
			}

		} catch (Exception e) {
			System.out.println("Login Failed due to DB error: " + e.getMessage());
			session.setAttribute("errorMessage", "Something went wrong. Please try again.");
			response.sendRedirect("login.jsp");
		}
	}

}
