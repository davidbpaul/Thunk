<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
		 <!-- Bootstrap core CSS -->
   		 <link href="Style/lib/bootstrap.css" rel="stylesheet">

   		 <!-- font-awesome -->
   		 <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

		  <!-- Custom styles for this template -->
		  <link href="Style/app.css" rel="stylesheet">
</head>
<body class="loginbody">
		<nav class="navbar navbar-inverse">
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
          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="login.jsp">Login</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->

		</nav>
		<div class="focusPoint">
      <div class="col-md-6 col-md-offset-3">
        <div class="loginOuter">
          <div class="loginPadding">
            <div class="signInHeader">
              <h1 class="signInHeaderFont">Admin Sign In</h1>
              <p class="secure"><i class="fa fa-lock" aria-hidden="true"></i> Secure</p>
            </div>
            <div class="accountContent">
              <div class="loginTop">
                <div class="loginForm col-md-10 col-md-offset-1">
                  <form action="AdminLogin" method="post">
                    <div class="form-group">
                      <label for="exampleInputEmail1">Email address</label>
                      <input name="email"type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Password</label>
                      <input name="password"type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                    </div>
                    <div class="col-md-8">
                      <span><p>Forgot Password?</p><a> Reset it.</a></span>
                    </div>
                    <div class="col-md-4">
                      <input name="Login" type="submit" class="btn-lg btn-block btn-primary" value="Login"></input>
                    </div>
                  </form>
                </div>
                <div class="row">
                  <div class="registerLoginForm col-md-10 col-md-offset-1">
                    <span><p class="LoginToRegister">Don't have an account?</p><a href="registration.jsp"> Contact us.</a></span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="loginBottom">
            <div class="col-md-2">
              <a href="registration.jsp"><button type="submit" class=" btn-top btn btn-block btn-default">Back</button></a>
            </div>
            <div class="col-md-10 b-text">
              <p>Questions? Just ask <i class="fa fa-phone" aria-hidden="true"></i> 1800-Demo-Is-Real</p>
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
	</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
     <script src="Javascript/lib/bootstrap.js"></script>
</html>
