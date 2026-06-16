<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Create User</title>
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
        .container {
            padding: 30px;
            max-width: 500px;
            margin: auto;
        }
        .form-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-box h3 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
        }
        label {
            display: block;
            margin: 15px 0 5px 0;
            font-weight: bold;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        button:hover { background: #1a252f; }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>👤 Create New User</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>

    <div class="container">
        <div class="form-box">
            <h3>Add New User</h3>

            <% if(request.getParameter("success") != null){ %>
                <div class="success">✅ User Created Successfully!</div>
            <% } %>

            <form action="../CreateUserServlet" method="post">
                <label>Full Name:</label>
                <input type="text" name="name"
                       placeholder="Enter full name" required/>

                <label>Email ID:</label>
                <input type="email" name="email_id"
                       placeholder="Enter email" required/>

                <label>Mobile Number:</label>
                <input type="text" name="mobile_number"
                       placeholder="Enter mobile number"/>

                <label>Role:</label>
                <select name="role" required>
                    <option value="">Select Role</option>
                    <option value="Admin">Admin</option>
                    <option value="Employee">Employee</option>
                    <option value="Security">Security</option>
                </select>

                <label>Password:</label>
                <input type="password" name="password"
                       placeholder="Enter password" required/>

                <button type="submit">Create User 👤</button>
            </form>
        </div>
    </div>
</body>
</html>