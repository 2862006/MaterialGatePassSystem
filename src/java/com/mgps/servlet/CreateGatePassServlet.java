package com.mgps.servlet;

import com.mgps.util.DBConnection;
import java.io.*;
import java.sql.*;
import java.time.Year;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/CreateGatePassServlet")
public class CreateGatePassServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String gp_type = request.getParameter("gp_type");
        String material_name, quantity, employee_name,
               department, purpose, date, time,
               vehicle_no, agency_name, agency_phone,
               address, expected_return_date;

        if(gp_type != null && gp_type.equals("Returnable")) {
            material_name = request.getParameter("material_name");
            quantity = request.getParameter("quantity");
            employee_name = request.getParameter("employee_name");
            department = request.getParameter("department");
            purpose = request.getParameter("purpose");
            date = request.getParameter("date");
            time = request.getParameter("time");
            expected_return_date = request.getParameter("expected_return_date");
            vehicle_no = request.getParameter("vehicle_no");
            agency_name = request.getParameter("agency_name");
            agency_phone = request.getParameter("agency_phone");
            address = request.getParameter("address");
        } else {
            material_name = request.getParameter("nr_material_name");
            quantity = request.getParameter("nr_quantity");
            employee_name = request.getParameter("nr_employee_name");
            department = request.getParameter("nr_department");
            purpose = request.getParameter("nr_purpose");
            date = request.getParameter("nr_date");
            time = request.getParameter("nr_time");
            expected_return_date = null;
            vehicle_no = request.getParameter("nr_vehicle_no");
            agency_name = request.getParameter("nr_agency_name");
            agency_phone = request.getParameter("nr_agency_phone");
            address = request.getParameter("nr_address");
        }

        try {
            Connection con = DBConnection.getConnection();

            // Generate Gate Pass Number like 2026000001
            String yearSql = "SELECT COUNT(*) FROM gate_pass";
            PreparedStatement yearPs = con.prepareStatement(yearSql);
            ResultSet yearRs = yearPs.executeQuery();
            yearRs.next();
            int count = yearRs.getInt(1) + 1;
            String year = String.valueOf(Year.now().getValue());
            String gatePassNo = year + String.format("%06d", count);

            String sql = "INSERT INTO gate_pass "
                + "(gate_pass_no, gp_type, material_name, quantity, "
                + "employee_name, department, purpose, date, time, "
                + "expected_return_date, vehicle_no, agency_name, "
                + "agency_phone, address, status) "
                + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Pending')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, gatePassNo);
            ps.setString(2, gp_type);
            ps.setString(3, material_name);
            ps.setInt(4, Integer.parseInt(quantity));
            ps.setString(5, employee_name);
            ps.setString(6, department);
            ps.setString(7, purpose);
            ps.setString(8, date);
            ps.setString(9, time);
            ps.setString(10, expected_return_date);
            ps.setString(11, vehicle_no);
            ps.setString(12, agency_name);
            ps.setString(13, agency_phone);
            ps.setString(14, address);
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