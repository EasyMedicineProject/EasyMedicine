<%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/9/2018
  Time: 12:12 AM
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
<div class="container"  style="padding:200px 0px 0px 0px">
    <div class="row">
        <div class="col-md-3 col-xs-3"></div>
        <div class="col-md-6 col-xs-6">
            <div class="testboxRegister">
                <h1>EASY MEDICINE</h1>

                <form action="login" method="POST">
                    <hr/>
                    <p style="margin-left:65px">Регистрация</p>
                    <hr/>
                    <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
                    <input type="text" name="email" id="email" placeholder="Имейл" required/>
                    <label id="icon" for="username"><i class="fa fa-user"></i></label>
                    <input type="text" name="username" id="username" placeholder="Потребителско име" required/>
                    <label id="icon" for="password"><i class="fa fa-key"></i></label>
                    <input type="password" name="password" id="password" placeholder="Парола" required/>
                    <div class="gender">
                        <input type="radio" value="m" id="male" name="gender" checked/>
                        <label for="male" class="radio" chec>Мъж</label>
                        <input type="radio" value="f" id="female" name="gender" />
                        <label for="female" class="radio">Жена</label>
                    </div>
                    <button class="button" type="submit"> Регистрирай се</button>
                </form>
            </div>
        </div>
        <div class="col-md-3 col-xs-3" style="padding-top:12%; left:-13%;">
            <%
                boolean hasAlreadyAccount = false;
                if(session.getAttribute("invalidRegistration")!=null){
                    if ((Boolean) session.getAttribute("invalidRegistration"))  {
                        System.out.println("IN IF 1");
                        hasAlreadyAccount=true;
            %>


            <div class="speech-bubble" style="color:#af2f18;margin-bottom:17px;">Вече има потребител със такова потребителско име или имейл</div>


            <% session.removeAttribute("invalidRegistration");}

            }
            %>

        <%

            if(session.getAttribute("shortPassword")!=null){
                if ((Boolean) session.getAttribute("shortPassword"))  {
        if(!hasAlreadyAccount){
            System.out.println("IN IF 2");%>
        <div style="margin-top:170px;left:-13%;"><%hasAlreadyAccount=false;}
        else{
            System.out.println("IN ELSE 2");%>
            <div style="left:-13%;">
            <%}%>
            <div class="speech-bubble" style="color:#af2f18">Паролата трябва да е минимум 6 символа</div>
        </div>
        <%  session.removeAttribute("shortPassword");
                }

        }
        %>
        </div>
    </div>
</div>
</body>
</html>
</body>
</html>
