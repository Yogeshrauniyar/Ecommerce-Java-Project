<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - ElectroLoot</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #000428, #004e92);
            font-family: "Poppins", sans-serif;
            color: white;
        }
        .container {
            max-width: 400px;
            margin: 80px auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            backdrop-filter: blur(10px);
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.3);
        }
        .btn-custom {
            background-color: #00c6ff;
            color: white;
            font-weight: 600;
        }
        .btn-custom:hover {
            background-color: #0072ff;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: white;
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Your Password</h2>
        <p>Enter your registered email to receive a password reset link.</p>
        <form action="sendResetLink" method="post">
            <input type="email" class="form-control mb-3" name="email" placeholder="Enter your email" required>
            <button type="submit" class="btn btn-custom w-100">Send Reset Link</button>
        </form>
        <p class="mt-3"><a href="login.jsp" style="color: #00c6ff;">Back to Login</a></p>
    </div>
</body>
</html>
