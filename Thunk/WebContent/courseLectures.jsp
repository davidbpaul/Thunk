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
<title>Course Lecture</title>
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

  <%

			try{
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
			String name2 = (String) session.getAttribute("user");
			System.out.println(name2);
      String num = null;
      String courseId = null;
      if(request.getParameter("course") == null || request.getParameter("page") == "" ){
          out.print("Please Select a Course");
      }else{
        courseId = request.getParameter("course");
      }

      if(request.getParameter("page") == null || request.getParameter("page") == "" ){
    	  num = "1";
      }else{

        num = request.getParameter("page");


        Statement innerParamStatement = connection.createStatement();
          ResultSet innerParamResultSet = innerParamStatement.executeQuery("SELECT * FROM marks WHERE course_id="+ courseId+";");
          while (innerParamResultSet.next()) {
            int parced = Integer.parseInt(num);
            int first =  Integer.parseInt(innerParamResultSet.getString("marks.lecture_id1"));
            int secound =  Integer.parseInt(innerParamResultSet.getString("marks.lecture_id2"));
            int third =  Integer.parseInt(innerParamResultSet.getString("marks.lecture_id3"));
            int fourth =  Integer.parseInt(innerParamResultSet.getString("marks.lecture_id4"));
            if(parced == first){
              num = "1";
            }else if(parced == secound){
              num = "2";
            }else if(parced == third){
              num = "3";
            }else if(parced == fourth){
              num = "4";
            }
            System.out.println("first " + first);
            System.out.println("secound " + secound);
          }
          System.out.println("num " + num);

          innerParamResultSet.close();
          innerParamStatement.close();


      }

			String sql2 ="SELECT courses.title, lectures.title, lectures.sub1, lectures.sub2, lectures.sub3, lectures.d1,  lectures.d2, lectures.d3, marks._id, marks.course_id, marks.lecture_id1,marks.lecture_id2,marks.lecture_id3,marks.lecture_id4, marks.assignment_id1, marks.assignment_id2 FROM marks INNER JOIN lectures on marks.lecture_id"+ num +" = lectures._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id="+ courseId +";";

			resultSet = statement.executeQuery(sql2);
			while(resultSet.next()){

		%>
  <div class="row">
    <!-- <div class="col-md-12"> -->
      <div class="notes-menu">
        <div class="col-md-8 notes-menu-in">
          <h4 style="margin-left:10px;">Course: <a href="myCourses.jsp"><%=resultSet.getString("courses.title") %></a></h4>
        </div>
        <div class="col-md-4">
        </div>
      </div>
    <!-- </div> -->


  </div>
  <div class="notes-sidebar-outer">
    <div class="container-fluid">
      <div class="row notes-sidebar-middle">
        <div class="col-md-2 notes-sidebar">
          <div class="notes-sidebar-inner">
         	<a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id1")%>&&course=<%=resultSet.getString("marks.course_id")%>">
	            <div class="notes-sidebar-note">
	              <h5>Lesson 1</h5>
	              <%
	              Statement innerStatement = connection.createStatement();
				    ResultSet innerResultSet = innerStatement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id1 = lectures._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (innerResultSet.next()) {
				    	String first =  innerResultSet.getString("lectures.title");
				    	%>
				        <h6><small><%= first %></small></h6>
				   <%
				    }
				    innerResultSet.close();
				    innerStatement.close();

	              %>
	            </div>
            </a>
             <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id2")%>&&course=<%=resultSet.getString("marks.course_id")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 2</h5>
 	         <%
	              Statement inner2Statement = connection.createStatement();
				    ResultSet inner2ResultSet = inner2Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id2 = lectures._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (inner2ResultSet.next()) {
				    	String first2 =  inner2ResultSet.getString("lectures.title");
				    	%>
				        <h6><small><%= first2 %></small></h6>
				   <%
				    }
				    inner2ResultSet.close();
				    inner2Statement.close();

	              %>
            </div>
            </a>
		   <a href="courseContent.jsp?page=<%=resultSet.getString("marks.assignment_id1")%>&&course=<%=resultSet.getString("marks.course_id")%>">
            <div class="notes-sidebar-note">
              <h5>Assignment 1</h5>
               	         <%
	              Statement inner5Statement = connection.createStatement();
				    ResultSet inner5ResultSet = inner5Statement.executeQuery("SELECT assignments.date FROM assignments INNER JOIN marks on assignments._id = marks.assignment_id1 INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (inner5ResultSet.next()) {
				    	String first5 =  inner5ResultSet.getString("assignments.date");
				    	%>
				        <h6><small><%= first5 %></small></h6>
				   <%
				    }
				    inner2ResultSet.close();
				    inner2Statement.close();

	              %>
            </div>
            </a>
            <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id3")%>&&course=<%=resultSet.getString("marks.course_id")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 3</h5>
                <%
	              Statement inner3Statement = connection.createStatement();
				    ResultSet inner3ResultSet = inner3Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id3 = lectures._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (inner3ResultSet.next()) {
				    	String first3 =  inner3ResultSet.getString("lectures.title");
				    	%>
				        <h6><small><%= first3 %></small></h6>
				   <%
				    }
				    inner3ResultSet.close();
				    inner3Statement.close();

	              %>
            </div>
            </a>
            <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id4")%>&&course=<%=resultSet.getString("marks.course_id")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 4</h5>
         <%
	              Statement inner4Statement = connection.createStatement();
				    ResultSet inner4ResultSet = inner4Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id4 = lectures._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (inner4ResultSet.next()) {
				    	String first4 =  inner4ResultSet.getString("lectures.title");
				    	%>
				        <h6><small><%= first4 %></small></h6>
				   <%
				    }
				    inner4ResultSet.close();
				    inner4Statement.close();

	              %>
            </div>
            </a>
    		<a href="courseContent.jsp?page=<%=resultSet.getString("marks.assignment_id2")%>&&course=<%=resultSet.getString("marks.course_id")%>">
            <div class="notes-sidebar-note">
              <h5>Assignment 2</h5>
                       	         <%
	              Statement inner6Statement = connection.createStatement();
				    ResultSet inner6ResultSet = inner6Statement.executeQuery("SELECT assignments.date FROM assignments INNER JOIN marks on assignments._id = marks.assignment_id2 INNER JOIN courses on marks.course_id = courses._id WHERE courses._id ="+ resultSet.getString("marks.course_id")+";");
				    while (inner6ResultSet.next()) {
				    	String first6 =  inner6ResultSet.getString("assignments.date");
				    	%>
				        <h6><small><%= first6 %></small></h6>
				   <%
				    }
				    inner2ResultSet.close();
				    inner2Statement.close();

	              %>
            </div>
            </a>
          </div>
        </div>
        <div class="col-md-10 notes-quickview">
          <div class="form-group notes-quickview-def">
              <div class="col-md-9">
                <h2><%=resultSet.getString("lectures.title") %></h2>
              </div>
              <div class="col-md-3">
                <h5>Lecture <%= num %></h5>
              </div>
              <div class="col-md-9">
                <div class="subject">
                  <h3><%=resultSet.getString("lectures.sub1") %></h3>
                  <p> <%=resultSet.getString("lectures.d1") %>
                  </p>
                </div>
                <div class="subject">
                  <h3><%=resultSet.getString("lectures.sub2") %></h3>
                  <p><%=resultSet.getString("lectures.d2") %>
                  </p>
                </div>
                <div class="subject">
                  <h3><%=resultSet.getString("lectures.sub3") %></h3>
                  <p> <%=resultSet.getString("lectures.d3") %>
                  </p>
                </div>
              </div>
          </div>
        </div>
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
