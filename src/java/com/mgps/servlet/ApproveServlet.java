package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/ApproveServlet")
public class ApproveServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String cgp_no = request.getParameter("cgp_no");
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        String approvedBy = (String)session.getAttribute("name");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE gate_pass SET status=? WHERE cgp_no=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, action);
            ps.setInt(2, Integer.parseInt(cgp_no));
            ps.executeUpdate();

            String sql2 = "INSERT INTO approvals "
                        + "(cgp_no, approved_by, approval_status) "
                        + "VALUES (?,?,?)";
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setInt(1, Integer.parseInt(cgp_no));
            ps2.setString(2, approvedBy);
            ps2.setString(3, action);
            ps2.executeUpdate();

            con.close();

            response.sendRedirect(
                request.getContextPath() + 
                "/admin/approveCGP.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                request.getContextPath() + 
                "/admin/approveCGP.jsp");
        }
    }
}