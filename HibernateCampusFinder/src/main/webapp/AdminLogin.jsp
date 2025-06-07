<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Finder - Admin Portal</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            padding: 2rem;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 500px;
            width: 100%;
            animation: slideInUp 0.6s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .success-container h1 {
            color: #28a745;
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .error-container h1 {
            color: #dc3545;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .admin-controls {
            background: rgba(102, 126, 234, 0.05);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .admin-controls p {
            font-weight: 600;
            color: #333;
            margin-bottom: 1.5rem;
        }

        ul {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        ul li a {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
        }

        ul li a:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            background: linear-gradient(135deg, #5a67d8, #6b46c1);
        }

        .error-container ul li a {
            background: linear-gradient(135deg, #dc3545, #c82333);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);
        }

        .error-container ul li a:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
        }

        .home-link {
            background: linear-gradient(135deg, #28a745, #20c997) !important;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2) !important;
        }

        .home-link:hover {
            background: linear-gradient(135deg, #218838, #1e7e34) !important;
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3) !important;
        }

        .success-icon {
            font-size: 3rem;
            color: #28a745;
            margin-bottom: 1rem;
        }

        .error-icon {
            font-size: 3rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem;
                margin: 1rem;
            }

            .success-container h1,
            .error-container h1 {
                font-size: 1.8rem;
            }

            ul li a {
                padding: 0.8rem 1rem;
                font-size: 0.9rem;
            }
        }

        /* Admin badge */
        .admin-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%
String username, password;

username = request.getParameter("username");
password = request.getParameter("password");

if(username.equals("rahul") && password.equals("rahul@123")){
%>

<div class="container success-container">
    <div class="logo">🔍 Campus Finder</div>
    <div class="success-icon">✅</div>
    <h1>Welcome, Admin</h1>
    <div class="admin-badge">Administrator Portal</div>
    
    <div class="admin-controls">
        <p>You have the following controls:</p>
        <ul>
            <li><a href="lost-items.jsp">📋 View Lost Items</a></li>
            <li><a href="found-items.jsp">👁️ View Found Items</a></li>
            <li><a href="delete-item.html">🗑️ Delete Item Entry</a></li>
            <li><a href="index.jsp" class="home-link">🏠 Back to Home</a></li>
        </ul>
    </div>
</div>

<% } else { %>

<div class="container error-container">
    <div class="logo">🔍 Campus Finder</div>
    <div class="error-icon">❌</div>
    <h1>Admin Login Failed</h1>
    
    <p>Incorrect username or password. Please try again.</p>
    
    <ul>
        <li><a href="login.html">🔐 Back to Login Page</a></li>
        <li><a href="index.jsp" class="home-link">🏠 Back to Home</a></li>
    </ul>
</div>

<% } %>

</body>
</html>