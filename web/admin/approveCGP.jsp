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
    <title>Approve Gate Pass</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header { background-color: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .back { background: white; color: #2c3e50; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .container { padding: 30px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th { background: #2c3e50; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f9f9f9; }
        .approve-btn { background: #27ae60; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .reject-btn { background: #e74c3c; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .pending { background: #f39c12; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .approved { background: #27ae60; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        .rejected { background: #e74c3c; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; }
        h3 { color: #2c3e50; }
    </style>
</head>
<body>
    <div class="header">
        <h2>✅ Approve Gate Pass</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>
    <div class="container">
        <h3>📋 All Gate Pass Requests</h3>
        <table>
            <tr>
                <th>CGP No</th>
                <th>Material</th>
                <th>Quantity</th>
                <th>Employee</th>
                <th>Department</th>
                <th>Purpose</th>
                <th>Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
<%
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM gate_pass ORDER BY cgp_no DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            String status = rs.getString("status");
            int cgpNo = rs.getInt("cgp_no");
%>
            <tr>
                <td><%=cgpNo%></td>
                <td><%=rs.getString("material_name")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td><%=rs.getString("employee_name")%></td>
                <td><%=rs.getString("department")%></td>
                <td><%=rs.getString("purpose")%></td>
                <td><%=rs.getString("date")%></td>
                <td><span class="<%=status.toLowerCase()%>"><%=status%></span></td>
                <td>
                <%if(status.equals("Pending")){%>
                <a href="../ApproveServlet?cgp_no=<%=cgpNo%>&action=Approved" class="approve-btn">✅ Approve</a>
                &nbsp;
                <a href="../ApproveServlet?cgp_no=<%=cgpNo%>&action=Rejected" class="reject-btn">❌ Reject</a>
                <%}else{%>
                <b><%=status%></b>
                <%}%>
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