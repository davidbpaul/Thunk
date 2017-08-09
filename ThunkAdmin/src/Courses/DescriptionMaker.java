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
 * Servlet implementation class DescriptionMaker
 */
@WebServlet("/DescriptionMaker")
public class DescriptionMaker extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DescriptionMaker() {
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
					String as = request.getParameter("as");
					String Description1 = request.getParameter("Description1");
					String Date = request.getParameter("Date");
					System.out.println(course);
					System.out.println(as);
					System.out.println(Description1);
			
		        
						String sql ="INSERT INTO assignments(description,date) values(?,?)";
						String sql2 ="UPDATE marks SET assignment_id"+ as+"= ? WHERE course_id ="+course +";";
					Class.forName("com.mysql.jdbc.Driver");
					try {
				
							Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
							
						    java.sql.Statement innerStatement = conn.createStatement();
							PreparedStatement ps = conn.prepareStatement(sql);
							ps.setString(1, Description1);
							ps.setString(2, Date);
							ps.executeUpdate();
						    ResultSet innerResultSet = innerStatement.executeQuery("SELECT _id FROM assignments WHERE description='"+ Description1 +"';");
					
					
						    while (innerResultSet.next()) {
						    	String first =  innerResultSet.getString("_id");
						    	PreparedStatement ps2 = conn.prepareStatement(sql2);
								ps2.setString(1, first);
								ps2.executeUpdate();
			
								System.out.println(first);
			
		
				
						
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
