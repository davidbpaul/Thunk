package Courses;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class New
 */
@WebServlet("/New")
public class New extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public New() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		try{
			String _id = request.getParameter("_id");
			String title = request.getParameter("title");
			String price = request.getParameter("price");
			String effort = request.getParameter("effort");
			String length = request.getParameter("length");
			String subject = request.getParameter("subject");
			String about = request.getParameter("about");
			String learn = request.getParameter("learn");
			String learn2 = request.getParameter("learn2");
			String learn3 = request.getParameter("learn3");
	
			String sql ="INSERT INTO courses(title, price, effort, length, subject, about, learn, learn2, learn3) values(?,?,?,?,?,?,?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			try {
		
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, title);
					ps.setString(2,  price);
					ps.setString(3, effort);
					ps.setString(4, length);
					ps.setString(5, subject);
					ps.setString(6, about);
					ps.setString(7, learn);
					ps.setString(8, learn2);
					ps.setString(9, learn3);
					
					ps.executeUpdate();
			
					response.sendRedirect("home.jsp");
		
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("ERROR WRONG PASSWORD OR USERNAME " + e.getMessage());
			}
		}catch(ClassNotFoundException e){
			System.out.println("ERROR CONNECTING TO DATABASE " + e.getMessage());
		}
		
		
	}

}
