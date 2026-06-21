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
    <title>Material Return</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header { background-color: #27ae60; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .back { background: white; color: #27ae60; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .container { padding: 30px; }
        .section-title { color: #27ae60; margin: 20px 0 10px 0; font-size: 18px; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        th { background: #27ae60; color: white; padding: 12px; text-align: left; font-size: 13px; }
        td { padding: 10px 12px; border-bottom: 1px solid #eee; font-size: 13px; }
        tr:hover { background: #f9f9f9; }
        .return-btn { background: #27ae60; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 12px; }
        .gp-no { font-weight: bold; color: #2c3e50; }
        .empty { text-align:center; padding:20px; color:#999; }
        .overdue { color: #e74c3c; font-weight: bold; }
        .normal { color: #27ae60; }
    </style>
    <script>
        function checkOverdue(expDate) {
            if(expDate == '-' || expDate == '') return '';
            var today = new Date();
            var exp = new Date(expDate);
            if(today > exp) return 'overdue';
            return 'normal';
        }
    </script>
</head>
<body>
    <div class="header">
        <h2>📥 Material Return</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>
    <div class="container">

        <!-- RETURNABLE PENDING RETURN -->
        <h3 class="section-title">🔄 Returnable - Pending Return</h3>
        <table>
            <tr>
                <th>Gate Pass No</th>
                <th>Material</th>
                <th>Qty</th>
                <th>Employee</th>
                <th>Department</th>
                <th>Out Date</th>
                <th>Expected Return</th>
                <th>Vehicle No</th>
                <th>Agency</th>
                <th>Action</th>
            </tr>
<%
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT g.*, t.tracking_id, t.out_date FROM gate_pass g JOIN tracking t ON g.cgp_no = t.cgp_no WHERE t.return_date IS NULL AND g.gp_type='Returnable'";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        boolean found = false;
        while(rs.next()){
            found = true;
            int trackingId = rs.getInt("tracking_id");
            String gpNo = "";
            try { gpNo = rs.getString("gate_pass_no"); } catch(Exception ex){}
            if(gpNo == null || gpNo.equals("")) gpNo = "GP-" + rs.getInt("cgp_no");
            String expDate = "";
            try { expDate = rs.getString("expected_return_date"); } catch(Exception ex){}
            if(expDate == null) expDate = "-";
            String vNo = "";
            try { vNo = rs.getString("vehicle_no"); } catch(Exception ex){}
            if(vNo == null) vNo = "-";
            String agName = "";
            try { agName = rs.getString("agency_name"); } catch(Exception ex){}
            if(agName == null) agName = "-";
%>
            <tr>
                <td class="gp-no"><%=gpNo%></td>
                <td><%=rs.getString("material_name")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td><%=rs.getString("employee_name")%></td>
                <td><%=rs.getString("department")%></td>
                <td><%=rs.getString("out_date")%></td>
                <td><b style="color:#e74c3c;"><%=expDate%></b></td>
                <td><%=vNo%></td>
                <td><%=agName%></td>
                <td><a href="<%=request.getContextPath()%>/MaterialReturnServlet?tracking_id=<%=trackingId%>" class="return-btn">📥 Mark Return</a></td>
            </tr>
<%
        }
        if(!found){
%>
            <tr><td colspan="10" class="empty">No returnable materials pending return!</td></tr>
<%
        }
        con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
        </table>

        <!-- NON RETURNABLE COMPLETED -->
        <h3 class="section-title">📦 Non Returnable - Material Out Records</h3>
        <table>
            <tr>
                <th>Gate Pass No</th>
                <th>Material</th>
                <th>Qty</th>
                <th>Employee</th>
                <th>Department</th>
                <th>Purpose</th>
                <th>Out Date</th>
                <th>Vehicle No</th>
                <th>Agency Name</th>
                <th>Agency Phone</th>
                <th>Address</th>
                <th>Status</th>
            </tr>
<%
    try {
        Connection con3 = DBConnection.getConnection();
        String sql3 = "SELECT g.*, t.tracking_id, t.out_date FROM gate_pass g JOIN tracking t ON g.cgp_no = t.cgp_no WHERE g.gp_type='Non-Returnable'";
        PreparedStatement ps3 = con3.prepareStatement(sql3);
        ResultSet rs3 = ps3.executeQuery();
        boolean found3 = false;
        while(rs3.next()){
            found3 = true;
            String gpNo = "";
            try { gpNo = rs3.getString("gate_pass_no"); } catch(Exception ex){}
            if(gpNo == null || gpNo.equals("")) gpNo = "GP-" + rs3.getInt("cgp_no");
            String vNo = "";
            try { vNo = rs3.getString("vehicle_no"); } catch(Exception ex){}
            if(vNo == null) vNo = "-";
            String agName = "";
            try { agName = rs3.getString("agency_name"); } catch(Exception ex){}
            if(agName == null) agName = "-";
            String agPhone = "";
            try { agPhone = rs3.getString("agency_phone"); } catch(Exception ex){}
            if(agPhone == null) agPhone = "-";
            String addr = "";
            try { addr = rs3.getString("address"); } catch(Exception ex){}
            if(addr == null) addr = "-";
%>
            <tr>
                <td class="gp-no"><%=gpNo%></td>
                <td><%=rs3.getString("material_name")%></td>
                <td><%=rs3.getInt("quantity")%></td>
                <td><%=rs3.getString("employee_name")%></td>
                <td><%=rs3.getString("department")%></td>
                <td><%=rs3.getString("purpose")%></td>
                <td><%=rs3.getString("out_date")%></td>
                <td><%=vNo%></td>
                <td><%=agName%></td>
                <td><%=agPhone%></td>
                <td><%=addr%></td>
                <td><span style="background:#27ae60;color:white;padding:3px 8px;border-radius:4px;font-size:11px;">✅ Done</span></td>
            </tr>
<%
        }
        if(!found3){
%>
            <tr><td colspan="12" class="empty">No non-returnable records yet!</td></tr>
<%
        }
        con3.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
        </table>
    </div>
</body>
</html>