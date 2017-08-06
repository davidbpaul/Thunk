package Courses;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Payment
 */
@WebServlet("/Payment")
public class Payment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Payment() {
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
			String credit = request.getParameter("credit");
			String security = request.getParameter("security");
			String date = request.getParameter("date");
			String user_id = request.getParameter("name");
			String course_id = request.getParameter("course");
			String course_price = request.getParameter("price");
			String sql ="INSERT INTO payment(credit, security, date, user_id, course_id, course_price) VALUES(?,?,?,?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			try {
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, credit);
					ps.setString(2, security);
					ps.setString(3, date);
					ps.setString(4, user_id);
					ps.setString(5, course_id);
					ps.setString(6, course_price);
					
					PrintWriter out  = response.getWriter();
					ps.executeUpdate();
					response.sendRedirect("myCourses.jsp");
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
