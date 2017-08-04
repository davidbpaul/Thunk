<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>



<%
String title = request.getParameter("title");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "school";
String userId = "root";
String password = "password";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; UTF-8">
<title>Home</title>
<!-- Bootstrap core CSS -->
  <link href="Style/lib/bootstrap.css" rel="stylesheet">

  <!-- font-awesome -->
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="Style/app.css" rel="stylesheet">
</head>
<body>
  <nav class="navbar navbar-inverse" style="margin-bottom:0px;">
    <%
		if (session != null) {
			if (session.getAttribute("user") != null) {
				String name = (String) session.getAttribute("user");
				out.print("Hello, " + name + "  Welcome to ur Profile");
			} else {
				response.sendRedirect("login.jsp");
			}
		}
	%>
  <form action="Logout" method="post">
    <input type="submit" value="Logout">
  </form>
  </nav>
  <div class="pic">
    <img class="banner-image-full"
    alt="Promotional banner"
    src="https://udemy-images.udemy.com/hellobar_banner/1440x276/4854_2f8e_3.jpg">
  </div>
  <div class="container">
    <div class="row">
      <div class="courses">
        <div class="courseIntroDiv">
          <h2 class="courseIntro">
            Students are Viewing
          </h2>
        </div>
        
        <%
			try{ 
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
			String sql ="SELECT * FROM courses";
			
			resultSet = statement.executeQuery(sql);
			while(resultSet.next()){
		%>
		
		<div class="col-md-3">
			<a href="course.jsp?page=<%=resultSet.getString("_id")%>">
	          <div class="card">
	            <div class="cardPic">
	              <img src="https://udemy-images.udemy.com/course/240x135/484606_5721_11.jpg"
	              srcset="https://udemy-images.udemy.com/course/240x135/484606_5721_11.jpg 1x,
	              https://udemy-images.udemy.com/course/480x270/484606_5721_11.jpg 2x"
	              alt="Instagram Marketing: A Step-By-Step to 10,000 Real Followers"
	              class="imgCard">
	            </div>
	            <div class="cardDescription">
	              <span>
	                <%=resultSet.getString("title") %>
	              </span>
	
	            </div>
	            <div class="cardPrice">
	              <span class="price">
	                $<%=resultSet.getString("price") %>
	              </span>
	            </div>
	          </div>
            </a>
        </div>
		
		
	<% 
	}
	
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>
     


      </div>
    </div>
  </div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="Javascript/lib/bootstrap.js"></script>
</html>
