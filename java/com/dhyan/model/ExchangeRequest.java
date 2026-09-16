package com.dhyan.model;

import java.sql.Timestamp;

public class ExchangeRequest {
    private int requestID;
    private int bookID;
    private int senderID;
    private int receiverID;
    private String status;
    private Timestamp createdAt;

    // Helper fields to easily render UI text on the 2nd & 3rd screen layouts
    private String bookTitle;
    private String coverImagePath;
    private String senderName;   
    private String receiverName; 

    // Getters and Setters
    public int getRequestID() { return requestID; }
    public void setRequestID(int requestID) { this.requestID = requestID; }

    public int getBookID() { return bookID; }
    public void setBookID(int bookID) { this.bookID = bookID; }

    public int getSenderID() { return senderID; }
    public void setSenderID(int senderID) { this.senderID = senderID; }

    public int getReceiverID() { return receiverID; }
    public void setReceiverID(int receiverID) { this.receiverID = receiverID; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }

    public String getCoverImagePath() { return coverImagePath; }
    public void setCoverImagePath(String coverImagePath) { this.coverImagePath = coverImagePath; }

    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }
}
