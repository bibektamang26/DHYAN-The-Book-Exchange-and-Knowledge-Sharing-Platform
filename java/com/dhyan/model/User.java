package com.dhyan.model;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private int userID;
	private String fullName;
	private String email;
	private int activeRequests;
	private int booksShared;

	public int getActiveRequests() {
		return activeRequests;
	}

	public void setActiveRequests(int activeRequests) {
		this.activeRequests = activeRequests;
	}

	public int getBooksShared() {
		return booksShared;
	}

	public void setBooksShared(int booksShared) {
		this.booksShared = booksShared;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}