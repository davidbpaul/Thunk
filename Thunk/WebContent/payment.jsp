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
<title>Payment</title>
<!-- Bootstrap core CSS -->
  <link href="Style/lib/bootstrap.css" rel="stylesheet">

  <!-- font-awesome -->
  <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

 <!-- Custom styles for this template -->
 <link href="Style/app.css" rel="stylesheet">
</head>
<body class="loginbody">
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
		<div class="focusPoint">
      <div class="col-md-6 col-md-offset-3">
        <div class="loginOuter">
          <div class="loginPadding">
            <div class="signInHeader">
              <h1 class="signInHeaderFont">Checkout</h1>
              <p class="secure"><i class="fa fa-lock" aria-hidden="true"></i> Secure</p>
            </div>
            <div class="accountContent">
              <div class="loginTop">
                <div class="loginForm col-md-10 col-md-offset-1">
                  <!-- <div class="row" style="padding:20px; margin-top:10px;">
                    <div style="margin:auto;">
                      <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
                        <input type="hidden" name="cmd" value="_s-xclick">
                        <input type="hidden" name="hosted_button_id" value="6RNT8A4HBBJRE">
                        <input type="image"
                  src="https://www.sandbox.paypal.com/en_US/i/btn/btn_buynowCC_LG.gif"
                  border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                        <img alt="" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif"
                  width="1" height="1">
                      </form>
                    </div>
                  </div> -->
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
                  <form action="Payment" method="post">

                    <div class="form-group">
                      <input readonly name="name"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
                    </div>


                    <%
                    Statement innerStatement = connection.createStatement();
                    ResultSet innerResultSet = innerStatement.executeQuery("SELECT * FROM courses WHERE _id =" + request.getParameter("page") + ";");
                    while (innerResultSet.next()) {
                      String first =  innerResultSet.getString("_id");
                      String secound =  innerResultSet.getString("price");
                      %>

                  <div class="form-group">
                    <input readonly name="course"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%= first %>">
                  </div>
                  <div class="form-group">
                    <input readonly name="price"type="text" style="display: none" class="form-control" id="exampleInputEmail1" value="<%= secound %>">
                  </div>

                    <%
                     }
                     innerResultSet.close();
                     innerStatement.close();

                         %>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Credit Card Number</label>
                      <input name="credit"type="text" class="form-control" id="exampleInputEmail1" placeholder="Credit">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Security Number</label>
                      <input name="security"type="text" class="form-control" id="exampleInputPassword1" placeholder="Security">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Expiration Date</label>
                      <input name="date"type="text" class="form-control" id="exampleInputPassword1" placeholder="Date">
                    </div>
                    <div class="col-md-4 col-md-offset-8">
                      <button name="Checkout" type="submit" class="btn-lg btn-block btn-primary">Buy</button>
                    </div>
                  </form>
                  <%
                }

                } catch (Exception e) {
                e.printStackTrace();
                }
                %>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="bottomNav clearfix">
          <div class="foot">
            <p>The Thunk Online School uses industry-standard encryption to protect the confidentiality of the information you submit. Learn more about our Security Policy.<p>
          </div>
          <footer class="footUnder">
            <p>Copyright © 2017 Thunk School All rights reserved.</p>
          </footer>
        </div>
      </div>
		</div>
  <!-- }

  } catch (Exception e) {
  e.printStackTrace();
  }
  %> -->
	</body>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="Javascript/lib/bootstrap.js"></script>
</html>
