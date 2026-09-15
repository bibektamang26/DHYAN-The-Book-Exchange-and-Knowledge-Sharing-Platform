package com.dhyan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhyan.dao.BookDAO;
import com.dhyan.model.Book;

@WebServlet("/BrowseBooksServlet")
public class BrowseBooksServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        BookDAO dao = new BookDAO();
        List<Book> dbBooksList = dao.getAllBooks();
        
        // Expose database object rows context list into the Request Scope attribute map
        request.setAttribute("sqlBooksList", dbBooksList);
        
        // Forward the array down to the UI JSP view layer
        request.getRequestDispatcher("books.jsp").forward(request, response);
    }
}
