<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("Admin")){
        response.sendRedirect("../login.jsp");
        return;
    }
    String name = (String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
        .logout {
            background: #e74c3c;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
        }
        .container { padding: 30px; }
        .welcome {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }
        .card:hover { transform: translateY(-5px); }
        .card .icon { font-size: 40px; }
        .card h3 { margin: 10px 0 0 0; }
        .card1 { border-top: 4px solid #3498db; }
        .card2 { border-top: 4px solid #2ecc71; }
        .card3 { border-top: 4px solid #e74c3c; }
    </style>
</head>
<body>
    <div class="header">
        <h2>🏭 Material Gate Pass System</h2>
        <a href="../LogoutServlet" class="logout">Logout</a>
    </div>

    <div class="container">
        <div class="welcome">
            <h3>Welcome, <%= name %>! 👋</h3>
            <p>You are logged in as <b>Admin</b></p>
        </div>

        <div class="cards">
            <a href="approveCGP.jsp" class="card card1">
                <div class="icon">✅</div>
                <h3>Approve Gate Pass</h3>
            </a>
            <a href="reports.jsp" class="card card2">
                <div class="icon">📊</div>
                <h3>View Reports</h3>
            </a>
            <a href="createUser.jsp" class="card card3">
                <div class="icon">👤</div>
                <h3>Create User</h3>
            </a>
        </div>
    </div>
</body>
</html>