package com.dhyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dhyan.model.Post;
import com.dhyan.util.DBConnection;

public class PostDAO {

	// 1. Create a post!
	public boolean createPost(Post post) {
		String sql = "INSERT INTO posts (userID, content) VALUES (?, ?);";
		try (Connection connection = DBConnection.dbConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);) {
			stmt.setInt(1, post.getUserID());
			stmt.setString(2, post.getContent());

			return stmt.executeUpdate() > 0;
		}

		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 2. View all the posts!
	public List<Post> getAllPosts() {
		List<Post> posts = new ArrayList<>();
		// Change your select query string to this:
		String sql = "SELECT p.postID, p.userID, p.content, p.created_at, u.full_name " +
		             "FROM posts p " +
		             "JOIN users u ON p.userID = u.userID " +
		             "ORDER BY p.created_at DESC";
		try (Connection conn = DBConnection.dbConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				Post post = new Post();
				post.setAuthorName(rs.getString("full_name"));
				post.setPostID(rs.getInt("postID"));
				post.setUserID(rs.getInt("userID"));
				post.setContent(rs.getString("content"));
				post.setCreated_at(rs.getTimestamp("created_at"));
				posts.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return posts;
	}

	// 3. Delete a post!
	public boolean deletePostByID(int postID, int userID) {
		String sql = "DELETE FROM posts where postID = ? AND userID = ?;";
		try (Connection connection = DBConnection.dbConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);) {
			stmt.setInt(1, postID);
			stmt.setInt(2, userID);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 4. Get likes Count
	public int getlikeCounts(int postID, int userID) {
		String sql = "SELECT COUNT(*) FROM post_Likes WHERE postID = ? and userID = ?;";

		int count = 0;

		try (Connection connection = DBConnection.dbConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);) {
			stmt.setInt(1, postID);
			stmt.setInt(2, userID);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// 5. Get comment counts
	public int getCommentCounts(int postID, int userID) {

		String sql = "SELECT COUNT(*) FROM comments WHERE psotID = ? AND userID = ? ;";
		int count = 0;
		try(Connection connection = DBConnection.dbConnection();
			PreparedStatement stmt = connection.prepareStatement(sql);){
			stmt.setInt(1, postID);
			stmt.setInt(2, userID);
			try(ResultSet rs = stmt.executeQuery()){
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return count;
		
	}
}
