package Authentication;

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
 * Servlet implementation class Registration
 */
@WebServlet("/Registration")
public class RegistrationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
		
		try{
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String passwordRepeat = request.getParameter("passwordRepeat");
			String name = request.getParameter("name");
			String sql ="INSERT INTO users(email, password, name) values(?,?,?)";
			Class.forName("com.mysql.jdbc.Driver");
			try {
				if(password.equals(passwordRepeat)){
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school", "root", "password");
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, email);
					ps.setString(2, password);
					ps.setString(3, name);
					ps.executeUpdate();
					PrintWriter out  = response.getWriter();
					HttpSession session = request.getSession(true);
					session.setAttribute("user", email);
					session.setMaxInactiveInterval(99999999); 
					response.sendRedirect("home.jsp");
				}else{
					System.out.println("Passwords do not match ");
					System.out.println(password);
					System.out.println(passwordRepeat);
					
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
