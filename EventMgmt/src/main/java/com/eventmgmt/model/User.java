package com.eventmgmt.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private boolean isAdmin;
    private String registrationDate;
    private java.sql.Timestamp lastEventSeen;

    
    // constructors, getters, setters
    public User() {}
    public User(int id, String name, String email, boolean isAdmin) {
        this.id = id; this.name = name; this.email = email; this.isAdmin = isAdmin;
    }
    // getters/setters...
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
    public String getName(){return name;}
    public void setName(String name){this.name=name;}
    public String getEmail(){return email;}
    public void setEmail(String email){this.email=email;}
    public String getPassword(){return password;}
    public void setPassword(String password){this.password=password;}
    public boolean isAdmin(){return isAdmin;}
    public void setAdmin(boolean isAdmin){this.isAdmin=isAdmin;}
    
    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }
    
    public java.sql.Timestamp getLastEventSeen() {
        return lastEventSeen;
    }

    public void setLastEventSeen(java.sql.Timestamp lastEventSeen) {
        this.lastEventSeen = lastEventSeen;
    }

}

