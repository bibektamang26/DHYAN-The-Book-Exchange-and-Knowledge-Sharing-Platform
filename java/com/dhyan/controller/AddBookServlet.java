package com.dhyan.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.dhyan.dao.BookDAO;
import com.dhyan.model.Book;
import com.dhyan.model.User;

@WebServlet("/AddBookServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AddBookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        String area = request.getParameter("location");

        BookDAO dao = new BookDAO();

        if (dao.isDuplicateBook(loggedInUser.getUserID(), title, author)) {
            session.setAttribute("dashboardErrorMessage", "You have already added '" + title + "' to your library!");
            response.sendRedirect("dashboard.jsp");
            return;
        }

        Part filePart = request.getPart("bookCover");
        String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);

        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + "uploads";

        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        try {
            filePart.write(savePath + File.separator + fileName);
            String relativeDBPath = "uploads/" + fileName;

            // Populate Model Object
            Book newBook = new Book();
            newBook.setTitle(title);
            newBook.setAuthor(author);
            newBook.setCategory(category);
            newBook.setArea(area);
            newBook.setCoverImagePath(relativeDBPath);
            newBook.setUserID(loggedInUser.getUserID());
            newBook.setStatus("Available");

            // Database Insertion Processing
            boolean success = dao.insertBook(newBook);

            if (success) {
                session.setAttribute("dashboardSuccessMessage", "“" + title + "” successfully added to your library!");
            } else {
                session.setAttribute("dashboardErrorMessage", "Database insertion failed. Please try again.");
            }
        } catch (Exception e) {
            System.err.println("File processing error: " + e.getMessage());
            session.setAttribute("dashboardErrorMessage", "An internal error occurred while saving your book upload.");
        }

        response.sendRedirect("dashboard.jsp");
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "default-cover.png";
    }
}
