package com.eventmgmt.servlet;

import com.eventmgmt.dao.EventDAO;
import com.eventmgmt.model.Event;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import org.json.JSONArray;
import org.json.JSONObject;

public class EventListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EventDAO dao = new EventDAO();
        List<Event> events = dao.getAllEvents();

        JSONArray arr = new JSONArray();
        for (Event e : events) {
            JSONObject o = new JSONObject();
            o.put("id", e.getId());
            o.put("title", e.getTitle());
            o.put("description", e.getDescription());
            o.put("location", e.getLocation());
            o.put("start_date", e.getStartDate() != null ? e.getStartDate().toString() : "");
            o.put("end_date", e.getEndDate() != null ? e.getEndDate().toString() : "");
            o.put("capacity", e.getCapacity());
            arr.put(o);
        }

        resp.setContentType("application/json");
        resp.getWriter().write(arr.toString());
    }
}
