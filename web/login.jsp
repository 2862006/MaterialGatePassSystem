<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Material Gate Pass System - Login</title>
    <style>
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 5px;
        }
        p {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>🏭 Gate Pass System</h2>
        <p>Material Gate Pass Management</p>
        
       <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <input type="email" name="email" 
                   placeholder="Enter Email" required/>
            <input type="password" name="password" 
                   placeholder="Enter Password" required/>
            <button type="submit">Login</button>
        </form>
        
        <% if(request.getParameter("error") != null){ %>
            <p class="error">❌ Invalid Email or Password!</p>
        <% } %>
    </div>
</body>
</html>