<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Finder - Student Portal</title>
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
        }

        /* Header Styles */
        header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header > div > div {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #667eea;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        nav a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        /* Main Container */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .hero-section {
            text-align: center;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-section p {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Action Buttons */
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .action-buttons a {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            text-decoration: none;
            color: #333;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border: 2px solid transparent;
        }

        .action-buttons a:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
            background: rgba(255, 255, 255, 1);
        }

        /* Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .search-section h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: #333;
            text-align: center;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            max-width: 500px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        .search-form select {
            flex: 1;
            min-width: 200px;
            padding: 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 1rem;
            background: white;
            transition: all 0.3s ease;
        }

        .search-form select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-form button {
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        /* How It Works Section */
        .how-it-works {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .how-it-works h2 {
            font-size: 2rem;
            text-align: center;
            margin-bottom: 2rem;
            color: #333;
        }

        .steps-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .step-card {
            text-align: center;
            padding: 2rem 1rem;
            background: rgba(102, 126, 234, 0.05);
            border-radius: 15px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .step-card:hover {
            transform: translateY(-5px);
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }

        .step-card h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: #667eea;
        }

        .step-card p {
            color: #666;
            line-height: 1.6;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header > div > div {
                flex-direction: column;
                gap: 1rem;
            }

            nav ul {
                flex-wrap: wrap;
                justify-content: center;
                gap: 1rem;
            }

            .hero-section h1 {
                font-size: 2rem;
            }

            .hero-section p {
                font-size: 1rem;
            }

            .search-form {
                flex-direction: column;
            }

            .search-form select,
            .search-form button {
                min-width: 100%;
            }

            .main-container {
                padding: 1rem;
            }
        }

        /* Animation for page load */
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

        .hero-section,
        .search-section,
        .how-it-works {
            animation: fadeInUp 0.6s ease-out;
        }

        .search-section {
            animation-delay: 0.2s;
        }

        .how-it-works {
            animation-delay: 0.4s;
        }
    </style>
</head>
<body>
    <header>
        <div>
            <div>
                <div class="logo">🔍 Campus Finder</div>
                <nav>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="lost-items.jsp">Lost Items</a></li>
                        <li><a href="found-items.jsp">Found Items</a></li>
                        <li><a href="login.html">Admin</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <div class="main-container">
        <div class="hero-section">
            <h1>Campus Lost & Found System</h1>
            <p>
                Help your fellow students by reporting lost or found items.
                Simple, quick, and effective way to reunite items with their owners.
            </p>

            <div class="action-buttons">
                <a href="report-lost.html">📝 Report Lost Item</a>
                <a href="report-found.html">✅ Report Found Item</a>
                <a href="lost-items.jsp">🔍 View Lost Items</a>
                <a href="found-items.jsp">👀 View Found Items</a>
            </div>
        </div>

        <div class="search-section">
            <h3>Search by Location</h3>
            <form action="search-results.jsp" method="GET" class="search-form">
                <select name="location" required>
                    <option value="">Select Location</option>
                    <option value="Library">Library</option>
                    <option value="Cafeteria">Cafeteria</option>
                    <option value="Classroom">Classroom</option>
                    <option value="Hostel">Hostel</option>
                    <option value="Sports Complex">Sports Complex</option>
                    <option value="Parking Area">Parking Area</option>
                    <option value="Auditorium">Auditorium</option>
                    <option value="Garden/Campus Grounds">Garden/Campus Grounds</option>
                </select>
                <button type="submit">Search</button>
            </form>
        </div>

        <div class="how-it-works">
            <h2>How It Works</h2>
            <div class="steps-grid">
                <div class="step-card">
                    <h3>1. Report Item</h3>
                    <p>Lost something? Found something? Report it with details and location.</p>
                </div>
                <div class="step-card">
                    <h3>2. Search & Browse</h3>
                    <p>Look through reported items using our search and filter options.</p>
                </div>
                <div class="step-card">
                    <h3>3. Connect</h3>
                    <p>Contact the person who found your item or claim an item you lost.</p>
                </div>
                <div class="step-card">
                    <h3>4. Retrieve</h3>
                    <p>Arrange a safe meetup to get your item back or return found items.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>