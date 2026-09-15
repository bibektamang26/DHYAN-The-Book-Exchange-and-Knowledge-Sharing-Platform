package com.dhyan.controller;

import com.dhyan.dao.BookDAO;
import com.dhyan.model.Book;
import com.dhyan.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BookDAO bookDAO = new BookDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        List<Book> myPersonalBooksList = bookDAO.getBooksByUserID(currentUser.getUserID());

        request.setAttribute("myPersonalBooksList", myPersonalBooksList);
        
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
