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
<!-- Bootstrap core CSS -->
  <link href="Style/lib/bootstrap.css" rel="stylesheet">

  <!-- font-awesome -->
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="Style/app.css" rel="stylesheet">
<title>New</title>
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
       <!--     <li><a href="account.jsp">Account</a></li> -->
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
      String num = request.getParameter("as");
			String name = (String) session.getAttribute("user");
			System.out.println(name);
			String sql ="SELECT * FROM marks WHERE course_id="+ request.getParameter("course")+";";

			resultSet = statement.executeQuery(sql);
			while(resultSet.next()){
        int parced = Integer.parseInt(num);
        int first =  Integer.parseInt(resultSet.getString("marks.assignment_id1"));
        int secound =  Integer.parseInt(resultSet.getString("marks.assignment_id2"));
        if(parced == first){
          num = "1";
        }else if(parced == secound){
          num = "2";
        }
        System.out.println("first " + first);
        System.out.println("secound " + secound);

		%>

  <div class="focusPoint">
    <div class="col-md-10 col-md-offset-1">
      <div class="loginOuterCourseAssignment">
        <div class="loginPadding">
          <div class="signInHeader">
            <h1 class="signInHeaderFont">Assignment <%=num%></h1>
          </div>
          <div class="accountContent">
            <div class="loginTop">
              <div class="loginForm col-md-10 col-md-offset-1">
                <form action="DescriptionMaker" method="post">
                  <div class="col-md-4 col-md-offset-8">
                    <button name="update" type="submit" class="btn btn-block btn-success">Save</button>
                  </div>


                  <%

                  Statement innerSubStatement = connection.createStatement();
                  String e = (String) session.getAttribute("user");
                  ResultSet innerSubResultSet = innerSubStatement.executeQuery("SELECT assignments.date, assignments.description FROM assignments INNER JOIN marks ON assignments._id = marks.assignment_id"+ num +" WHERE marks.course_id="+request.getParameter("course")+";");
              while (innerSubResultSet.next()) {
                String con = innerSubResultSet.getString("assignments.description");
                String da = innerSubResultSet.getString("assignments.date");

                %>
                    <%
                    if(con != null){
                    %>
                    <div class="form-group">
                      <input readonly name="_id"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
                      <input readonly name="course"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("course")%>">
                      <input readonly name="as"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("as")%>">
                    </div>
                    <div class="form-group">

                      <label for="exampleInputEmail1">Due Date: </label>
                      <input name="Date"class="form-control" placholder="Date" value="<%=da%>">

                     </div>
                     <div class="form-group">

                              <label for="exampleInputEmail1">Description <%=request.getParameter("as")%></label>
                                <textarea name="Description1"class="form-control" rows="5" id="comment" placholder="Update Assignment"><%= con %></textarea>


                               </div>
                  <%
                }else{

                  %>
                  <div class="form-group">
                    <input readonly name="_id"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
                    <input readonly name="course"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("course")%>">
                    <input readonly name="as"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("as")%>">
                  </div>
                  <div class="form-group">

                    <label for="exampleInputEmail1">Due Date: </label>
                    <input name="Date"class="form-control" placholder="Date">

                   </div>
                   <div class="form-group">

                            <label for="exampleInputEmail1">Description <%=request.getParameter("as")%></label>
                              <textarea name="Description1"class="form-control" rows="5" id="comment" placholder="Update Assignment"></textarea>


                             </div>
                  <%
                                    }
                  %>
             <%
              }
              innerSubResultSet.close();
              innerSubStatement.close();

                  %>



                </form>
              </div>
              <div class="row">
                <div class="registerLoginForm col-md-10 col-md-offset-1">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="loginBottom">
          <div class="col-md-2">
            <a href="home.jsp"><button type="submit" class=" btn-top btn btn-block btn-default">Back</button>
          </div>
          <div class="col-md-10 b-text">
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
