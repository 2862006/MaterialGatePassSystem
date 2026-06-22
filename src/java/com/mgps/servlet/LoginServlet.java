package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
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
                String ctx = request.getContextPath();
                if (role.equals("Admin")) {
                    response.sendRedirect(ctx + "/admin/dashboard.jsp");
                } else if (role.equals("Employee")) {
                    response.sendRedirect(ctx + "/employee/dashboard.jsp");
                } else if (role.equals("Security")) {
                    response.sendRedirect(ctx + "/security/dashboard.jsp");
                } else {
                    response.sendRedirect(ctx + "/login.jsp?error=1");
                }
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=1");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=1");
        }
    }
}