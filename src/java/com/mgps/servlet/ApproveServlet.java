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

@WebServlet("/ApproveServlet")
public class ApproveServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String cgp_no = request.getParameter("cgp_no");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String approvedBy = (String) session.getAttribute("name");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE gate_pass SET status=? WHERE cgp_no=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, action);
            ps.setInt(2, Integer.parseInt(cgp_no));
            ps.executeUpdate();

            String checkSql = "SELECT * FROM approvals WHERE cgp_no=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, Integer.parseInt(cgp_no));
            ResultSet rs = checkPs.executeQuery();

            if (!rs.next()) {
                String sql2 = "INSERT INTO approvals (cgp_no,approved_by,approval_status) VALUES (?,?,?)";
                PreparedStatement ps2 = con.prepareStatement(sql2);
                ps2.setInt(1, Integer.parseInt(cgp_no));
                ps2.setString(2, approvedBy);
                ps2.setString(3, action);
                ps2.executeUpdate();
            } else {
                String sql3 = "UPDATE approvals SET approved_by=?,approval_status=? WHERE cgp_no=?";
                PreparedStatement ps3 = con.prepareStatement(sql3);
                ps3.setString(1, approvedBy);
                ps3.setString(2, action);
                ps3.setInt(3, Integer.parseInt(cgp_no));
                ps3.executeUpdate();
            }

            con.close();
            response.sendRedirect(request.getContextPath() + "/admin/approveCGP.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/approveCGP.jsp");
        }
    }
}