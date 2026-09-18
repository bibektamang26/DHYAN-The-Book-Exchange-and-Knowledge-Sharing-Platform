package com.dhyan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.model.User;
import com.dhyan.service.PostService;

@WebServlet("/DeletePostServlet") 
public class DeletePostServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null) {
            response.setStatus(401);
            return;
        }

        String postIdStr = request.getParameter("postID");
        if (postIdStr != null) {
            int postId = Integer.parseInt(postIdStr);
            
            PostService postService = new PostService();
            boolean deleted = postService.deletePost(postId, currentUser.getUserID());
            
            if (deleted) {
            	response.setStatus(200);
            	return;
            } else {
            	response.setStatus(500);
            	return;
            }
        }
        
        response.setStatus(400);
    }
}
