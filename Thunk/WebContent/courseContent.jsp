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
              int first =  Integer.parseInt(innerParamResultSet.getString("marks.assignment_id1"));
              int secound =  Integer.parseInt(innerParamResultSet.getString("marks.assignment_id2"));
              if(parced == first){
                num = "1";
              }else if(parced == secound){
                num = "2";
              }
              System.out.println("first " + first);
              System.out.println("secound " + secound);
            }
            System.out.println("num " + num);
         
            innerParamResultSet.close();
            innerParamStatement.close();



        }
  			boolean b = false;
  			if(b == true){

  			}else{

  			}
  			String sql2 ="SELECT courses.title, assignments._id,assignments.description, assignments.date, assignments.content, marks._id, marks.course_id, marks.lecture_id1,marks.lecture_id2,marks.lecture_id3,marks.lecture_id4, marks.assignment_id1, marks.assignment_id2 FROM marks INNER JOIN assignments on marks.assignment_id"+ num +" = assignments._id INNER JOIN courses on marks.course_id = courses._id WHERE courses._id="+ courseId +";";

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
            <%

            Statement innertStatement = connection.createStatement();
            String t = (String) session.getAttribute("user");
            ResultSet innertResultSet = innertStatement.executeQuery("SELECT submitted._id, submitted.mark, submitted.user_id,submitted.assignment_id, submitted.date,submitted.content FROM submitted INNER JOIN users On submitted.user_id = users._id  INNER JOIN assignments ON submitted.assignment_id = assignments._id WHERE users.email = '"+ t +"'  AND assignments._id = '" + resultSet.getString("assignments._id") + "';");

            while (innertResultSet.next()) {
              if(innertResultSet != null){
              %>
                  <input id="save"form="usrform" disabled class="btn btn-sm btn-danger notes-btn notes-btn-save" type="submit" value="Submitted" name="submit" />
              <%
            }
             }
             innertResultSet.close();
             innertStatement.close();

                 %>
                  <input id="btn-id" form="usrform" class="btn btn-sm btn-success notes-btn notes-btn-save" type="submit" value="Submit" name="submit" />
            <form action="Submit" method="post" id="usrform">

                <!-- <button name="submit"   type="button"  type="submit" id="btn-id" class="btn btn-sm btn-success notes-btn notes-btn-save">Submit</button> -->
               <%
                      Statement innerSStatement = connection.createStatement();
                      String n = (String) session.getAttribute("user");
                      ResultSet innerSResultSet = innerSStatement.executeQuery("SELECT * FROM users WHERE email='" + n + "';");

                      while (innerSResultSet.next()) {
                        String first =  innerSResultSet.getString("_id");
                        %>
              <div class="form-group">
                <input readonly name="page"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%= request.getParameter("page")  %>">
              </div>
              <div class="form-group">
                <input readonly name="course"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%= request.getParameter("course")  %>">
              </div>
              <div class="form-group">
                <input readonly name="user_id"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%= first  %>">
              </div>
              <div class="form-group">
                <input readonly name="assignment_id"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%=resultSet.getString("assignments._id") %>">
              </div>
              <%
               }
               innerSResultSet.close();
               innerSStatement.close();

                   %>
            </form>

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
                  <h2>Assignment <%= num %></h2>
                </div>
                <div class="col-md-3">
                  <%

                  Statement innerSub2Statement = connection.createStatement();
                  String e2 = (String) session.getAttribute("user");
                  ResultSet innerSub2ResultSet = innerSub2Statement.executeQuery("SELECT submitted._id, submitted.mark, submitted.user_id,submitted.assignment_id, submitted.date,submitted.content FROM submitted INNER JOIN users On submitted.user_id = users._id  INNER JOIN assignments ON submitted.assignment_id = assignments._id WHERE users.email = '"+ e2 +"'  AND assignments._id = '" + resultSet.getString("assignments._id") + "';");

              while (innerSub2ResultSet.next()) {
                String con2 = innerSub2ResultSet.getString("submitted.mark");

                    if(con2 != null){
                    %>
                    <h5 style="color:blue;"><%= con2 %></h5>
                  <%
                }else{

                  %>
                      <h5 style="color:blue;">Not Marked</h5>
                  <%
                                    }

              }
              innerSub2ResultSet.close();
              innerSub2Statement.close();

                  %>



                  <h6>Submission Deadline: <%=resultSet.getString("assignments.date")%></h5>
                </div>
                <div class="col-md-9">
                  <p>
                    <%=resultSet.getString("assignments.description")%>
                  </p>
                </div>
            </div>
            <div class="form-group notes-quickview-inner">
              <%

              Statement innerSubStatement = connection.createStatement();
              String e = (String) session.getAttribute("user");
              ResultSet innerSubResultSet = innerSubStatement.executeQuery("SELECT submitted._id, submitted.mark, submitted.user_id,submitted.assignment_id, submitted.date,submitted.content FROM submitted INNER JOIN users On submitted.user_id = users._id  INNER JOIN assignments ON submitted.assignment_id = assignments._id WHERE users.email = '"+ e +"'  AND assignments._id = '" + resultSet.getString("assignments._id") + "';");

          while (innerSubResultSet.next()) {
            String con = innerSubResultSet.getString("submitted.content");

            %>
                <%
                if(con != null){
                %>
                <textarea name="content" form="usrform" placeholder="Notes..."class="form-control input" type="text"><%= con %></textarea>
              <%
            }else{

              %>
               <textarea name="content"  form="usrform" placeholder="Notes..."class="form-control input" type="text"></textarea>
              <%
                                }
              %>
         <%
          }
          innerSubResultSet.close();
          innerSubStatement.close();

              %>
              <textarea name="content" form="usrform" placeholder="Notes..."class="form-control input" type="text"></textarea>
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

    //jquery
    if($('#save').length){
        //your code goes here
    	 $("#btn-id").addClass( "hidden" );
    }
});

</script>
</html>
