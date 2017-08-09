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
 * Servlet implementation class Rebate
 */
@WebServlet("/Rebate")
public class Rebate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Rebate() {
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
			String user_id = request.getParameter("user_id");
			String paid = "0";
        
			String sql ="UPDATE payment SET course_price = ? WHERE user_id = ? AND course_id = ?;";
			Class.forName("com.mysql.jdbc.Driver");
			try {
		
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,  paid);
					ps.setString(2, user_id);
					ps.setString(3,  course_id);
					ps.executeUpdate();
			
		
					response.sendRedirect("courseEdit.jsp?course="+course_id);
				    
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
