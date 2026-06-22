package com.mgps.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

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

        String url = "jdbc:mysql://" 
                + host + ":" + port + "/" + name
                + "?useSSL=false&serverTimezone=UTC";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }
}