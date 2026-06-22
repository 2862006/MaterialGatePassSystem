<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Employee Dashboard</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header {
            background-color: #27ae60;
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
        .card1 { border-top: 4px solid #27ae60; }
        .card2 { border-top: 4px solid #3498db; }
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
            <p>You are logged in as <b>Employee</b></p>
        </div>
        <div class="cards">
            <a href="createGatePass.jsp" class="card card1">
                <div class="icon">📝</div>
                <h3>Create Gate Pass</h3>
            </a>
            <a href="myPasses.jsp" class="card card2">
                <div class="icon">📋</div>
                <h3>My Gate Passes</h3>
            </a>
        </div>
    </div>
</body>
</html>
