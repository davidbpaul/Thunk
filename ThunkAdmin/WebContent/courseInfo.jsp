
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
     String num = request.getParameter("lec");
     String name = (String) session.getAttribute("user");
     System.out.println(name);
     String sql ="SELECT * FROM marks WHERE course_id="+ request.getParameter("course")+";";

     resultSet = statement.executeQuery(sql);
     while(resultSet.next()){
       int parced = Integer.parseInt(num);
       int first =  Integer.parseInt(resultSet.getString("marks.lecture_id1"));
       int secound =  Integer.parseInt(resultSet.getString("marks.lecture_id2"));
       int third =  Integer.parseInt(resultSet.getString("marks.lecture_id3"));
       int fourth =  Integer.parseInt(resultSet.getString("marks.lecture_id4"));
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


   %>

  <div class="focusPoint">
    <div class="col-md-10 col-md-offset-1">
      <div class="loginOuterInfo">
        <div class="loginPadding">
          <div class="signInHeader">
            <h1 class="signInHeaderFont">Lecture <%=request.getParameter("lec") %></h1>
          </div>
          <div class="accountContent">
            <div class="loginTop">
              <div class="loginForm col-md-10 col-md-offset-1">
                <form action="LectureMaker" method="post">
                  <%

                  Statement innerSubStatement = connection.createStatement();
                  String e = (String) session.getAttribute("user");

                  ResultSet innerSubResultSet = innerSubStatement.executeQuery("SELECT * FROM lectures INNER JOIN marks ON lectures._id = marks.lecture_id"+ num +" WHERE marks.course_id="+request.getParameter("course")+";");
              while (innerSubResultSet.next()) {
                String titl = innerSubResultSet.getString("lectures.title");
                String sub1 = innerSubResultSet.getString("lectures.sub1");
                String d1 = innerSubResultSet.getString("lectures.d1");

                String sub2 = innerSubResultSet.getString("lectures.sub2");
                String d2 = innerSubResultSet.getString("lectures.d2");

                String sub3 = innerSubResultSet.getString("lectures.sub3");
                String d3 = innerSubResultSet.getString("lectures.d3");

                %>
                    <%
                    if(titl != null){
                    %>
                    <div class="col-md-4 col-md-offset-8">
                      <button name="update" type="submit" class="btn btn-block btn-success">Save</button>
                    </div>
                    <div class="form-group">
                      <input readonly name="_id"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
                      <input readonly name="course"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("course")%>">
                      <input readonly name="lec"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("lec")%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Title</label>
                      <input name="title"type="text" class="form-control" id="exampleInputEmail1" value="<%=titl%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Subject 1</label>
                      <input name="Subject1"type="text" class="form-control" id="exampleInputEmail1" value="<%=sub1%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Description 1</label>
                        <textarea name="Description1"class="form-control" rows="5" id="comment"><%=d1%></textarea>
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Subject 2</label>
                      <input name="Subject2"type="text" class="form-control" id="exampleInputEmail1"  value="<%=sub2%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Description 2</label>
                        <textarea name="Description2"class="form-control" rows="5" id="comment"><%=d2%></textarea>
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Subject3</label>
                      <input name="Subject3"type="text" class="form-control" id="exampleInputEmail1" value="<%=sub3%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Description 3</label>
                        <textarea name="Description3"class="form-control" rows="5" id="comment"><%=d3%></textarea>
                    </div>

                  <%
                }else{

                  %>
                  <div class="col-md-4 col-md-offset-8">
                    <button name="update" type="submit" class="btn btn-block btn-success">Save</button>
                  </div>
                  <div class="form-group">
                    <input readonly name="_id"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
                    <input readonly name="course"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("course")%>">
                    <input readonly name="lec"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("lec")%>">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Title</label>
                    <input name="title"type="text" class="form-control" id="exampleInputEmail1" >
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Subject 1</label>
                    <input name="Subject1"type="text" class="form-control" id="exampleInputEmail1" >
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Description 1</label>
                      <textarea name="Description1"class="form-control" rows="5" id="comment"></textarea>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Subject 2</label>
                    <input name="Subject2"type="text" class="form-control" id="exampleInputEmail1" >
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Description 2</label>
                      <textarea name="Description2"class="form-control" rows="5" id="comment"></textarea>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Subject3</label>
                    <input name="Subject3"type="text" class="form-control" id="exampleInputEmail1" >
                  </div>
                  <div class="form-group">
                    <label for="exampleInputEmail1">Description 3</label>
                      <textarea name="Description3"class="form-control" rows="5" id="comment"></textarea>
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
%> <div class="focusPoint">
    <div class="col-md-10 col-md-offset-1">
      <div class="loginOuterInfo">
        <div class="loginPadding">
          <div class="signInHeader">
            <h1 class="signInHeaderFont">Lecture <%=request.getParameter("lec") %></h1>
          </div>
          <div class="accountContent">
            <div class="loginTop">
              <div class="loginForm col-md-10 col-md-offset-1">
      <form action="LectureMaker" method="post">
  <div class="col-md-4 col-md-offset-8">
    <button name="update" type="submit" class="btn btn-block btn-success">Save</button>
  </div>
  <div class="form-group">
    <input readonly name="_id"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=resultSet.getString("_id") %>">
    <input readonly name="course"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("course")%>">
    <input readonly name="lec"type="text" class="form-control hidden" id="exampleInputEmail1" value="<%=request.getParameter("lec")%>">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Title</label>
    <input name="title"type="text" class="form-control" id="exampleInputEmail1" >
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Subject 1</label>
    <input name="Subject1"type="text" class="form-control" id="exampleInputEmail1" >
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Description 1</label>
      <textarea name="Description1"class="form-control" rows="5" id="comment"></textarea>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Subject 2</label>
    <input name="Subject2"type="text" class="form-control" id="exampleInputEmail1" >
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Description 2</label>
      <textarea name="Description2"class="form-control" rows="5" id="comment"></textarea>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Subject3</label>
    <input name="Subject3"type="text" class="form-control" id="exampleInputEmail1" >
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Description 3</label>
      <textarea name="Description3"class="form-control" rows="5" id="comment"></textarea>
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
  %>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="Javascript/lib/bootstrap.js"></script>
</html>
