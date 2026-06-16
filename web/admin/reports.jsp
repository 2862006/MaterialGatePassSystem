<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mgps.util.DBConnection"%>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("Admin")){
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h2 { margin: 0; }
        .back {
            background: white;
            color: #2c3e50;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .container { padding: 30px; }
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .stat-card {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            min-width: 150px;
        }
        .stat-card h1 { margin: 0; font-size: 40px; }
        .stat-card p { margin: 5px 0 0 0; color: #666; }
        .s1 { border-top: 4px solid #3498db; }
        .s2 { border-top: 4px solid #f39c12; }
        .s3 { border-top: 4px solid #27ae60; }
        .s4 { border-top: 4px solid #e74c3c; }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        th {
            background: #2c3e50;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f9f9f9; }
        .pending { background:#f39c12; color:white;
                   padding:3px 8px; border-radius:4px; }
        .approved { background:#27ae60; color:white;
                    padding:3px 8px; border-radius:4px; }
        .rejected { background:#e74c3c; color:white;
                    padding:3px 8px; border-radius:4px; }
        h3 { color: #2c3e50; }
    </style>
</head>
<body>
    <div class="header">
        <h2>📊 Reports</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>

    <div class="container">
<%
    try {
        Connection con = DBConnection.getConnection();

        // Count all passes
        ResultSet rs1 = con.prepareStatement(
            "SELECT COUNT(*) FROM gate_pass").executeQuery();
        rs1.next();
        int total = rs1.getInt(1);

        // Count pending
        PreparedStatement ps2 = con.prepareStatement(
            "SELECT COUNT(*) FROM gate_pass WHERE status=?");
        ps2.setString(1, "Pending");
        ResultSet rs2 = ps2.executeQuery();
        rs2.next();
        int pending = rs2.getInt(1);

        // Count approved
        PreparedStatement ps3 = con.prepareStatement(
            "SELECT COUNT(*) FROM gate_pass WHERE status=?");
        ps3.setString(1, "Approved");
        ResultSet rs3 = ps3.executeQuery();
        rs3.next();
        int approved = rs3.getInt(1);

        // Count rejected
        PreparedStatement ps4 = con.prepareStatement(
            "SELECT COUNT(*) FROM gate_pass WHERE status=?");
        ps4.setString(1, "Rejected");
        ResultSet rs4 = ps4.executeQuery();
        rs4.next();
        int rejected = rs4.getInt(1);
%>
        <div class="stats">
            <div class="stat-card s1">
                <h1><%= total %></h1>
                <p>Total Passes</p>
            </div>
            <div class="stat-card s2">
                <h1><%= pending %></h1>
                <p>Pending</p>
            </div>
            <div class="stat-card s3">
                <h1><%= approved %></h1>
                <p>Approved</p>
            </div>
            <div class="stat-card s4">
                <h1><%= rejected %></h1>
                <p>Rejected</p>
            </div>
        </div>

        <h3>📋 All Gate Pass Records</h3>
        <table>
            <tr>
                <th>CGP No</th>
                <th>Material</th>
                <th>Qty</th>
                <th>Employee</th>
                <th>Department</th>
                <th>Purpose</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
<%
        ResultSet rs = con.prepareStatement(
            "SELECT * FROM gate_pass ORDER BY cgp_no DESC")
            .executeQuery();
        while(rs.next()){
            String status = rs.getString("status");
%>
            <tr>
                <td><%= rs.getInt("cgp_no") %></td>
                <td><%= rs.getString("material_name") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getString("employee_name") %></td>
                <td><%= rs.getString("department") %></td>
                <td><%= rs.getString("purpose") %></td>
                <td><%= rs.getString("date") %></td>
                <td>
                    <span class="<%= status.toLowerCase() %>">
                        <%= status %>
                    </span>
                </td>
            </tr>
<%
        }
        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
        </table>
    </div>
</body>
</html>