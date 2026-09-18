package com.dhyan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhyan.model.Post;
import com.dhyan.model.User;
import com.dhyan.service.PostService;

@WebServlet("/community")
public class CommunityServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User currentUser = (session != null)? (User) session.getAttribute("user")
                : null;

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Post> posts = postService.getAllPosts();

        request.setAttribute("posts", posts);

        request.getRequestDispatcher("community.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User currentUser = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String content = request.getParameter("content");

        Post post = new Post();

        post.setUserID(currentUser.getUserID());
        post.setContent(content);

        boolean success = postService.createPost(post);

        if (success) {
            response.sendRedirect("community");
        } else {
            response.sendRedirect("community.jsp");
        }
    }
}