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

@WebServlet("/MaterialReturnServlet")
public class MaterialReturnServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String tracking_id = request.getParameter("tracking_id");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE tracking SET return_date=? WHERE tracking_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, LocalDate.now().toString());
            ps.setInt(2, Integer.parseInt(tracking_id));
            ps.executeUpdate();
            con.close();

            response.sendRedirect(request.getContextPath() + "/security/materialReturn.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/security/materialReturn.jsp");
        }
    }
}