package com.mgps.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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
}