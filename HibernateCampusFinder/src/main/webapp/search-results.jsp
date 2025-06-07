<%@page import="java.util.List"%>
<%@page import="org.hibernate.query.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.rahul.entity.FoundItems"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.cfg.Configuration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Search Results - Campus Finder</title>
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
    from { opacity: 0; }
    to { opacity: 1; }
}

.header {
    text-align: center;
    margin-bottom: 30px;
    animation: slideDown 0.6s ease-out;
}

@keyframes slideDown {
    from { transform: translateY(-30px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

.logo {
    font-size: 1.8rem;
    font-weight: bold;
    color: white;
    margin-bottom: 10px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.3);
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    animation: slideUp 0.8s ease-out 0.2s both;
}

@keyframes slideUp {
    from { transform: translateY(50px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

.search-header {
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 2px solid #e2e8f0;
}

.search-title {
    color: #4a5568;
    font-size: 2rem;
    margin-bottom: 15px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.search-info {
    background: linear-gradient(135deg, #e0f2fe, #f3e5f5);
    padding: 15px 20px;
    border-radius: 12px;
    border-left: 4px solid #667eea;
    margin-bottom: 20px;
    font-size: 1.1rem;
    color: #4a5568;
}

.location-badge {
    display: inline-block;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    font-weight: 600;
    font-size: 1rem;
    margin: 0 5px;
    box-shadow: 0 2px 10px rgba(102, 126, 234, 0.3);
}

.results-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    animation: slideUp 0.6s ease-out 0.4s both;
}

.results-table th {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 18px 15px;
    text-align: left;
    font-weight: 600;
    font-size: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    position: sticky;
    top: 0;
    z-index: 10;
}

.results-table td {
    padding: 15px;
    border-bottom: 1px solid #e2e8f0;
    color: #4a5568;
    font-size: 0.95rem;
    vertical-align: top;
}

.results-table tr:hover {
    background: linear-gradient(135deg, #f7fafc, #edf2f7);
    transform: translateX(5px);
    transition: all 0.3s ease;
}

.results-table tr:nth-child(even) {
    background: #f8fafc;
}

.no-results {
    text-align: center;
    padding: 60px 20px;
    animation: fadeIn 0.8s ease-out 0.4s both;
}

.no-results-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    opacity: 0.6;
}

.no-results h2 {
    color: #4a5568;
    font-size: 1.8rem;
    margin-bottom: 15px;
}

.no-results p {
    color: #718096;
    font-size: 1.1rem;
    margin-bottom: 30px;
    line-height: 1.6;
}

.action-buttons {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 30px;
    flex-wrap: wrap;
}

.btn {
    padding: 12px 24px;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.btn-primary {
    background: linear-gradient(135deg, #48bb78, #38a169);
    color: white;
    box-shadow: 0 4px 15px rgba(72, 187, 120, 0.4);
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(72, 187, 120, 0.6);
}

.btn-secondary {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.btn-secondary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
}

.btn-outline {
    background: transparent;
    color: #667eea;
    border: 2px solid #667eea;
}

.btn-outline:hover {
    background: #667eea;
    color: white;
    transform: translateY(-3px);
}

.contact-info {
    background: linear-gradient(135deg, #e6fffa, #f0fff4);
    padding: 8px 12px;
    border-radius: 8px;
    border-left: 3px solid #48bb78;
    font-weight: 600;
    color: #2d3748;
}

.item-title {
    font-weight: 700;
    color: #2d3748;
    font-size: 1.05rem;
}

.date-info {
    color: #718096;
    font-style: italic;
}

.stats-bar {
    background: rgba(102, 126, 234, 0.1);
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
}

.stats-number {
    font-size: 2rem;
    font-weight: bold;
    color: #667eea;
    display: block;
}

.stats-label {
    color: #718096;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

@media (max-width: 768px) {
    .container {
        margin: 10px;
        padding: 20px;
    }
    
    .results-table {
        font-size: 0.85rem;
    }
    
    .results-table th,
    .results-table td {
        padding: 12px 8px;
    }
    
    .search-title {
        font-size: 1.6rem;
    }
    
    .action-buttons {
        flex-direction: column;
        align-items: center;
    }
    
    .btn {
        width: 100%;
        max-width: 300px;
        justify-content: center;
    }
}

.table-container {
    overflow-x: auto;
    margin-top: 20px;
}
</style>
</head>
<body>
<div class="header">
    <div class="logo">🔍 Campus Finder</div>
</div>

<div class="container">
    <%
    String location;
    location = request.getParameter("location");
    Configuration cfg = new Configuration().configure();
    SessionFactory sf = cfg.addAnnotatedClass(FoundItems.class).buildSessionFactory();
    Session ses = sf.getCurrentSession();
    ses.beginTransaction();

    Query<FoundItems> q = ses.createQuery("from FoundItems where location=:loc", FoundItems.class);
    q.setParameter("loc", location);
    List<FoundItems> list = q.getResultList();
    %>
    
    <div class="search-header">
        <h1 class="search-title">🔍 Search Results</h1>
        <div class="search-info">
            📍 Showing results for location: <span class="location-badge"><%= location %></span>
        </div>
    </div>

    <% if(list.size() > 0) { %>
        <div class="stats-bar">
            <span class="stats-number"><%= list.size() %></span>
            <span class="stats-label">Items Found at this Location</span>
        </div>

        <div class="table-container">
            <table class="results-table">
                <thead>
                    <tr>
                        <th>📱 Item Title</th>
                        <th>👤 Finder Name</th>
                        <th>📍 Location</th>
                        <th>📅 Found Date</th>
                        <th>📞 Contact</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(FoundItems li: list) {
                    %>
                    <tr>
                        <td class="item-title"><%= li.getTitle() %></td>
                        <td><%= li.getFinder_name() %></td>
                        <td><%= li.getLocation() %></td>
                        <td class="date-info"><%= li.getFound_date() %></td>
                        <td><div class="contact-info"><%= li.getContact() %></div></td>
                    </tr>
                    <%
                    }
                    ses.getTransaction().commit();
                    sf.close();
                    %>
                </tbody>
            </table>
        </div>

        <div class="action-buttons">
            <a href="index.jsp" class="btn btn-primary">🏠 Back to Home</a>
            <a href="report-lost.html" class="btn btn-secondary">📝 Report Lost Item</a>
            <a href="found-items.jsp" class="btn btn-outline">👀 View All Found Items</a>
        </div>

    <% } else { 
        ses.getTransaction().commit();
        sf.close();
    %>
        <div class="no-results">
            <div class="no-results-icon">😔</div>
            <h2>No Items Found</h2>
            <p>Sorry, we couldn't find any items at <strong><%= location %></strong> location.<br>
            Don't worry! New items are reported regularly.</p>
            
            <div class="action-buttons">
                <a href="index.jsp" class="btn btn-primary">🏠 Back to Home</a>
                <a href="report-found.html" class="btn btn-secondary">✅ Report Found Item</a>
                <a href="found-items.jsp" class="btn btn-outline">👀 View All Found Items</a>
            </div>
        </div>
    <% } %>
</div>
</body>
</html>