package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email_id = request.getParameter("email_id");
        String mobile = request.getParameter("mobile_number");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users (name,email_id,mobile_number,role,password) VALUES (?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email_id);
            ps.setString(3, mobile);
            ps.setString(4, role);
            ps.setString(5, password);
            ps.executeUpdate();
            con.close();

            response.sendRedirect(request.getContextPath() + "/admin/createUser.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/createUser.jsp");
        }
    }
}