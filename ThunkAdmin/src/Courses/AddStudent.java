package Courses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Statement;

/**
 * Servlet implementation class AddStudent
 */
@WebServlet("/AddStudent")
public class AddStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStudent() {
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
			String course_id = request.getParameter("course_id");
			String email = request.getParameter("email");
			String price = "0";
			String credit = "0";
			String security = "0";
			String date = "0";
			System.out.println(course_id);
			System.out.println(email);
        
			String sql ="INSERT INTO payment(user_id, course_id, course_price,credit,security,date) values(?,?,?,?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			try {
		
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					
				    java.sql.Statement innerStatement = conn.createStatement();
				    ResultSet innerResultSet = innerStatement.executeQuery("SELECT * FROM users WHERE email='"+ email +"';");
				    
				    while (innerResultSet.next()) {
				    	String first =  innerResultSet.getString("_id");
				    			
				    	System.out.println(first);
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, first);
					ps.setString(2,  course_id);
					ps.setString(3,  price);
					ps.setString(4,   credit);
					ps.setString(5,  security);
					ps.setString(6,  date);
			
					ps.executeUpdate();
				    innerResultSet.close();
				    innerStatement.close();
		
					response.sendRedirect("home.jsp");
				    }
				    
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
