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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Courses</title>
<!-- Bootstrap core CSS -->
  <link href="Style/lib/bootstrap.css" rel="stylesheet">

  <!-- font-awesome -->
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="Style/app.css" rel="stylesheet">
</head>
<body>
  <nav class="navbar navbar-inverse" style="margin-bottom:0px;">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.jsp">Thunk</a>
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav navbar-left">
          <li style="color:white;">
            <%
            if (session != null) {
              if (session.getAttribute("user") != null) {
              connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                String email1 = (String) session.getAttribute("user");
                Statement innerNavStatement = connection.createStatement();
            ResultSet innerNavResultSet = innerNavStatement.executeQuery("SELECT * FROM users WHERE email='"+ email1 +"';");
                while (innerNavResultSet.next()) {
                  String firstNav =  innerNavResultSet.getString("name");
                  out.print("Hello, " + firstNav);
                  }
                innerNavResultSet.close();
                innerNavStatement.close();

              } else {
                response.sendRedirect("login.jsp");
              }
            }
          %>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="home.jsp">Courses</a></li>
          <li class="active"><a href="myCourses.jsp"> My Courses</a></li>
          <li><a href="account.jsp">Account</a></li>
          <li>
              <form action="Logout" method="post">
                <input style="margin-top:8px;" class="btn btn-info" role="button" type="submit" value="Logout">
              </form>
          </li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
  </nav>
  <div class="pic">
    <img class="banner-image-full"
    alt="Promotional banner"
    src="https://udemy-images.udemy.com/hellobar_banner/1440x276/4428_d8d8.jpg">
  </div>
  <div class="container">
    <div class="row">
      <div class="courses">
        <div class="courseIntroDiv">
          <h2 class="courseIntro">
            My Courses
          </h2>
        </div>

    <%
			try{
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
			String sql = "SELECT * FROM courses INNER JOIN payment ON courses._id= payment.course_id;";

			resultSet = statement.executeQuery(sql);
			while(resultSet.next()){
		%>
        <div class="col-md-3">
          <a href="courseLectures.jsp?course=<%=resultSet.getString("_id")%>">
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
                  Start
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
      <div class="col-md-3">
        <a href="home.jsp">
          <div class="card clicker" style="background:#E9FFEC; border:1px solid #E9FFEC;box-shadow:0 0px 0 rgba(0,0,0,.2), 0 1px 1px rgba(0,0,0,.15)">
            <div class="cardPic plus-course">
              <i class="fa fa-plus  plus-course" aria-hidden="true"></i>
            </div>
            <div class="" style="text-align:center; margin:none;">
              <span class="price"style="text-align:center; margin:none;">
                Add Course
              </span>
            </div>
          </div>
        </a>
      </div>
      </div>
    </div>
  </div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="Javascript/lib/bootstrap.js"></script>
</html>
