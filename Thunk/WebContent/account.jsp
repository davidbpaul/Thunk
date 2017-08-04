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
<title>Account</title>
</head>
<body>
  <nav class="navbar navbar-inverse">
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
			String name = (String) session.getAttribute("user");
			System.out.println(name);
			String sql ="SELECT * FROM users WHERE email='" + name + "';";
			
			resultSet = statement.executeQuery(sql);
			while(resultSet.next()){
		%>
  
  <div class="focusPoint">
    <div class="col-md-10 col-md-offset-1">
      <div class="loginOuterAccount">
        <div class="loginPadding">
          <div class="signInHeader">
            <h1 class="signInHeaderFont">Account</h1>
          </div>
          <div class="accountContent">
            <div class="loginTop">
              <div class="loginForm col-md-10 col-md-offset-1">
                <form action="Account" method="post">
                  <div class="col-md-4 col-md-offset-8">
                    <button name="update" type="submit" class="btn btn-block btn-success">Update</button>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Name</label>
                    <input name="name"type="text" class="form-control" id="exampleInputEmail1" value="<%=resultSet.getString("name") %>">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Email address</label>
                    <input readonly name="email"type="email" class="form-control" id="exampleInputEmail1" value="<%=resultSet.getString("email") %>">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Password *******</label>
                        <button name="passwordChange" type="submit" class="btn btn-primary">Change</button>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">City</label>
                    <input name="city"type="text" class="form-control" id="exampleInputPassword1" value="<%=resultSet.getString("city") %>">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Address</label>
                    <input name="address"type="text" class="form-control" id="exampleInputPassword1" value="<%=resultSet.getString("address") %>">
                  </div>
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
            <button type="submit" class=" btn-top btn btn-block btn-default">Back</button>
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
