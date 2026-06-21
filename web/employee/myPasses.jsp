<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mgps.util.DBConnection"%>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("Employee")){
        response.sendRedirect("../login.jsp");
        return;
    }
    String name = (String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Gate Passes</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header { background-color: #27ae60; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .back { background: white; color: #27ae60; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .container { padding: 30px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th { background: #27ae60; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f9f9f9; }
        .pending { background:#f39c12; color:white; padding:3px 8px; border-radius:4px; font-size:12px; }
        .approved { background:#27ae60; color:white; padding:3px 8px; border-radius:4px; font-size:12px; }
        .rejected { background:#e74c3c; color:white; padding:3px 8px; border-radius:4px; font-size:12px; }
        h3 { color: #27ae60; }
        .gp-no { font-weight: bold; color: #2c3e50; font-size: 14px; }
        .returnable { background: #3498db; color:white; padding:3px 8px; border-radius:4px; font-size:11px; }
        .non-returnable { background: #e67e22; color:white; padding:3px 8px; border-radius:4px; font-size:11px; }
    </style>
</head>
<body>
    <div class="header">
        <h2>📋 My Gate Passes</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>
    <div class="container">
        <h3>Your Gate Pass Requests</h3>
        <table>
            <tr>
                <th>Gate Pass No</th>
                <th>Type</th>
                <th>Material</th>
                <th>Quantity</th>
                <th>Department</th>
                <th>Purpose</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
<%
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM gate_pass WHERE employee_name=? ORDER BY cgp_no DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        boolean found = false;
        while(rs.next()){
            found = true;
            String status = rs.getString("status");
            String gpNo = rs.getString("gate_pass_no");
            if(gpNo == null) gpNo = "GP-" + rs.getInt("cgp_no");
            String gpType = "";
            try { gpType = rs.getString("gp_type"); } catch(Exception ex){ gpType = "Returnable"; }
            if(gpType == null) gpType = "Returnable";
%>
            <tr>
                <td class="gp-no"><%=gpNo%></td>
                <td>
                    <% if(gpType.equals("Returnable")){ %>
                    <span class="returnable">🔄 Returnable</span>
                    <% } else { %>
                    <span class="non-returnable">📦 Non-Returnable</span>
                    <% } %>
                </td>
                <td><%=rs.getString("material_name")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td><%=rs.getString("department")%></td>
                <td><%=rs.getString("purpose")%></td>
                <td><%=rs.getString("date")%></td>
                <td><span class="<%=status.toLowerCase()%>"><%=status%></span></td>
            </tr>
<%
        }
        if(!found){
%>
            <tr>
                <td colspan="8" style="text-align:center; padding:20px; color:#999;">
                    No gate passes found. Create your first gate pass!
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