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

/**
 * Servlet implementation class Submit
 */
@WebServlet("/Submit")
public class Submit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Submit() {
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
		
		try{
			String page = request.getParameter("page");
			String course= request.getParameter("course");
			String content = request.getParameter("content");
			String assignment_id = request.getParameter("assignment_id");
			String user_id = request.getParameter("user_id");
			String sql ="INSERT INTO submitted(user_id, assignment_id,content) VALUES(?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			try {
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, user_id);
					ps.setString(2, assignment_id);
					ps.setString(3, content);
		
					
					ps.executeUpdate();
					response.sendRedirect("courseContent.jsp?page="+page +"&&course="+ course);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("ERROR WRONG Card " + e.getMessage());
			}
		}catch(ClassNotFoundException e){
			System.out.println("ERROR CONNECTING TO DATABASE " + e.getMessage());
		}
	}

}
