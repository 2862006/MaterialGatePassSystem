package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            DBConnection.initDatabase();
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE email_id=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                String name = rs.getString("name");
                HttpSession session = request.getSession();
                session.setAttribute("role", role);
                session.setAttribute("name", name);
                session.setAttribute("email", email);

                if (role.equals("ADMIN")) {
                    request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
                } else if (role.equals("EMPLOYEE")) {
                    request.getRequestDispatcher("/employee/dashboard.jsp").forward(request, response);
                } else if (role.equals("SECURITY")) {
                    request.getRequestDispatcher("/security/dashboard.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("/login.jsp?error=1").forward(request, response);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/login.jsp?error=1").forward(request, response);
        }
    }
}