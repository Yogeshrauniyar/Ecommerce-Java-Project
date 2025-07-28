<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ElectroLoot</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

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
        .card {
            background: #e4ebf5;
            width: 400px;
            padding: 40px 30px;
            border-radius: 25px;
            box-shadow: 12px 12px 20px rgba(0,0,0,0.05), -8px -8px 16px rgba(255,255,255,0.7);
            text-align: center;
        }
        h2 {
            margin-bottom: 30px;
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }
        .input-field, .btn {
            background: #e4ebf5;
            border-radius: 50px;
            padding: 16px;
            margin: 12px 0;
            box-shadow: inset 4px 4px 8px rgba(0,0,0,0.05), inset -4px -4px 8px rgba(255,255,255,0.8);
            border: none;
            width: 100%;
            outline: none;
            font-size: 15px;
            color: #555;
            transition: all 0.3s ease;
        }
        .input-field:focus {
            box-shadow: inset 2px 2px 4px rgba(0,0,0,0.1), inset -2px -2px 4px rgba(255,255,255,0.8);
        }
        .btn {
            background: linear-gradient(135deg, #4a90e2, #357ab8);
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .error {
            color: red;
            font-size: 12px;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Register</h2>
        <form id="registerForm" action="register" method="post" onsubmit="return validateForm()">
            <input type="text" class="input-field" id="name" name="name" placeholder="Full Name" required>
            <div id="nameError" class="error"></div>

            <input type="email" class="input-field" id="email" name="email" placeholder="Email" required>
            <div id="emailError" class="error"></div>

            <input type="password" class="input-field" id="password" name="password" placeholder="Password" required>
            <div id="passwordError" class="error"></div>

            <button type="submit" class="btn">Register</button>
        </form>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
            document.getElementById("nameError").innerHTML = "";
            document.getElementById("emailError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";

            const name = document.getElementById("name").value.trim();
            const email = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();

            // ✅ Name Validation
            const nameRegex = /^[A-Za-z\s]+$/;
            if (!nameRegex.test(name)) {
                document.getElementById("nameError").innerHTML = "❗ Name should only contain alphabets and spaces.";
                isValid = false;
            }

            // ✅ Email Validation
            const emailRegex = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById("emailError").innerHTML = "❗ Invalid email format.";
                isValid = false;
            }

            // ✅ Password Validation
            if (password.length < 6) {
                document.getElementById("passwordError").innerHTML = "❗ Password must be at least 6 characters long.";
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>
