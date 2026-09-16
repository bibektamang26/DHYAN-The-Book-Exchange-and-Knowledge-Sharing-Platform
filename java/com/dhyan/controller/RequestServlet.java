package com.dhyan.controller;

import com.dhyan.model.ExchangeRequest;
import com.dhyan.model.User;
import com.dhyan.service.ExchangeRequestService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/RequestServlet", "/requests"})
public class RequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ExchangeRequestService exchangeService = new ExchangeRequestService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        Map<String, List<ExchangeRequest>> dashboard =
                exchangeService.getUserRequestsDashboard(loggedInUser.getUserID());

        request.setAttribute("receivedRequestsList", dashboard.get("incoming"));
        request.setAttribute("sentRequestsList", dashboard.get("outbound"));
        request.getRequestDispatcher("requests.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Session Protection Guard
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        String action = request.getParameter("action");

        // CASE 1: Processing requests coming from books.jsp
        if ("submitNewRequest".equals(action)) {
            int bookID = Integer.parseInt(request.getParameter("bookID"));
            int receiverID = Integer.parseInt(request.getParameter("receiverID"));
            int senderID = loggedInUser.getUserID(); // Securely use session user instead of parameter hidden fields

            boolean isCreated = exchangeService.sendBookRequest(bookID, senderID, receiverID);

            if (isCreated) {
                session.setAttribute("browseSuccessMessage", "Book request sent successfully!");
                response.sendRedirect("BrowseBooksServlet");
            } else {
                session.setAttribute("browseErrorMessage", "Failed to request book. You cannot request your own book.");
                response.sendRedirect("BrowseBooksServlet");
            }
            return;
        }

        // CASE 2: Processing action buttons from requests.jsp dashboards (Accept, Decline, Cancel)
        int requestID = Integer.parseInt(request.getParameter("requestID"));
        String statusValue = request.getParameter("statusValue"); // "ACCEPTED", "DECLINED", "CANCELLED"
        
        if ("CANCELLED".equalsIgnoreCase(statusValue)) {
            exchangeService.cancelRequest(requestID, loggedInUser.getUserID());
        } else {
            exchangeService.changeRequestStatus(requestID, statusValue);
        }

        response.sendRedirect("requests");  
      
    }
}
