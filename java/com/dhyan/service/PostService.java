package com.dhyan.service;

import java.util.List;

import com.dhyan.dao.PostDAO;
import com.dhyan.model.Post;

public class PostService {
	
	PostDAO dao = new PostDAO();
	
	// createPost Service 
	public boolean createPost(Post post) {
		return dao.createPost(post);
	}
	
	// retrieve all the posts
	public List<Post> getAllPosts(){
		return dao.getAllPosts();
	}
	
	// Delete a post!
	public boolean deletePost(int postID, int userID) {
		if (postID <= 0 || userID <= 0) {
            return false;
        }
		return dao.deletePostByID(postID,userID);
	}
	
	// Get Like Counts for a post!
	public int getLikeCounts(int postID,int userID) {
		return dao.getlikeCounts(postID, userID);
	}
	
	// Get Comment Counts for a post!
	public int getCommentCount(int postID, int userID) {
		return dao.getCommentCounts(postID, userID);
	}
}
