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
                ResultSet innerNavResultSet = innerNavStatement.executeQuery("SELECT * FROM admins WHERE email='"+ email1 +"';");
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
          <li class="active"><a href="home.jsp"> My Courses</a></li>
     <!--      <li><a href="account.jsp">Account</a></li> -->
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
    src="http://pandiltd.co.uk/wp-content/uploads/2015/05/Untitled-3-e1432109255228-1440x276.jpg">
  </div>
  <div class="container">
    <div class="row">
      <div class="courses">
        <div class="courseIntroDiv">
          <div class="col-md-3">
            <h2 class="courseIntro">
              Marks
            </h2>
          </div>
        </div>

          <div class="focusPoint">
            <div class="col-md-10 col-md-offset-1">
              <div class="loginOuterEdit">
                <div class="loginPadding">
                  <div class="signInHeader">
                    <h1 class="signInHeaderFont">Assignment 1</h1>
                  </div>
                  <div class="accountContent">
                    <div class="loginTop">
                      <div class="loginForm col-md-10 col-md-offset-1">
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
                                int parced =  Integer.parseInt(num);
                                if(parced > 4){
                                  if(parced % 4 == 3){
                                    num = "1";
                                  }else if(parced % 4 == 2){
                                    num = "2";
                                  }else if(parced % 4 == 1){
                                    num = "3";
                                  }else if(parced % 4 == 0){
                                    num = "4";
                                  }
                                }
                              }

                              String sql2 ="SELECT * FROM submitted INNER JOIN marks ON submitted.assignment_id = marks.assignment_id1 INNER JOIN users ON submitted.user_id = users._id WHERE marks.course_id ="+courseId+";";

                              resultSet = statement.executeQuery(sql2);
                              while(resultSet.next()){

                            %>



      <a href="marking.jsp?course=<%=courseId%>&&us=<%=resultSet.getString("submitted.user_id")%>&&as=<%=resultSet.getString("submitted.assignment_id")%>">
        <div class="panel panel-default">
          <div class="panel-body">
            <div class="row">
              <div class="col-md-4">
                <%=resultSet.getString("users.name") %>
              </div>
              <div class="col-md-4">
                <%=resultSet.getString("users.email") %>
              </div>
                <div class="col-md-4">
                <%=resultSet.getString("submitted.mark") %>
              </div>
            </div>
          </div>
        </div>
       </a>



          	<%
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

                      </div>
                      <div class="row">
                        <div class="registerLoginForm col-md-10 col-md-offset-1">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="loginBottomEdit">
                  <div class="col-md-2">
                    <a href="home.jsp"><button type="submit" class=" btn-top btn btn-block btn-default">Back</button>
                  </div>
                  <div class="col-md-10 b-text">
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="focusPoint">
            <div class="col-md-10 col-md-offset-1">
              <div class="loginOuterEdit">
                <div class="loginPadding">
                  <div class="signInHeader">
                    <h1 class="signInHeaderFont">Assignment 2</h1>
                  </div>
                  <div class="accountContent">
                    <div class="loginTop">
                      <div class="loginForm col-md-10 col-md-offset-1">
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
                                int parced =  Integer.parseInt(num);
                                if(parced > 4){
                                  if(parced % 4 == 3){
                                    num = "1";
                                  }else if(parced % 4 == 2){
                                    num = "2";
                                  }else if(parced % 4 == 1){
                                    num = "3";
                                  }else if(parced % 4 == 0){
                                    num = "4";
                                  }
                                }
                              }

                              String sql2 ="SELECT * FROM submitted INNER JOIN marks ON submitted.assignment_id = marks.assignment_id2 INNER JOIN users ON submitted.user_id = users._id WHERE marks.course_id ="+courseId+";";

                              resultSet = statement.executeQuery(sql2);
                              while(resultSet.next()){

                            %>



      <a href="marking.jsp?course=<%=courseId%>&&us=<%=resultSet.getString("submitted.user_id")%>&&as=<%=resultSet.getString("submitted.assignment_id")%>">
        <div class="panel panel-default">
          <div class="panel-body">
            <div class="row">
              <div class="col-md-4">
                <%=resultSet.getString("users.name") %>
              </div>
              <div class="col-md-4">
                <%=resultSet.getString("users.email") %>
              </div>
                <div class="col-md-4">
                <%=resultSet.getString("submitted.mark") %>
              </div>
            </div>
          </div>
        </div>
       </a>



          	<%
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

                      </div>
                      <div class="row">
                        <div class="registerLoginForm col-md-10 col-md-offset-1">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="loginBottomEdit">
                  <div class="col-md-2">
                    <a href="home.jsp"><button type="submit" class=" btn-top btn btn-block btn-default">Back</button>
                  </div>
                  <div class="col-md-10 b-text">
                  </div>
                </div>
              </div>
            </div>
          </div>




</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="Javascript/lib/bootstrap.js"></script>
</html>
