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
<title>Course</title>
<!-- Bootstrap core CSS -->
  <link href="Style/lib/bootstrap.css" rel="stylesheet">

  <!-- font-awesome -->
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="Style/app.css" rel="stylesheet">
</head>
<body style="background:#f8f8f8">
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
          <li class="active"><a href="home.jsp">Courses</a></li>
          <li><a href="myCourses.jsp"> My Courses</a></li>
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

  <%
			try{
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
			String sql ="SELECT * FROM courses WHERE _id =" + request.getParameter("page");

			resultSet = statement.executeQuery(sql);
			while(resultSet.next()){
		%>


  <div class="container courseBody">
    <div class="courseHeader">
      <div class="col-md-3">
        <div class="cardPic">
          <img src="https://udemy-images.udemy.com/course/240x135/484606_5721_11.jpg"
          srcset="https://udemy-images.udemy.com/course/240x135/484606_5721_11.jpg 1x,
          https://udemy-images.udemy.com/course/480x270/484606_5721_11.jpg 2x"
          alt="Instagram Marketing: A Step-By-Step to 10,000 Real Followers"
          class="imgCard btn-margin">
        </div>
      </div>
      <div class="col-md-6">
        <h1 class="course-heading">
             <%=resultSet.getString("title") %>
        </h1>

        <p class="course-description">
            <%=resultSet.getString("about") %>
        </p>
      </div>
      <div class="col-md-3">
        <button type="button" class="btn-lg btn-block btn-success btn-margin">Enroll Now</button>
      </div>
    </div>
    <div class="col-md-8">
      <div class="courseInfo">
        <h3 class="course-info-heading">What you'll learn</h3>
        <ul class="course-info-list">
          <li class="course-info-list-item">
              <%=resultSet.getString("learn") %>
          </li>
          <li class="course-info-list-item">
              <%=resultSet.getString("learn2") %>
          </li>
          <li class="course-info-list-item">
              <%=resultSet.getString("learn3") %>
          </li>
        </ul>
      </div>
    </div>
    <div class="col-md-4">
      <div class="courseInfo">
        <ul class="sideList">
          <li class="sideListItem">
            <div class="col-md-6">
              <span aria-hidden="true" class="fa fa-clock-o fa-lg"> Length: </span>

            </div>
            <div class="col-md-6">
              <span>   <%=resultSet.getString("length") %> weeks</span>
            </div>
          </li>
        </ul>
        <ul class="sideList">
          <li class="sideListItem">
            <div class="col-md-6">
              <span aria-hidden="true" class="fa fa-tachometer fa-lg"> Effort:</span>
            </div>
            <div class="col-md-6">
              <span>   <%=resultSet.getString("effort") %> hours/week</span>
            </div>
          </li>
        </ul>
        <ul class="sideList">
          <li class="sideListItem">
            <div class="col-md-6">
              <span aria-hidden="true" class="fa fa-tag fa-lg"> Price:</span>
            </div>
            <div class="col-md-6">
              <span>$   <%=resultSet.getString("price") %></span>
            </div>
          </li>
        </ul>
        <ul class="sideList">
          <li class="sideListItem">
            <div class="col-md-6">

              <span aria-hidden="true" class="fa fa-graduation-cap fa-lg"> Subject:</span>
            </div>
            <div class="col-md-6">
              <span>   <%=resultSet.getString("subject") %></span>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  	<%
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="Javascript/lib/bootstrap.js"></script>
</html>
