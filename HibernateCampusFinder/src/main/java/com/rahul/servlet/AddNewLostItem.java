package com.rahul.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.rahul.entity.LostItems;

/**
 * Servlet implementation class AddNewLostItem
 */
@WebServlet("/AddNewLostItem")
public class AddNewLostItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewLostItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		String title,student_name,location,description,lost_date,contact;
		
		title=request.getParameter("title");
		student_name=request.getParameter("student_name");
		location=request.getParameter("location");
		description=request.getParameter("description");
		lost_date=request.getParameter("lost_date");
		contact=request.getParameter("contact");
		
		LostItems li=new LostItems();
		li.setTitle(title);
		li.setStudent_name(student_name);
		li.setContact(contact);
		li.setLocation(location);
		li.setLost_date(lost_date);
		li.setDescription(description);
		
		Configuration cfg=new Configuration().configure();
		SessionFactory sf=cfg.addAnnotatedClass(LostItems.class).buildSessionFactory();
		Session ses=sf.getCurrentSession();
		ses.beginTransaction();
		
		ses.persist(li);
		ses.getTransaction().commit();
		
		System.out.println("new lost item added susseccfully ");
		out.println("new lost item added susseccfully ");
		
		
		
		
	}

}
