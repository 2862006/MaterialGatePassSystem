package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/MaterialOutServlet")
public class MaterialOutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String cgp_no = request.getParameter("cgp_no");
        
        System.out.println("CGP No: " + cgp_no);

        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO tracking (cgp_no, out_date) VALUES (?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(cgp_no));
            ps.setString(2, LocalDate.now().toString());
            int rows = ps.executeUpdate();
            System.out.println("Rows inserted: " + rows);
            con.close();
            response.sendRedirect(
                request.getContextPath() + 
                "/security/materialOut.jsp");
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + 
                "/security/materialOut.jsp");
        }
    }
}