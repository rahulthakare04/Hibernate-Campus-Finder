<%@page import="org.hibernate.query.Query"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.rahul.entity.FoundItems"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.cfg.Configuration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Deletion Result - Campus Finder</title>
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
            font-size: 1.8rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .status-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            animation: bounce 1s ease-out;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-20px);
            }
            60% {
                transform: translateY(-10px);
            }
        }

        .success-container {
            color: #28a745;
        }

        .success-container .status-message {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            border: 2px solid #28a745;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            color: #155724;
            font-size: 1.2rem;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.1);
        }

        .error-container {
            color: #dc3545;
        }

        .error-container .status-message {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            border: 2px solid #dc3545;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            color: #721c24;
            font-size: 1.2rem;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.1);
        }

        .item-info {
            background: rgba(102, 126, 234, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            color: #333;
        }

        .item-info h3 {
            margin-bottom: 0.5rem;
            color: #667eea;
        }

        .item-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            background: rgba(255, 255, 255, 0.8);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            display: inline-block;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .action-buttons a {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 1.5rem;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .action-buttons a:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .home-btn {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .admin-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .delete-btn {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .retry-btn {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem;
                margin: 1rem;
            }

            .status-icon {
                font-size: 3rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .action-buttons a {
                justify-content: center;
            }
        }

        /* Progress indicator for successful deletion */
        .progress-bar {
            width: 100%;
            height: 4px;
            background: rgba(40, 167, 69, 0.2);
            border-radius: 2px;
            margin: 1rem 0;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #28a745, #20c997);
            width: 0%;
            border-radius: 2px;
            animation: fillProgress 2s ease-out forwards;
        }

        @keyframes fillProgress {
            to {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%
    String title;
    title = request.getParameter("title");

    Configuration cfg = new Configuration().configure();
    SessionFactory sf = cfg.addAnnotatedClass(FoundItems.class).buildSessionFactory();
    Session ses = sf.getCurrentSession();
    ses.beginTransaction();

    Query<FoundItems> q = ses.createQuery("delete from FoundItems where title=:t");
    q.setParameter("t", title);
    int cnt = q.executeUpdate();
    ses.getTransaction().commit();
    sf.close();
    
    if (cnt > 0) {
    %>
    <div class="container success-container">
        <div class="logo">🔍 Campus Finder</div>
        
        <div class="status-icon">✅</div>
        
        <div class="status-message">
            Item deleted successfully!
        </div>
        
        <div class="item-info">
            <h3>Deleted Item:</h3>
            <div class="item-title">"<%= title %>"</div>
        </div>
        
        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>
        
        <div class="action-buttons">
            <a href="index.jsp" class="home-btn">🏠 Home</a>
            <a href="found-items.jsp" class="admin-btn">👀 View Items</a>
            <a href="delete-item.html" class="delete-btn">🗑️ Delete Another</a>
        </div>
    </div>
    <% } else { %>
    <div class="container error-container">
        <div class="logo">🔍 Campus Finder</div>
        
        <div class="status-icon">❌</div>
        
        <div class="status-message">
            Failed to delete item. Title not found.
        </div>
        
        <div class="item-info">
            <h3>Searched for:</h3>
            <div class="item-title">"<%= title %>"</div>
            <p style="margin-top: 1rem; color: #666; font-size: 0.9rem;">
                Please check the spelling and try again. Item titles are case-sensitive.
            </p>
        </div>
        
        <div class="action-buttons">
            <a href="index.jsp" class="home-btn">🏠 Home</a>
            <a href="found-items.jsp" class="admin-btn">👀 View All Items</a>
            <a href="delete-item.html" class="retry-btn">🔄 Try Again</a>
        </div>
    </div>
    <% } %>
</body>
</html>