package com.dhyan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.service.BookService;
import com.dhyan.service.ExchangeRequestService;
import com.dhyan.model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");

		if (currentUser != null) {
		    ExchangeRequestService requestService = new ExchangeRequestService();
		    BookService bookService = new BookService();
		    
		    // Getting the values
		    int activeRequestsCount = requestService.requestCount(currentUser.getUserID());
		    int sharedBooksCount = bookService.bookCountByID(currentUser.getUserID());
		   
		    // Setting the values
		    currentUser.setActiveRequests(activeRequestsCount);
		    currentUser.setBooksShared(sharedBooksCount);
		    
		    session.setAttribute("user", currentUser);
		    request.getRequestDispatcher("dashboard.jsp").forward(request, response);
		} else {
		    response.sendRedirect("login.jsp");
		}
	}
}
