package com.dhyan.controller;

import com.dhyan.model.User;
import com.dhyan.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam != null && !bookIdParam.trim().isEmpty()) {
            try {
                int bookID = Integer.parseInt(bookIdParam);

                boolean isDeleted = bookService.removeBook(bookID, currentUser.getUserID());
                
                if (isDeleted) {
                	session.setAttribute("deleteSuccessMessage", "Book deleted successfully!");
                } else {
                	session.setAttribute("deleteSuccessMessage", "Failed to delete the book. Please try again.");
                    System.err.println("Failed to delete Book ID: " + bookID);
                }
                
            } catch (NumberFormatException e) {
            	session.setAttribute("deleteErrorMessage", "Invalid book identifier.");
                System.err.println("Invalid Book ID parameter passed: " + bookIdParam);
            }
        }
        response.sendRedirect("ProfileServlet");
    }
}
