package com.dhyan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.model.Book;
import com.dhyan.model.User;
import com.dhyan.service.BookService;

@WebServlet("/BrowseBooksServlet")
public class BrowseBooksServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    private BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Book> dbBooksList = bookService.getAllAvailableBooks();

        request.setAttribute("sqlBooksList", dbBooksList);

        request.getRequestDispatcher("books.jsp").forward(request, response);
    }
}