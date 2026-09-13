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
        
        HttpSession session = request.getSession();
        Integer loggedInUserID = (Integer) session.getAttribute("userID");
        
        // Fallback placeholder ID if session logic isn't wired up yet
        if (loggedInUserID == null) {
            loggedInUserID = 1; 
        }

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        String area = request.getParameter("location"); // matches JS parameter key choice 'location'

        // Catch Cover Binary File
        Part filePart = request.getPart("bookCover");
        String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
        
        // Local relative app assets directory folder mapping targeting server context disk paths
        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + "uploads";
        
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        filePart.write(savePath + File.separator + fileName);
        String relativeDBPath = "uploads/" + fileName;

        // Populate Model Domain object
        Book newBook = new Book();
        newBook.setTitle(title);
        newBook.setAuthor(author);
        newBook.setCategory(category);
        newBook.setArea(area);
        newBook.setCoverImagePath(relativeDBPath);
        newBook.setUserID(loggedInUserID);
        newBook.setStatus("Available");

        BookDAO dao = new BookDAO();
        boolean success = dao.insertBook(newBook);

        if (success) {
            // Success redirect straight to the browse loading route controller!
            response.sendRedirect("BrowseBooksServlet");
        } else {
            response.sendRedirect("dashboard.jsp?error=database_fail");
        }
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
