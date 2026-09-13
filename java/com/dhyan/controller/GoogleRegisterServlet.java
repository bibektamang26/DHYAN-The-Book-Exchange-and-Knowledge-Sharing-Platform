package com.dhyan.controller;

import java.io.IOException;
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Google API Imports
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

@WebServlet("/google-register")
public class GoogleRegisterServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    // Replace with your actual Google Cloud Console Client ID
    private static final String GOOGLE_CLIENT_ID = "YOUR_GOOGLE_CLIENT_://googleusercontent.com";
    
    private GoogleIdTokenVerifier verifier;

    @Override
    public void init() throws ServletException {
        // Initialize the verifier once when the servlet starts
        this.verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
                .setAudience(Collections.singletonList(GOOGLE_CLIENT_ID))
                .build();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idTokenString = request.getParameter("credential");
        
        try {
            if (idTokenString != null && !idTokenString.trim().isEmpty()) {
                
                GoogleIdToken idToken = verifier.verify(idTokenString);
                
                if (idToken != null) {
                    Payload payload = idToken.getPayload();

                    String email = payload.getEmail();
                    boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
                    String name = (String) payload.get("name");
                    String pictureUrl = (String) payload.get("picture");
                    String googleUserId = payload.getSubject(); 
                    if (!emailVerified) {
                        request.setAttribute("errorMessage", "Your Google email address is not verified.");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                        return;
                    }

                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Registration Successful, Please login!");
                    response.sendRedirect("login"); 
                    return; 
                    
                } else {
                    request.setAttribute("errorMessage", "Invalid ID token. Security verification failed.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                
            } else {
                request.setAttribute("errorMessage", "Google registration failed. Empty token received.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
        } catch (Exception e) {
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "Google sign-up failed due to an internal system error.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
    }
}
