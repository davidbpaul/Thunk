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
<title>Course Content</title>
<script type='text/javascript'
  src='http://code.jquery.com/jquery-1.9.1.js'></script>
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
    <%

			try{ 
			connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
			statement=connection.createStatement();
			String name2 = (String) session.getAttribute("user");
			System.out.println(name2);
			String num = request.getParameter("page");
			boolean b = false;
			if(b == true){
				
			}else{
				
			}
			String sql2 ="SELECT courses.title, assignments.submitted, assignments.description, assignments.date, assignments.content, marks._id, marks.course_id, marks.lecture_id1,marks.lecture_id2,marks.lecture_id3,marks.lecture_id4, marks.assignment_id1, marks.assignment_id2 FROM marks INNER JOIN assignments on marks.assignment_id"+ request.getParameter("page") +" = assignments._id INNER JOIN courses on marks.course_id = courses._id;";
			
			resultSet = statement.executeQuery(sql2);
			while(resultSet.next()){
				
		%>
  <div class="row">
    <!-- <div class="col-md-12"> -->
      <div class="notes-menu">
        <div class="col-md-8 notes-menu-in">
          <h4 style="margin-left:10px;"><%=resultSet.getString("courses.title") %></h4>
        </div>
        <div class="col-md-4">
       	<button type="button" id="btn-id" class="btn btn-sm btn-success notes-btn notes-btn-save">Submit</button>
        </div>
      </div>
    <!-- </div> -->
  </div>
  <div class="notes-sidebar-outer">
    <div class="container-fluid">
      <div class="row notes-sidebar-middle">
      <div class="col-md-2 notes-sidebar">
          <div class="notes-sidebar-inner">
         	<a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id1")%>">
	            <div class="notes-sidebar-note">
	              <h5>Lesson 1</h5>
	              <%
	              Statement innerStatement = connection.createStatement();
				    ResultSet innerResultSet = innerStatement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id1 = lectures._id INNER JOIN courses on marks.course_id = courses._id;");
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
             <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id2")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 2</h5>
 	         <%
	              Statement inner2Statement = connection.createStatement();
				    ResultSet inner2ResultSet = inner2Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id2 = lectures._id INNER JOIN courses on marks.course_id = courses._id;");
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
		   <a href="courseContent.jsp?page=<%=resultSet.getString("marks.assignment_id1")%>">
            <div class="notes-sidebar-note">
              <h5>Assignment 1</h5>
               	         <%
	              Statement inner5Statement = connection.createStatement();
				    ResultSet inner5ResultSet = inner5Statement.executeQuery("SELECT assignments.date FROM assignments INNER JOIN marks on assignments._id = marks.assignment_id1 INNER JOIN courses on marks.course_id = courses._id;");
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
            <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id3")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 3</h5>
                <%
	              Statement inner3Statement = connection.createStatement();
				    ResultSet inner3ResultSet = inner3Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id3 = lectures._id INNER JOIN courses on marks.course_id = courses._id;");
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
            <a href="courseLectures.jsp?page=<%=resultSet.getString("marks.lecture_id4")%>">
            <div class="notes-sidebar-note">
              <h5>Lesson 4</h5>
         <%
	              Statement inner4Statement = connection.createStatement();
				    ResultSet inner4ResultSet = inner4Statement.executeQuery("SELECT lectures.title FROM marks INNER JOIN lectures on marks.lecture_id4 = lectures._id INNER JOIN courses on marks.course_id = courses._id;");
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
    		<a href="courseContent.jsp?page=<%=resultSet.getString("marks.assignment_id2")%>">
            <div class="notes-sidebar-note">
              <h5>Assignment 2</h5>
                       	         <%
	              Statement inner6Statement = connection.createStatement();
				    ResultSet inner6ResultSet = inner6Statement.executeQuery("SELECT assignments.date FROM assignments INNER JOIN marks on assignments._id = marks.assignment_id2 INNER JOIN courses on marks.course_id = courses._id;");
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
                <h2>Assignment <%=request.getParameter("page")%></h2>
              </div>
              <div class="col-md-3">
              
                <h5 style="color:blue;">Not Marked</h5>
                
                
                <h6>Submission Deadline: <%=resultSet.getString("assignments.date")%></h5>
              </div>
              <div class="col-md-9">
                <p> 
                </p>
              </div>
          </div>
          <div class="form-group notes-quickview-inner">
            <textarea placeholder="Notes..."class="form-control input"></textarea>
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

<script type='text/javascript'>
$(document).ready(function(){
	
    $("#btn-id").click(function(){
    	if($(this).hasClass("btn-success")){
	        $(this).text($(this).text() == 'Submit' ? 'Assignment Has Been Submitted' : 'Submit');
	 /*      	$(this).toggleClass("clicked"); */
	      	$(this).removeClass("btn-success");
	      	$(this).addClass("btn-danger");
    	}else{
    	    $(this).text($(this).text() == 'Submit' ? 'Assignment Has Been Submitted' : 'Submit');
    		 /*      	$(this).toggleClass("clicked"); */
    		      	$(this).removeClass("btn-danger");
    		      	$(this).addClass("btn-success");
    	}  	
    	
    });
});

</script>
</html>
