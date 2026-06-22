package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MaterialOutServlet")
public class MaterialOutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String cgp_no = request.getParameter("cgp_no");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO tracking (cgp_no,out_date) VALUES (?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(cgp_no));
            ps.setString(2, LocalDate.now().toString());
            ps.executeUpdate();
            con.close();

            response.sendRedirect(request.getContextPath() + "/security/materialOut.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/security/materialOut.jsp");
        }
    }
}