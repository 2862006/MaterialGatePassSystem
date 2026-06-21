package com.mgps.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String name = System.getenv("DB_NAME");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASSWORD");
        
        if (host == null) {
            host = "localhost";
            port = "3306";
            name = "material_gate_pass";
            user = "root";
            pass = "Roshan";
        }
        
        String url = "jdbc:mysql://" + host + ":" + port + "/" + name
                   + "?useSSL=true&requireSSL=true";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(e);
        }
        return DriverManager.getConnection(url, user, pass);
    }
    
    public static void initDatabase() {
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS DEPARTMENT (" +
                "dept_id INT AUTO_INCREMENT PRIMARY KEY," +
                "dept_name VARCHAR(100) NOT NULL)");
            
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users (" +
                "user_id INT AUTO_INCREMENT PRIMARY KEY," +
                "email_id VARCHAR(100) NOT NULL UNIQUE," +
                "name VARCHAR(100)," +
                "password VARCHAR(100) NOT NULL," +
                "role ENUM('ADMIN','EMPLOYEE','SECURITY') NOT NULL," +
                "dept_id INT," +
                "FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id))");
            
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS VENDOR (" +
                "vendor_id INT AUTO_INCREMENT PRIMARY KEY," +
                "vendor_name VARCHAR(100)," +
                "contact VARCHAR(50))");
            
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS MATERIAL (" +
                "material_id INT AUTO_INCREMENT PRIMARY KEY," +
                "material_name VARCHAR(100) NOT NULL," +
                "unit VARCHAR(20))");
            
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS GATE_PASS (" +
                "pass_id INT AUTO_INCREMENT PRIMARY KEY," +
                "pass_type ENUM('RETURNABLE','NON_RETURNABLE') NOT NULL," +
                "status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING'," +
                "created_by INT," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            stmt.executeUpdate("INSERT IGNORE INTO DEPARTMENT (dept_name) VALUES ('Admin')");
            stmt.executeUpdate("INSERT IGNORE INTO users (email_id, name, password, role, dept_id) " +
                "VALUES ('admin@company.com', 'Admin', 'admin123', 'ADMIN', 1)");
                
            System.out.println("Database initialized!");
        } catch (SQLException e) {
            System.out.println("DB Init error: " + e.getMessage());
        }
    }
}