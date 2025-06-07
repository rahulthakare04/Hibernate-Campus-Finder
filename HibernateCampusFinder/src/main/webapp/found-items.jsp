<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
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
    <title>Found Items - Campus Finder</title>
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
            color: #333;
            padding: 2rem;
        }

        /* Header Styles */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            animation: slideInDown 0.6s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
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
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .page-title {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .item-count {
            font-size: 1.3rem;
            color: #28a745;
            font-weight: 600;
            background: rgba(40, 167, 69, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 1rem;
        }

        /* Table Container */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            font-size: 1rem;
            min-width: 600px;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.2rem;
            text-align: left;
            font-weight: 600;
            font-size: 1.1rem;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        td {
            padding: 1rem 1.2rem;
            border-bottom: 1px solid #e1e5e9;
            transition: all 0.3s ease;
        }

        tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        tr:nth-child(even) {
            background: rgba(102, 126, 234, 0.02);
        }

        tr:last-child td:first-child {
            border-bottom-left-radius: 12px;
        }

        tr:last-child td:last-child {
            border-bottom-right-radius: 12px;
        }

        /* Navigation Links */
        .nav-links {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .nav-links a {
            display: flex;
            align-items: center;
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

        .nav-links a:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .home-link {
            background: linear-gradient(135deg, #28a745, #20c997) !important;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2) !important;
        }

        .home-link:hover {
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3) !important;
        }

        .admin-link {
            background: linear-gradient(135deg, #dc3545, #c82333) !important;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2) !important;
        }

        .admin-link:hover {
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3) !important;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .empty-state .icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .header {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .logo {
                font-size: 1.5rem;
            }

            .table-container {
                padding: 1rem;
            }

            table {
                font-size: 0.9rem;
            }

            th, td {
                padding: 0.8rem;
            }

            .nav-links {
                flex-direction: column;
            }

            .nav-links a {
                justify-content: center;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(102, 126, 234, 0.3);
            border-radius: 50%;
            border-top-color: #667eea;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">🔍 Campus Finder</div>
        <div class="page-title">👀 Found Items</div>
        
        <%
        Configuration cfg = new Configuration().configure();
        SessionFactory sf = cfg.addAnnotatedClass(FoundItems.class).buildSessionFactory();
        Session ses = sf.getCurrentSession();
        ses.beginTransaction();

        Query<FoundItems> q = ses.createQuery("from FoundItems", FoundItems.class);
        List<FoundItems> list = q.getResultList();
        %>
        
        <div class="item-count">
            📊 Total Found Items: <%= list.size() %>
        </div>
    </div>

    <div class="table-container">
        <% if (list.size() > 0) { %>
            <table>
                <tr>
                    <th>📝 Title</th>
                    <th>👤 Finder Name</th>
                    <th>📍 Location</th>
                    <th>📅 Found Date</th>
                    <th>📞 Contact</th>
                </tr>
                <%
                for(FoundItems li: list){
                %>
                <tr>
                    <td><%= li.getTitle() %></td>
                    <td><%= li.getFinder_name() %></td>
                    <td><%= li.getLocation() %></td>
                    <td><%= li.getFound_date() %></td>
                    <td><%= li.getContact() %></td>
                </tr>
                <%
                }
                %>
            </table>
        <% } else { %>
            <div class="empty-state">
                <div class="icon">📭</div>
                <h3>No Found Items Yet</h3>
                <p>Be the first to report a found item and help fellow students!</p>
            </div>
        <% } %>
    </div>

    <div class="nav-links">
        <a href="index.jsp" class="home-link">🏠 Home</a>
        <a href="lost-items.jsp">🔍 Lost Items</a>
        <a href="report-found.html">✅ Report Found Item</a>
        <a href="login.html" class="admin-link">👨‍💼 Admin Panel</a>
    </div>

    <%
    ses.getTransaction().commit();
    sf.close();
    %>
</body>
</html>