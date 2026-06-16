<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mgps.util.DBConnection"%>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("Security")){
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Material Out</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header { background-color: #e67e22; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .back { background: white; color: #e67e22; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .container { padding: 30px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th { background: #e67e22; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f9f9f9; }
        .out-btn { background: #e67e22; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        h3 { color: #e67e22; }
    </style>
</head>
<body>
    <div class="header">
        <h2>📤 Material Out</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>
    <div class="container">
        <h3>✅ Approved Gate Passes - Ready for Material Out</h3>
        <table>
            <tr>
                <th>CGP No</th>
                <th>Material</th>
                <th>Quantity</th>
                <th>Employee</th>
                <th>Department</th>
                <th>Purpose</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
<%
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT g.* FROM gate_pass g LEFT JOIN tracking t ON g.cgp_no = t.cgp_no WHERE g.status='Approved' AND t.cgp_no IS NULL";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
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
                <td><a href="../MaterialOutServlet?cgp_no=<%=cgpNo%>" class="out-btn">📤 Mark Out</a></td>
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