package com.dhyan.model;

public class Book {
    private int bookID;
    private String title;
    private String author;
    private String category;
    private String area;
    private String coverImagePath;
    private int userID;
    private String status;

    // Empty Constructor
    public Book() {}

    // Overloaded Constructor
    public Book(int bookID, String title, String author, String category, String area, String coverImagePath, int userID, String status) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.category = category;
        this.area = area;
        this.coverImagePath = coverImagePath;
        this.userID = userID;
        this.status = status;
    }

    // Getters and Setters
    public int getBookID() { return bookID; }
    public void setBookID(int bookID) { this.bookID = bookID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }

    public String getCoverImagePath() { return coverImagePath; }
    public void setCoverImagePath(String coverImagePath) { this.coverImagePath = coverImagePath; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
