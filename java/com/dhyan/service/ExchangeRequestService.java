package com.dhyan.service;

import com.dhyan.dao.ExchangeRequestDAO;
import com.dhyan.model.ExchangeRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExchangeRequestService {
    private ExchangeRequestDAO dao = new ExchangeRequestDAO();

    /**
     * Business Rule: Submits a new book exchange request from one user to another.
     */
    public boolean sendBookRequest(int bookID, int senderID, int receiverID) {
        if (senderID == receiverID) {
            System.out.println("Business Rule Violation: Users cannot request their own books.");
            return false; 
        }
        return dao.createRequest(bookID, senderID, receiverID);
    }

    /**
     * Business Rule: Assembles both inbound and outbound request streams into a structural dashboard payload map.
     */
    public Map<String, List<ExchangeRequest>> getUserRequestsDashboard(int userId) {
        Map<String, List<ExchangeRequest>> dashboardMap = new HashMap<>();
        
        List<ExchangeRequest> incoming = dao.getReceivedRequests(userId);
        List<ExchangeRequest> outbound = dao.getSentRequests(userId);
        
        dashboardMap.put("incoming", incoming);
        dashboardMap.put("outbound", outbound);
        
        return dashboardMap;
    }

    /**
     * Business Rule: Updates the processing status flag safely (ACCEPTED, DECLINED, CANCELLED).
     */
    public boolean changeRequestStatus(int requestID, String status) {
        if (status == null || status.trim().isEmpty()) {
            return false;
        }
        return dao.updateStatus(requestID, status.toUpperCase().trim());
    }
    
    /**
     * Business Rule: Cancelling a sent request permanently deletes it from the database,
     * rather than just flagging it. Ownership is enforced (userID must be the sender).
     */
    public boolean cancelRequest(int requestID, int userID) {
        return dao.deleteRequest(requestID, userID);
    }
    
}
