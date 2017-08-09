package Courses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteCourse
 */
@WebServlet("/DeleteCourse")
public class DeleteCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCourse() {
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
			String _id = request.getParameter("_id");
        
			String sql ="DELETE FROM courses WHERE _id = ?;";
			Class.forName("com.mysql.jdbc.Driver");
			try {
		
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, _id);
			
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
