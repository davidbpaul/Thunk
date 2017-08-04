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
