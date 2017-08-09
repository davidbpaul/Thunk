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

/**
 * Servlet implementation class LectureMaker
 */
@WebServlet("/LectureMaker")
public class LectureMaker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LectureMaker() {
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
		try{
			String course= request.getParameter("course");
			String lec = request.getParameter("lec");
			System.out.println(lec);
			System.out.println(course);
			String title = request.getParameter("title");
			String Subject1 = request.getParameter("Subject1");
			String Subject2 = request.getParameter("Subject2");
			String Subject3 = request.getParameter("Subject3");
			String Description1 = request.getParameter("Description1");
			String Description2 = request.getParameter("Description2");
			String Description3 = request.getParameter("Description3");
		

	
        
			String sql ="INSERT INTO lectures(title,sub1,sub2,sub3,d1,d2,d3) values(?,?,?,?,?,?,?)";
			String sql2 ="UPDATE marks SET lecture_id"+ lec+"= ? WHERE course_id ="+course +";";
			Class.forName("com.mysql.jdbc.Driver");
			try {
		
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					
				    java.sql.Statement innerStatement = conn.createStatement();
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, title);
					ps.setString(2, Subject1);
					ps.setString(3, Subject2);
					ps.setString(4, Subject3);
					ps.setString(5, Description1);
					ps.setString(6, Description2);
					ps.setString(7, Description3);
					
					ps.executeUpdate();
				    ResultSet innerResultSet = innerStatement.executeQuery("SELECT _id FROM lectures WHERE d1='"+ Description1 +"' AND d2='"+Description2 + "' AND title='"+title +"' AND sub1='"+Subject1+"' AND sub2='"+Subject2+"';");
			
			
				    while (innerResultSet.next()) {
				    	
				    	String first =  innerResultSet.getString("_id");
				    	System.out.println(first);
				    	PreparedStatement ps2 = conn.prepareStatement(sql2);
						ps2.setString(1, first);
						ps2.executeUpdate();
	
					
	

		
				
				    }
				    innerResultSet.close();
				    innerStatement.close(); 
				    
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
