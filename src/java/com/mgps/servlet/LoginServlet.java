
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

                if (role.equals("Admin")) {
                    response.sendRedirect("admin/dashboard.jsp");
                } else if (role.equals("Employee")) {
                    response.sendRedirect("employee/dashboard.jsp");
                } else if (role.equals("Security")) {
                    response.sendRedirect("security/dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}