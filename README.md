# Hibernate Campus Finder 🛝

A Java-based web application built using **Hibernate**, **Servlets**, **JSP**, and **MySQL** that helps students report and find **lost or found items** on their campus.

This project aims to provide a simple and effective portal where students can easily report misplaced or recovered items, making it easier for the community to connect and resolve such issues.

---

## 📌 Project Objective

The **Hibernate Campus Finder** project was developed to:

* Understand Hibernate ORM's real-world application in Java Web Development.
* Build a CRUD-based system without authentication for students and campus use.
* Enable easy reporting, viewing, and searching of lost/found items in various campus locations.

---

## 📂 Entities (Hibernate ORM)

### 1. `LostItems.java`

Represents items lost by students.

| Field         | Type   | Description                  |
| ------------- | ------ | ---------------------------- |
| id            | int    | Primary Key (Auto-generated) |
| title         | String | Title of lost item           |
| student\_name | String | Name of the student          |
| location      | String | Where the item was lost      |
| description   | String | Additional item description  |
| lost\_date    | String | Date item was lost           |
| contact       | String | Contact info for the student |

### 2. `FoundItems.java`

Represents items found on campus.

| Field        | Type   | Description                     |
| ------------ | ------ | ------------------------------- |
| id           | int    | Primary Key (Auto-generated)    |
| title        | String | Title of found item             |
| finder\_name | String | Name of the person who found it |
| location     | String | Where it was found              |
| found\_date  | String | Date item was found             |
| contact      | String | Contact info of finder          |

---

## 🧠 Features

* 📅 **Report Lost Item**
* 📄 **Report Found Item**
* 🔍 **View Lost Items List**
* 👀 **View Found Items List**
* 🗃️ **Search by Location**
* 🔒 Simple **Admin Panel** for potential moderation (future scope)

---

## 🛠️ Technologies Used

| Category      | Stack                         |
| ------------- | ----------------------------- |
| Backend       | Java, Servlet, Hibernate ORM  |
| Frontend      | JSP, HTML, CSS                |
| Database      | MySQL                         |
| Server        | Apache Tomcat                 |
| ORM Framework | Hibernate                     |
| Build Tool    |   Maven

---

## 🌐 Web Pages

* `index.jsp` - Home Page
* `lost-items.jsp` - View all reported lost items
* `found-items.jsp` - View all reported found items
* `report-lost.html` - Form to report a lost item
* `report-found.html` - Form to report a found item
* `search-results.jsp` - Search items by campus location
* `login.html` - Admin Login Page (static for now)

---

## 🔍 Campus Location Filters

Users can search items based on locations like:

* Library
* Cafeteria
* Classroom
* Hostel
* Sports Complex
* Parking Area
* Auditorium
* Garden / Campus Grounds

```html
<form action="search-results.jsp" method="GET">
  <select name="location" required>
    <option value="">Select Location</option>
    <option value="Library">Library</option>
    ...
  </select>
</form>
```

---

## 📁 Folder Structure

```
Hibernate-Campus-Finder/
├── src/
│   └── com/rahul/entity/
│       ├── LostItems.java
│       └── FoundItems.java
├── WebContent/
│   ├── index.jsp
│   ├── lost-items.jsp
│   ├── found-items.jsp
│   ├── report-lost.html
│   ├── report-found.html
│   ├── login.html
│   └── search-results.jsp
├── hibernate.cfg.xml
```

---

## ⚙️ How to Run

### 1. Clone the Repository

```bash
git clone https://github.com/rahulthakare04/Hibernate-Campus-Finder.git
```

### 2. Configure Database

* Create a MySQL database named `campus_finder`.
* Import the `lost_items` and `found_items` table schema using the provided SQL file or Hibernate auto-generation.
* Update DB credentials in `hibernate.cfg.xml`.

### 3. Setup in Eclipse

* Import the project as a Dynamic Web Project.
* Add libraries for:

  * Hibernate core
  * MySQL connector
  * Servlet API (if not present)
* Deploy on Apache Tomcat (9 or higher).
* Run on `http://localhost:8080/Hibernate-Campus-Finder/`

---

## ✅ Future Scope

* Add Admin login and delete functionality.
* Image upload for found items.
* Add student email verification or ID verification.
* Export item reports to PDF.
* Add location maps using Google Maps API.

---

## 🤝 Contribution

Pull requests are welcome! If you have suggestions for improvement, feel free to open an issue or fork the repo and make your changes.

---

## 📜 License

This project is open-source and available under the MIT License.

---

## 💬 Let's Connect

Created with ❤️ by [Rahul Thakare](https://github.com/rahulthakare04)
