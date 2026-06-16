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
    <title>Create Gate Pass</title>
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
        .back {
            background: white;
            color: #27ae60;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .container {
            padding: 30px;
            max-width: 600px;
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
            color: #27ae60;
            border-bottom: 2px solid #27ae60;
            padding-bottom: 10px;
        }
        label {
            display: block;
            margin: 15px 0 5px 0;
            font-weight: bold;
            color: #555;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        textarea { height: 80px; }
        button {
            width: 100%;
            padding: 12px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        button:hover { background: #219a52; }
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
        <h2>📝 Create Gate Pass</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>

    <div class="container">
        <div class="form-box">
            <h3>📋 Gate Pass Request Form</h3>

            <% if(request.getParameter("success") != null){ %>
                <div class="success">
                    ✅ Gate Pass Created Successfully! 
                    Waiting for Admin Approval.
                </div>
            <% } %>

            <form action="../CreateGatePassServlet" method="post">
                <label>Material Name:</label>
                <input type="text" name="material_name" 
                       placeholder="Enter material name" required/>

                <label>Quantity:</label>
                <input type="number" name="quantity" 
                       placeholder="Enter quantity" required/>

                <label>Employee Name:</label>
                <input type="text" name="employee_name" 
       value="<%= name %>"/>

                <label>Department:</label>
                <select name="department" required>
                    <option value="">Select Department</option>
                    <option value="IT">IT</option>
                    <option value="HR">HR</option>
                    <option value="Finance">Finance</option>
                    <option value="Production">Production</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Store">Store</option>
                </select>

                <label>Purpose:</label>
                <textarea name="purpose" 
                          placeholder="Enter purpose of gate pass" 
                          required></textarea>

                <label>Date:</label>
                <input type="date" name="date" required/>

                <label>Time:</label>
                <input type="time" name="time" required/>

                <button type="submit">
                    Submit Gate Pass Request 🚀
                </button>
            </form>
        </div>
    </div>
</body>
</html>