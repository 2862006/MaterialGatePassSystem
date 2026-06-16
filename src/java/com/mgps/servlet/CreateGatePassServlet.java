package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/CreateGatePassServlet")
public class CreateGatePassServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String material_name = request.getParameter("material_name");
        String quantity = request.getParameter("quantity");
        String employee_name = request.getParameter("employee_name");
        String department = request.getParameter("department");
        String purpose = request.getParameter("purpose");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO gate_pass "
                + "(material_name,quantity,employee_name,"
                + "department,purpose,date,time,status) "
                + "VALUES (?,?,?,?,?,?,?,'Pending')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, material_name);
            ps.setInt(2, Integer.parseInt(quantity));
            ps.setString(3, employee_name);
            ps.setString(4, department);
            ps.setString(5, purpose);
            ps.setString(6, date);
            ps.setString(7, time);
            ps.executeUpdate();
            con.close();
            response.sendRedirect(
                "employee/createGatePass.jsp?success=1");
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                "employee/createGatePass.jsp?error=1");
        }
    }
}