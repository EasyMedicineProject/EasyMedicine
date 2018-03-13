<%@ page import="java.awt.*" %><%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/6/2018
  Time: 6:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="css/RegisterStyle.css">
    <link rel="stylesheet" type="text/css" href="css/VideoStyle.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        window.addEventListener("pageshow", function (event) {
            if (event.persisted) {
                window.location.replace("http://"+window.location.href.split('/')[2]+"/index.jsp");

            }
        });
    </script>
</head>
<body>
<video id="bgvid" playsinline autoplay muted loop>
    <source src="videos/registerBackground.mp4" type="video/mp4">
</video>
<div class="container" style="padding:200px 0px 0px 0px">
    <div class="row">
        <div class="col-md-3 col-xs-0"></div>
        <div class="col-md-6 col-xs-12">
            <div class="testboxLogin">
                <h1>EASY MEDICINE</h1>
                <form action="index" method="POST">
                    <hr/>
                    <p style="margin-left:65px">Вход</p>
                    <hr/>
                    <label id="icon" for="email"><i class="fa fa-user"></i></label>
                    <input type="text" name="email" id="email" placeholder="Username или имейл" required/>
                    <label id="icon" for="passwоrd"><i class="fa fa-key"></i></label>
                    <input type="password" name="password" id="passwоrd" placeholder="Парола" required/>
                    <label class="containerCheckbox" for="rememberMe">&nbsp;&nbsp;&nbsp;&nbsp;Запомни ме
                        <br/><input type="checkbox" name="rememberMe" id="rememberMe"/>
                        <span class="checkmark"></span>
                    </label>
                    <button class="button" type="submit"> Влез</button>
                    <a id="noRegistration" href="/registration.jsp"><label for="noRegistration">Нямате регистрация?</label></a>
                </form>
            </div>
        </div>
        <%
            System.out.println("hasFailedLogin = " + session.getAttribute("hasFailedLogin")) ;
            if(session.getAttribute("hasFailedLogin")!=null){
            if((Boolean) session.getAttribute("hasFailedLogin")){
        %><div class="col-md-3 col-xs-12" style="padding-top:15%; left:-13%;">
            <div class="speech-bubble" style="color:#af2f18">Грешно потребителско име или парола</div>
        </div>
            <%}}%>
    </div>
</div>

<%
    if(session.getAttribute("isLogged")!= null) {
        if ((Boolean) session.getAttribute("isLogged")) {
            response.sendRedirect("/index.jsp");
        }
        else{%>
    <p>greshna parola ili email</p>

    <%}
    }%>
</div>
</body>
</html>
