<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="com.rahul.entity.LostItems" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Lost Items - Campus Finder</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
    animation: fadeIn 0.8s ease-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

.header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 15px;
    padding: 25px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    animation: slideDown 0.6s ease-out;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.header-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    flex-wrap: wrap;
    gap: 15px;
}

.logo {
    display: flex;
    align-items: center;
    gap: 10px;
}

.logo h1 {
    background: linear-gradient(135deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-size: 1.8rem;
    font-weight: bold;
}

.item-count {
    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
    color: white;
    padding: 10px 20px;
    border-radius: 25px;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 8px;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

.nav-links {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.nav-links a {
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

.nav-links a.home {
    background: linear-gradient(135deg, #2ed573, #1e90ff);
    color: white;
}

.nav-links a.found {
    background: linear-gradient(135deg, #5352ed, #3742fa);
    color: white;
}

.nav-links a.admin {
    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
    color: white;
}

.nav-links a.report {
    background: linear-gradient(135deg, #ffa726, #ff7043);
    color: white;
}

.nav-links a:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.table-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    animation: slideUp 0.6s ease-out 0.2s both;
}

@keyframes slideUp {
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
}

th {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 18px 15px;
    text-align: left;
    font-weight: 600;
    font-size: 0.95rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    position: sticky;
    top: 0;
    z-index: 10;
}

td {
    padding: 15px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    color: #333;
    font-size: 0.9rem;
}

tr:hover {
    background: rgba(102, 126, 234, 0.1);
    transition: background 0.3s ease;
}

tr:nth-child(even) {
    background: rgba(0, 0, 0, 0.02);
}

.empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #666;
}

.empty-state h3 {
    font-size: 1.5rem;
    margin-bottom: 15px;
    color: #333;
}

.empty-state p {
    font-size: 1rem;
    margin-bottom: 25px;
}

.empty-state a {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 25px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.empty-state a:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

@media (max-width: 768px) {
    .header-top {
        flex-direction: column;
        text-align: center;
    }
    
    .nav-links {
        justify-content: center;
    }
    
    .table-container {
        overflow-x: auto;
    }
    
    table {
        min-width: 600px;
    }
    
    th, td {
        padding: 12px 10px;
        font-size: 0.85rem;
    }
}

@media (max-width: 480px) {
    body {
        padding: 10px;
    }
    
    .header {
        padding: 20px 15px;
    }
    
    .logo h1 {
        font-size: 1.5rem;
    }
    
    .nav-links a {
        padding: 8px 15px;
        font-size: 0.9rem;
    }
}
</style>
</head>
<body>
    <div class="header">
        <div class="header-top">
            <div class="logo">
                <h1>🔍 Campus Finder</h1>
            </div>
            
            <%
            Configuration cfg = new Configuration().configure();
            SessionFactory sf = cfg.addAnnotatedClass(LostItems.class).buildSessionFactory();
            Session ses = sf.getCurrentSession();
            ses.beginTransaction();

            Query<LostItems> q = ses.createQuery("from LostItems", LostItems.class);
            List<LostItems> list = q.getResultList();
            %>
            
            <div class="item-count">
                <span>📋</span>
                Total Lost Items: <%= list.size() %>
            </div>
        </div>
        
        <div class="nav-links">
            <a href="index.jsp" class="home">🏠 Home</a>
            <a href="found-items.jsp" class="found">✅ Found Items</a>
            <a href="report-lost.html" class="report">📝 Report Lost</a>
            <a href="login.html" class="admin">🔐 Admin</a>
        </div>
    </div>

    <div class="table-container">
        <% if (list.size() > 0) { %>
            <table>
                <tr>
                    <th>📋 Title</th>
                    <th>👤 Student Name</th>
                    <th>📞 Contact</th>
                    <th>📍 Location</th>
                    <th>📅 Lost Date</th>
                </tr>
                <%
                for (LostItems li : list) {
                %>
                <tr>
                    <td><%= li.getTitle() %></td>
                    <td><%= li.getStudent_name() %></td>
                    <td><%= li.getContact() %></td>
                    <td><%= li.getLocation() %></td>
                    <td><%= li.getLost_date() %></td>
                </tr>
                <%
                }
                %>
            </table>
        <% } else { %>
            <div class="empty-state">
                <h3>📭 No Lost Items Found</h3>
                <p>Great news! There are currently no lost items reported.</p>
                <a href="report-lost.html">📝 Report a Lost Item</a>
            </div>
        <% } %>
    </div>

    <%
    ses.getTransaction().commit();
    sf.close();
    %>
</body>
</html>