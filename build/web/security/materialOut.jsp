<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.mgps.util.DBConnection"%>
<%
String role = (String)session.getAttribute("role");
if(role == null || !role.equals("Security")){
    response.sendRedirect("../login.jsp");
    return;
}
Connection con = DBConnection.getConnection();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Material Out</title>
    <style>
        body{font-family:Arial;margin:0;background:#f0f2f5;}
        .header{background:#e67e22;color:white;padding:15px 30px;display:flex;justify-content:space-between;align-items:center;}
        .header h2{margin:0;}
        .back{background:white;color:#e67e22;padding:8px 15px;text-decoration:none;border-radius:5px;font-weight:bold;}
        .container{padding:20px;}
        .sec{font-size:16px;font-weight:bold;margin:15px 0 8px 0;padding:8px 12px;border-radius:5px;}
        .sec-r{background:#ebf5fb;color:#2980b9;border-left:4px solid #2980b9;}
        .sec-nr{background:#fef9e7;color:#e67e22;border-left:4px solid #e67e22;}
        table{width:100%;border-collapse:collapse;background:white;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.1);margin-bottom:25px;}
        th{background:#e67e22;color:white;padding:10px;text-align:left;font-size:12px;}
        td{padding:9px 10px;border-bottom:1px solid #eee;font-size:12px;}
        tr:hover{background:#fef5e7;}
        .btn{background:#e67e22;color:white;padding:5px 10px;text-decoration:none;border-radius:4px;font-size:11px;}
        .btn:hover{background:#d35400;}
        .gpno{font-weight:bold;color:#2c3e50;}
        .empty{text-align:center;padding:15px;color:#999;font-style:italic;}
        .red{color:#e74c3c;font-weight:bold;}
    </style>
</head>
<body>
<div class="header">
    <h2>📤 Material Out</h2>
    <a href="dashboard.jsp" class="back">← Back</a>
</div>
<div class="container">

<div class="sec sec-r">🔄 Returnable Gate Passes</div>
<table>
<tr>
    <th>Gate Pass No</th>
    <th>Material</th>
    <th>Qty</th>
    <th>Employee</th>
    <th>Department</th>
    <th>Purpose</th>
    <th>Date</th>
    <th>Expected Return</th>
    <th>Vehicle No</th>
    <th>Agency</th>
    <th>Action</th>
</tr>
<%
try {
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT g.* FROM gate_pass g LEFT JOIN tracking t ON g.cgp_no=t.cgp_no " +
        "WHERE g.status='Approved' AND g.gp_type='Returnable' AND t.cgp_no IS NULL");
    ResultSet rs1 = ps1.executeQuery();
    boolean f1 = false;
    while(rs1.next()){
        f1 = true;
        int cno = rs1.getInt("cgp_no");
        String gno = rs1.getString("gate_pass_no");
        if(gno==null||gno.trim().isEmpty()) gno="GP-"+cno;
        String exp=""; try{exp=rs1.getString("expected_return_date");}catch(Exception e){}
        if(exp==null||exp.isEmpty()) exp="-";
        String vno=""; try{vno=rs1.getString("vehicle_no");}catch(Exception e){}
        if(vno==null||vno.isEmpty()) vno="-";
        String ag=""; try{ag=rs1.getString("agency_name");}catch(Exception e){}
        if(ag==null||ag.isEmpty()) ag="-";
%>
<tr>
    <td class="gpno"><%=gno%></td>
    <td><%=rs1.getString("material_name")%></td>
    <td><%=rs1.getInt("quantity")%></td>
    <td><%=rs1.getString("employee_name")%></td>
    <td><%=rs1.getString("department")%></td>
    <td><%=rs1.getString("purpose")%></td>
    <td><%=rs1.getString("date")%></td>
    <td class="red"><%=exp%></td>
    <td><%=vno%></td>
    <td><%=ag%></td>
    <td><a href="<%=request.getContextPath()%>/MaterialOutServlet?cgp_no=<%=cno%>" class="btn">📤 Mark Out</a></td>
</tr>
<%
    }
    if(!f1){%><tr><td colspan="11" class="empty">No returnable passes pending!</td></tr><%}
} catch(Exception e){ out.println("Error: "+e.getMessage()); }
%>
</table>

<div class="sec sec-nr">📦 Non-Returnable Gate Passes</div>
<table>
<tr>
    <th>Gate Pass No</th>
    <th>Material</th>
    <th>Qty</th>
    <th>Employee</th>
    <th>Department</th>
    <th>Purpose</th>
    <th>Date</th>
    <th>Time</th>
    <th>Vehicle No</th>
    <th>Agency Name</th>
    <th>Agency Phone</th>
    <th>Address</th>
    <th>Action</th>
</tr>
<%
try {
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT g.* FROM gate_pass g LEFT JOIN tracking t ON g.cgp_no=t.cgp_no " +
        "WHERE g.status='Approved' AND g.gp_type='Non-Returnable' AND t.cgp_no IS NULL");
    ResultSet rs2 = ps2.executeQuery();
    boolean f2 = false;
    while(rs2.next()){
        f2 = true;
        int cno = rs2.getInt("cgp_no");
        String gno = rs2.getString("gate_pass_no");
        if(gno==null||gno.trim().isEmpty()) gno="GP-"+cno;
        String vno=""; try{vno=rs2.getString("vehicle_no");}catch(Exception e){}
        if(vno==null||vno.isEmpty()) vno="-";
        String ag=""; try{ag=rs2.getString("agency_name");}catch(Exception e){}
        if(ag==null||ag.isEmpty()) ag="-";
        String ph=""; try{ph=rs2.getString("agency_phone");}catch(Exception e){}
        if(ph==null||ph.isEmpty()) ph="-";
        String addr=""; try{addr=rs2.getString("address");}catch(Exception e){}
        if(addr==null||addr.isEmpty()) addr="-";
        String tim=""; try{tim=rs2.getString("time");}catch(Exception e){}
        if(tim==null) tim="-";
%>
<tr>
    <td class="gpno"><%=gno%></td>
    <td><%=rs2.getString("material_name")%></td>
    <td><%=rs2.getInt("quantity")%></td>
    <td><%=rs2.getString("employee_name")%></td>
    <td><%=rs2.getString("department")%></td>
    <td><%=rs2.getString("purpose")%></td>
    <td><%=rs2.getString("date")%></td>
    <td><%=tim%></td>
    <td><%=vno%></td>
    <td><%=ag%></td>
    <td><%=ph%></td>
    <td><%=addr%></td>
    <td><a href="<%=request.getContextPath()%>/MaterialOutServlet?cgp_no=<%=cno%>" class="btn">📤 Mark Out</a></td>
</tr>
<%
    }
    if(!f2){%><tr><td colspan="13" class="empty">No non-returnable passes pending!</td></tr><%}
} catch(Exception e){ out.println("Error: "+e.getMessage()); }
%>
</table>

</div>
</body>
</html>
<%
try{ if(con!=null) con.close(); } catch(Exception e){}
%>