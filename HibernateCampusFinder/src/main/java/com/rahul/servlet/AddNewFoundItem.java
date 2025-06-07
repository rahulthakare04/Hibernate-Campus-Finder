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

import com.rahul.entity.FoundItems;

/**
 * Servlet implementation class AddNewFoundItem
 */
@WebServlet("/AddNewFoundItem")
public class AddNewFoundItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewFoundItem() {
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
		
		
		String title,finder_name,location,found_date,contact;
		
		title=request.getParameter("title");
		finder_name=request.getParameter("finder_name");
		location=request.getParameter("location");
		found_date=request.getParameter("found_date");
		contact=request.getParameter("contact");
		
		FoundItems fi=new FoundItems();
		fi.setTitle(title);
		fi.setFinder_name(finder_name);
		fi.setLocation(location);
		fi.setFound_date(found_date);
		fi.setContact(contact);
		
		Configuration cfg=new Configuration().configure();
		SessionFactory sf=cfg.addAnnotatedClass(FoundItems.class).buildSessionFactory();
		Session ses=sf.getCurrentSession();
		ses.beginTransaction();
		
		ses.persist(fi);
		ses.getTransaction().commit();
		System.out.println("new found item added susseccfully");
		out.println("<h1>new found item added susseccfully</h1><hr>");
	}

}
