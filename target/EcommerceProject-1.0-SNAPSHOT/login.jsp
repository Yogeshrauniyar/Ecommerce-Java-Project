<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ElectroLoot</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        body {
            background: linear-gradient(135deg, #f2f4f8, #d9e2ec);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }
        .login-card {
            background: #e4ebf5;
            width: 400px;
            padding: 50px 40px;
            border-radius: 25px;
            box-shadow: 12px 12px 20px rgba(0,0,0,0.05), -8px -8px 16px rgba(255,255,255,0.7);
            text-align: center;
        }
        .input-field, .btn {
            background: #e4ebf5;
            border-radius: 50px;
            padding: 16px;
            margin: 15px 0;
            box-shadow: inset 4px 4px 8px rgba(0,0,0,0.05), inset -4px -4px 8px rgba(255,255,255,0.8);
            border: none;
            width: 100%;
            outline: none;
            font-size: 15px;
            color: #555;
        }
        .btn {
            background: linear-gradient(135deg, #4a90e2, #357ab8);
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .btn:hover {
            opacity: 0.95;
        }
        .forgot-pass {
            color: #4a90e2;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }
        .forgot-pass:hover {
            color: #357ab8;
        }
        h2 {
            margin-bottom: 25px;
            color: #333;
        }
        .error-msg {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Login to ElectroLoot</h2>
    
    <!-- Error Message Display -->
    <% if (request.getParameter("error") != null) { %>
        <p class="error-msg">
            <% 
                String error = request.getParameter("error");
                if ("invalid_credentials".equals(error)) { %>
                    Invalid Email or Password.
            <% } else if ("empty_fields".equals(error)) { %>
                    Please fill in all fields.
            <% } else if ("db_error".equals(error)) { %>
                    Database Error. Please try again later.
            <% } %>
        </p>
    <% } %>

    <!-- Correct Form Action -->
    <form action="login" method="post">
        <input type="email" class="input-field" name="email" placeholder="Email" required>
        <input type="password" class="input-field" name="password" placeholder="Password" required>
        
        <!-- Forgot Password Link -->
        <a href="forgotPassword.jsp" class="forgot-pass">Forgot Password?</a>
        
        <button type="submit" class="btn">LOGIN</button>
    </form>

    <p>Don't have an account? <a href="register.jsp" class="forgot-pass">Register</a></p>
</div>

</body>
</html>
