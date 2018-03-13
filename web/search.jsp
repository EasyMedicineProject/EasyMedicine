<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Medicament" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.lang.Class" %>
<%@ page import="Models.Commentary" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<%@ page import="Models.LoginModel" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.IOException" %>
<%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/18/2018
  Time: 6:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html id="background">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet"type="text/css" href="css/rating.css"/>
    <link rel="stylesheet" type="text/css" href="css/buttonA.css"/>
    <link rel="stylesheet" type="text/css" href="css/MainStyle.css"/>
    <link rel="stylesheet" type="text/css" href="css/LoginStyle.css"/>
    <link rel="stylesheet" type="text/css" href="css/NewNavbar.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Easy Medicine</title>
    <meta charset = "UTF-8"/>
    <script src="scrollbar.js"></script>
</head>
<body>
<script type="text/javascript">
    $(
        function()
        {
            var hash = window.location.hash;
            hash && $( 'ul.nav a[href="' + hash + '"]' ).tab( 'show' );

            $( '.tab-links' ).click
            (
                function( e )
                {
                    $( this ).tab( 'show' );

                    var scrollmem = $( 'body' ).scrollTop() || $( 'html' ).scrollTop();
                    window.location.hash = this.hash;
                    $( 'html,body' ).scrollTop( scrollmem );

                    $( 'ul.nav-tabs a[href="' + window.location.hash + '"]' ).tab( 'show' );
                }
            );
        }
    );
</script>
<script type="text/javascript">
    window.addEventListener("pageshow", function (event) {
        sessionStorage.SessionName = "session";
        var currentPosition = sessionStorage.getItem("scrollPosition");
        window.scrollTo(0, currentPosition);
        sessionStorage.removeItem("scrollPosition");
        var i = 1;
        while(document.getElementById("commentsFieldMedicaments-" + i)!=null){
            var element = document.getElementById("commentsFieldMedicaments-" + i);
            element.scrollTo(0, element.scrollHeight);
            i++;
        }


    });

</script>
<script type="text/javascript">
        function herbTreatmentTabClick(){
            var i = 1;
            while(document.getElementById("commentsFieldHerbs-" + i)!=null){
                var element = document.getElementById("commentsFieldHerbs-" + i);
                element.scrollTo(0, 200);
                i++;
            }
        }
</script>
<header>
    <!--<div class="row">
        <div class="col-lg-12">-->
    <nav class="nav-xbootstrap navbar navbar-default visible-xs-block" id="navigation">
        <div class="container">
            <div class="navbar-header">
                <a href="/index.jsp"><img class="logo-navbar" src="images/EM%20logo.png"></a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav nav-test">
                    <!--<li class="nav-item navigation" style="color:white;"><a href="#">Начало</a></li>-->
                    <li id="symptoms" class="dropdown nav-item navigation">
                        <a href="#">
                            <!--<span class="glyphicon glyphicon-grain"></span>--> Симптоми <span class="caret"></span>
                        </a>
                        <ul class="dropdown multi-column columns-3" role="button">
                            <div class="row">
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Безсъние"><span class=""></span>Безсъние</a></li>
                                        <li><a href="/search?search=Белези"><span class=""></span>Белези</a></li>
                                        <li><a href="/search?search=Болки в корема"><span class=""></span>Болки в корема</a></li>
                                        <li><a href="/search?search=Болки в мускулите"><span class=""></span>Болки в мускулите</a></li>
                                        <li><a href="/search?search=Болки в областта на лицето"><span class=""></span>Болки в областта на лицето</a></li>
                                        <li><a href="/search?search=Болки в ставите"><span class=""></span>Болки в ставите</a></li>
                                        <li><a href="/search?search=Болки в ушите"><span class=""></span>Болки в ушите</a></li>
                                        <li><a href="/search?search=Висока температура"><span class=""></span>Висока температура</a></li>
                                        <li><a href="/search?search=Възпалено и болезнено гърло"><span class=""></span>Възпалено и болезнено гърло</a></li>
                                        <li><a href="/search?search=Гадене"><span class=""></span>Гадене</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Газове"><span class=""></span>Газове</a></li>
                                        <li><a href="/search?search=Главоболие"><span class=""></span>Главоболие</a></li><li><a href="/search?search=Дразнене на гърлото"><span class=""></span>Дразнене на гърлото</a></li>
                                        <li><a href="/search?search=Запек"><span class=""></span>Запек</a></li>
                                        <li><a href="/search?search=Запушен нос"><span class=""></span>Запушен нос</a></li>
                                        <li><a href="/search?search=Запушени уши"><span class=""></span>Запушени уши</a></li>
                                        <li><a href="/search?search=Зачервена кожа"><span class=""></span>Зачервена кожа</a></li>
                                        <li><a href="/search?search=Кашлица"><span class=""></span>Кашлица</a></li>
                                        <li><a href="/search?search=Липса на концентрация"><span class=""></span>Липса на концентрация</a></li>
                                        <li><a href="/search?search=Лошо храносмилане"><span class=""></span>Лошо храносмилане</a></li>

                                    </ul>
                                </div>
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Намалено обоняние"><span class=""></span>Намалено обоняние</a></li>
                                        <li><a href="/search?search=Нервност"><span class=""></span>Нервност</a></li>
                                        <li><a href="/search?search=Повръщане"><span class=""></span>Повръщане</a></li>
                                        <li><a href="/search?search=Пърхот"><span class=""></span>Пърхот</a></li>
                                        <li><a href="/search?search=Секреция от носа"><span class=""></span>Секреция от носа</a></li>
                                        <li><a href="/search?search=Сухи и уморени очи"><span class=""></span>Сухи и уморени очи</a></li>
                                        <li><a href="/search?search=Сърбеж на кожата"><span class=""></span>Сърбеж на кожата</a></li>
                                        <li><a href="/search?search=Чувство на умора"><span class=""></span>Чувство на умора</a></li>
                                    </ul>
                                </div>
                            </div>
                        </ul>
                    </li>

                    <li class="dropdown nav-item navigation">
                        <a href="#" role="button">
                            Болести <span class="caret"></span>
                        </a>

                        <ul class="dropdown multi-column columns-2" role="button">
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="dropdown multi-column-dropdown diseases">
                                        <li><a href="/search?search=Грип"><span class=""></span>Грип</a></li>
                                        <li><a href="/search?search=Зависимост от тютюнопушене"><span class=""></span>Зависимост от тютюнопушене</a></li>
                                        <li><a href="/search?search=Изпотяване"><span class=""></span>Изпотяване</a></li>
                                        <li><a href="/search?search=Косопад"><span class=""></span>Косопад</a></li>
                                        <li><a href="/search?search=Липса на апетит"><span class=""></span>Липса на апетит</a></li>
                                        <li><a href="/search?search=Липса на памет"><span class=""></span>Липса на памет</a></li>
                                        <li><a href="/search?search=Наднормено тегло"><span class=""></span>Наднормено тегло</a></li>
                                        <li><a href="/search?search=Пречистване на черния дроб"><span class=""></span>Пречистване на черния дроб</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="dropdown multi-column-dropdown diseases">
                                        <li><a href="/search?search=Разширени вени"><span class=""></span>Разширени вени</a></li>
                                        <li><a href="/search?search=Синузит"><span class=""></span>Синузит</a></li>
                                        <li><a href="/search?search=Слаб имунитет"><span class=""></span>Слаб имунитет</a></li>
                                        <li><a href="/search?search=Стрии"><span class=""></span>Стрии</a></li>
                                        <li><a href="/search?search=Уголемена простата"><span class=""></span>Уголема простата</a></li>
                                        <li><a href="/search?search=Хемороиди"><span class=""></span>Хемороиди</a></li>
                                        <li><a href="/search?search=Хъркане"><span class=""></span>Хъркане</a></li>
                                        <li><a href="/search?search=Цистит"><span class=""></span>Цистит</a></li>
                                        <li><a href="/search?search=Чупливи нокти"><span class=""></span>Чупливи нокти</a></li>
                                        <li><a href="/search?search=Шум в ушите"><span class=""></span>Шум в ушите</a></li>
                                    </ul>
                                </div>
                            </div>
                        </ul>
                    </li>

                    <li class="nav-item navigation"><a href="/map.jsp">Карта</a></li>
                </ul>
                <form method="GET" action="search" class="navbar-form navbar-left" role="search">
                    <div class="form-group form-group-lg">
                        <input id="searchBox" type="search" name="search" class="form-control searchBox" placeholder="Търси...">
                    </div>
                    <button type="submit" id="searchBtn" class="btn btn-default btn-lg">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </form>

                <%
                    System.out.println("(Before if)Index: isLogged = " + session.getAttribute("isLogged"));
                    if (session.getAttribute("isLogged") != null){
                        if ((Boolean) session.getAttribute("isLogged")) {
                %>
                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="index">
                            <input type="submit" class="button" value="Изход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="/myAccount" method="POST">
                            <input type="submit" class="button" value="Моят акаунт">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="loginDropdown"><img id="dropdown-image" src="images/user.png"/> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li class="nav-item navigation">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" action="/myAccount" id="login-nav" method="GET">
                                            <input type="submit" class="button form-control" value="Моят акаунт">
                                        </form>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item navigation" style="margin-bottom:20px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" method="POST" id="login-nav"  action="index">
                                            <input type="submit" class="button form-control" value="Изход">
                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>


                <% System.out.println("(After if) Index: isLogged = " + session.getAttribute("isLogged"));
                }
                else {%>
                System.out.println("v mrysniq if sym");%>
                <!-- <ul class="nav navbar-nav navbar-right">
                     <li class="nav-item navigation">
                         <form method="POST" action="login.jsp">
                             <input type="submit" class="button" value="Вход">
                         </form>
                     </li>
                     <li class="nav-item navigation">
                         <form action="registration.jsp">
                             <input type="submit" class="button" value="Регистрирай се">
                         </form>
                     </li>
                 </ul>-->



                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle loginDropdown" data-toggle="dropdown"><b>Вход</b> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 style="text-align: center">Вход</h4><hr/>
                                        <form class="form" role="form" method="post" action="index" accept-charset="UTF-8" id="login-nav">
                                            <div class="form-group">
                                                <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
                                                <input type="text" placeholder="Username или имейл" class="form-control" name="email" id="email" style="display: inline;" required/>
                                            </div>
                                            <div class="form-group">
                                                <label id="icon" for="password"><i class="fa fa-key"></i></label>
                                                <input type="password" class="form-control loginText" name="password" id="password" placeholder="Парола" style="display: inline;" required/>
                                                <!--<div class="help-block text-right"><a href="">Forget the password ?</a></div>-->
                                            </div>
                                            <div class="checkbox" id="rememberCheck">
                                                <label class="containerCheckbox" for="rememberMe">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Запомни ме
                                                    <br/><input type="checkbox" name="rememberMe" id="rememberMe"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-block" id="loginButton">Влез</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="bottom text-center">
                                        Нямаш регистрация? <br/><button onclick="location.href='/registration.jsp'" class="regBtn"><b>Регистрирай се</b></button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>

                <% }
                }
                else if(session.getAttribute("isLogged") == null){
                    System.out.println("v ifa sum za isLogged=null");
                    //System.out.println("cookie 0 name: " + request.getCookies()[0].getValue());
                    //System.out.println("cookie 1 name: " + request.getCookies()[1].getValue());
                    //System.out.println("cookie 2 name: " + request.getCookies()[2].getValue());
                    //System.out.println("cookie 3 name: " + request.getCookies()[3].getValue());
                    Cookie[] cookies = request.getCookies();
                    if(cookies!=null && cookies.length > 1){
                        System.out.println("v ifa sum za cookie");

                        System.out.println("(jsp) array lenght: " + cookies.length);
                        int i=0;
                        String usernameCookieValue=null;
                        String passwordCookieValue=null;
                        for (Cookie cookie:cookies) {
                            if(cookies[i].getName().equals("username"))usernameCookieValue = cookies[i].getValue();
                            else if(cookies[i].getName().equals("password"))passwordCookieValue = cookies[i].getValue();
                            System.out.println("JSP Current cookie name: " + usernameCookieValue);
                            System.out.println("JSP Current cookie value: " + passwordCookieValue);
                            i++;
                            System.out.println("i = " + i + ";");
                        }
                        System.out.println("Username cookie value = " + usernameCookieValue);
                        System.out.println("Password cookie value = " + passwordCookieValue);
                        if(usernameCookieValue!=null && passwordCookieValue!=null) {
                            session.setAttribute("isLogged", true);
                            session.setAttribute("username", usernameCookieValue);
                            LoginModel model = new LoginModel();
                            session.setAttribute("email", model.getEmail(usernameCookieValue));
                            session.setAttribute("gender", model.getGender(usernameCookieValue));
                %>
                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="index">
                            <input type="submit" class="button" value="Изход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="/myAccount" method="POST">
                            <input type="submit" class="button" value="Моят акаунт">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="loginDropdown"><img id="dropdown-image" src="images/user.png"/> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li class="nav-item navigation">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" method="POST" id="login-nav"  action="index">
                                            <input type="submit" class="button form-control" value="Изход">
                                        </form>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item navigation" style="margin-bottom:20px;>
                                    <div class="row">
                            <div class="col-md-12">
                                <form class="form" action="/myAccount" id="login-nav" method="GET">
                                    <input type="submit" class="button form-control" value="Моят акаунт">
                                </form>
                            </div>
                            </li>
                        </ul>
                    </li>
                </ul>


                <%}
                }
                else{
                    System.out.println("v else sum za not logged");
                %>


                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="login.jsp">
                            <input type="submit" class="button" value="Вход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="registration.jsp">
                            <input type="submit" class="button" value="Регистрирай се">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle loginDropdown" data-toggle="dropdown"><b>Вход</b> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 style="text-align: center">Вход</h4><hr/>
                                        <form class="form" role="form" method="post" action="index" accept-charset="UTF-8" id="login-nav">
                                            <div class="form-group">
                                                <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
                                                <input type="text" placeholder="Username или имейл" class="form-control" name="email" id="email" style="display: inline;" required/>
                                            </div>
                                            <div class="form-group">
                                                <label id="icon" for="password"><i class="fa fa-key"></i></label>
                                                <input type="password" class="form-control loginText" name="password" id="password" placeholder="Парола" style="display: inline;" required/>
                                                <!--<div class="help-block text-right"><a href="">Forget the password ?</a></div>-->
                                            </div>
                                            <div class="checkbox" id="rememberCheck">
                                                <label class="containerCheckbox" for="rememberMe">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Запомни ме
                                                    <br/><input type="checkbox" name="rememberMe" id="rememberMe"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-block" id="loginButton">Влез</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="bottom text-center">
                                        Нямаш регистрация?<br/> <button onclick="location.href='/registration.jsp'" class="regBtn"><b>Регистрирай се</b></button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
                <%
                        }
                    }
                %>

                <!--</div>
                 </div>-->
            </div>
        </div>
    </nav>
    <nav class="nav-xbootstrap navbar navbar-fixed-top navbar-default hidden-xs" id="navigation">
        <div class="container">
            <div class="navbar-header">
                <a href="/index.jsp"><img class="logo-navbar" src="images/EM%20logo.png"></a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav nav-test">
                    <!--<li class="nav-item navigation" style="color:white;"><a href="#">Начало</a></li>-->
                    <li id="symptoms" class="dropdown nav-item navigation">
                        <a href="#">
                            <!--<span class="glyphicon glyphicon-grain"></span>--> Симптоми <span class="caret"></span>
                        </a>
                        <ul class="dropdown multi-column columns-3" role="button">
                            <div class="row">
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Безсъние"><span class=""></span>Безсъние</a></li>
                                        <li><a href="/search?search=Белези"><span class=""></span>Белези</a></li>
                                        <li><a href="/search?search=Болки в корема"><span class=""></span>Болки в корема</a></li>
                                        <li><a href="/search?search=Болки в мускулите"><span class=""></span>Болки в мускулите</a></li>
                                        <li><a href="/search?search=Болки в областта на лицето"><span class=""></span>Болки в областта на лицето</a></li>
                                        <li><a href="/search?search=Болки в ставите"><span class=""></span>Болки в ставите</a></li>
                                        <li><a href="/search?search=Болки в ушите"><span class=""></span>Болки в ушите</a></li>
                                        <li><a href="/search?search=Висока температура"><span class=""></span>Висока температура</a></li>
                                        <li><a href="/search?search=Възпалено и болезнено гърло"><span class=""></span>Възпалено и болезнено гърло</a></li>
                                        <li><a href="/search?search=Гадене"><span class=""></span>Гадене</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Газове"><span class=""></span>Газове</a></li>
                                        <li><a href="/search?search=Главоболие"><span class=""></span>Главоболие</a></li><li><a href="/search?search=Дразнене на гърлото"><span class=""></span>Дразнене на гърлото</a></li>
                                        <li><a href="/search?search=Запек"><span class=""></span>Запек</a></li>
                                        <li><a href="/search?search=Запушен нос"><span class=""></span>Запушен нос</a></li>
                                        <li><a href="/search?search=Запушени уши"><span class=""></span>Запушени уши</a></li>
                                        <li><a href="/search?search=Зачервена кожа"><span class=""></span>Зачервена кожа</a></li>
                                        <li><a href="/search?search=Кашлица"><span class=""></span>Кашлица</a></li>
                                        <li><a href="/search?search=Липса на концентрация"><span class=""></span>Липса на концентрация</a></li>
                                        <li><a href="/search?search=Лошо храносмилане"><span class=""></span>Лошо храносмилане</a></li>

                                    </ul>
                                </div>
                                <div class="col-md-4">
                                    <ul class="dropdown multi-column-dropdown symptoms">
                                        <li><a href="/search?search=Намалено обоняние"><span class=""></span>Намалено обоняние</a></li>
                                        <li><a href="/search?search=Нервност"><span class=""></span>Нервност</a></li>
                                        <li><a href="/search?search=Повръщане"><span class=""></span>Повръщане</a></li>
                                        <li><a href="/search?search=Пърхот"><span class=""></span>Пърхот</a></li>
                                        <li><a href="/search?search=Секреция от носа"><span class=""></span>Секреция от носа</a></li>
                                        <li><a href="/search?search=Сухи и уморени очи"><span class=""></span>Сухи и уморени очи</a></li>
                                        <li><a href="/search?search=Сърбеж на кожата"><span class=""></span>Сърбеж на кожата</a></li>
                                        <li><a href="/search?search=Чувство на умора"><span class=""></span>Чувство на умора</a></li>
                                    </ul>
                                </div>
                            </div>
                        </ul>
                    </li>

                    <li class="dropdown nav-item navigation">
                        <a href="#" role="button">
                            Болести <span class="caret"></span>
                        </a>

                        <ul class="dropdown multi-column columns-2" role="button">
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="dropdown multi-column-dropdown diseases">
                                        <li><a href="/search?search=Акне"><span class=""></span>Акне</a></li>

                                        <li><a href="/search?search=Грип"><span class=""></span>Грип</a></li>
                                        <li><a href="/search?search=Диария"><span class=""></span>Диария</a></li>
                                        <li><a href="/search?search=Зависимост от тютюнопушене"><span class=""></span>Зависимост от тютюнопушене</a></li>
                                        <li><a href="/search?search=Изпотяване"><span class=""></span>Изпотяване</a></li>
                                        <li><a href="/search?search=Косопад"><span class=""></span>Косопад</a></li>
                                        <li><a href="/search?search=Липса на апетит"><span class=""></span>Липса на апетит</a></li>
                                        <li><a href="/search?search=Липса на памет"><span class=""></span>Липса на памет</a></li>
                                        <li><a href="/search?search=Наднормено тегло"><span class=""></span>Наднормено тегло</a></li>
                                        <li><a href="/search?search=Пречистване на черния дроб"><span class=""></span>Пречистване на черния дроб</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="dropdown multi-column-dropdown diseases">
                                        <li><a href="/search?search=Разширени вени"><span class=""></span>Разширени вени</a></li>
                                        <li><a href="/search?search=Синузит"><span class=""></span>Синузит</a></li>
                                        <li><a href="/search?search=Слаб имунитет"><span class=""></span>Слаб имунитет</a></li>
                                        <li><a href="/search?search=Стрии"><span class=""></span>Стрии</a></li>
                                        <li><a href="/search?search=Уголемена простата"><span class=""></span>Уголема простата</a></li>
                                        <li><a href="/search?search=Хемороиди"><span class=""></span>Хемороиди</a></li>
                                        <li><a href="/search?search=Хъркане"><span class=""></span>Хъркане</a></li>
                                        <li><a href="/search?search=Цистит"><span class=""></span>Цистит</a></li>
                                        <li><a href="/search?search=Чупливи нокти"><span class=""></span>Чупливи нокти</a></li>
                                        <li><a href="/search?search=Шум в ушите"><span class=""></span>Шум в ушите</a></li>
                                    </ul>
                                </div>
                            </div>
                        </ul>
                    </li>

                    <li class="nav-item navigation"><a href="/map.jsp">Карта</a></li>
                </ul>
                <form method="GET" action="search" class="navbar-form navbar-left" role="search">
                    <div class="form-group form-group-lg">
                        <input id="searchBox" type="search" name="search" class="form-control searchBox" placeholder="Търси...">
                    </div>
                    <button type="submit" id="searchBtn" class="btn btn-default btn-lg">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </form>

                <%
                    System.out.println("(Before if)Index: isLogged = " + session.getAttribute("isLogged"));
                    if (session.getAttribute("isLogged") != null){
                        if ((Boolean) session.getAttribute("isLogged")) {
                %>
                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="index">
                            <input type="submit" class="button" value="Изход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="/myAccount" method="POST">
                            <input type="submit" class="button" value="Моят акаунт">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="loginDropdown"><img id="dropdown-image" src="images/user.png"/> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li class="nav-item navigation">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" action="/myAccount" id="login-nav" method="GET">
                                            <input type="submit" class="button form-control" value="Моят акаунт">
                                        </form>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item navigation" style="margin-bottom:20px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" method="POST" id="login-nav"  action="index">
                                            <input type="submit" class="button form-control" value="Изход">
                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>


                <% System.out.println("(After if) Index: isLogged = " + session.getAttribute("isLogged"));
                }
                else {%>
                System.out.println("v mrysniq if sym");%>
                <!-- <ul class="nav navbar-nav navbar-right">
                     <li class="nav-item navigation">
                         <form method="POST" action="login.jsp">
                             <input type="submit" class="button" value="Вход">
                         </form>
                     </li>
                     <li class="nav-item navigation">
                         <form action="registration.jsp">
                             <input type="submit" class="button" value="Регистрирай се">
                         </form>
                     </li>
                 </ul>-->



                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle loginDropdown" data-toggle="dropdown"><b>Вход</b> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 style="text-align: center">Вход</h4><hr/>
                                        <form class="form" role="form" method="post" action="index" accept-charset="UTF-8" id="login-nav">
                                            <div class="form-group">
                                                <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
                                                <input type="text" placeholder="Username или имейл" class="form-control" name="email" id="email" style="display: inline;" required/>
                                            </div>
                                            <div class="form-group">
                                                <label id="icon" for="password"><i class="fa fa-key"></i></label>
                                                <input type="password" class="form-control loginText" name="password" id="password" placeholder="Парола" style="display: inline;" required/>
                                                <!--<div class="help-block text-right"><a href="">Forget the password ?</a></div>-->
                                            </div>
                                            <div class="checkbox" id="rememberCheck">
                                                <label class="containerCheckbox" for="rememberMe">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Запомни ме
                                                    <br/><input type="checkbox" name="rememberMe" id="rememberMe"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-block" id="loginButton">Влез</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="bottom text-center">
                                        Нямаш регистрация? <br/><button onclick="location.href='/registration.jsp'" class="regBtn"><b>Регистрирай се</b></button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>

                <% }
                }
                else if(session.getAttribute("isLogged") == null){
                    System.out.println("v ifa sum za isLogged=null");
                    //System.out.println("cookie 0 name: " + request.getCookies()[0].getValue());
                    //System.out.println("cookie 1 name: " + request.getCookies()[1].getValue());
                    //System.out.println("cookie 2 name: " + request.getCookies()[2].getValue());
                    //System.out.println("cookie 3 name: " + request.getCookies()[3].getValue());
                    Cookie[] cookies = request.getCookies();
                    if(cookies!=null && cookies.length > 1){
                        System.out.println("v ifa sum za cookie");

                        System.out.println("(jsp) array lenght: " + cookies.length);
                        int i=0;
                        String usernameCookieValue=null;
                        String passwordCookieValue=null;
                        for (Cookie cookie:cookies) {
                            if(cookies[i].getName().equals("username"))usernameCookieValue = cookies[i].getValue();
                            else if(cookies[i].getName().equals("password"))passwordCookieValue = cookies[i].getValue();
                            System.out.println("JSP Current cookie name: " + usernameCookieValue);
                            System.out.println("JSP Current cookie value: " + passwordCookieValue);
                            i++;
                            System.out.println("i = " + i + ";");
                        }
                        System.out.println("Username cookie value = " + usernameCookieValue);
                        System.out.println("Password cookie value = " + passwordCookieValue);
                        if(usernameCookieValue!=null && passwordCookieValue!=null) {
                            session.setAttribute("isLogged", true);
                            session.setAttribute("username", usernameCookieValue);
                            LoginModel model = new LoginModel();
                            session.setAttribute("email", model.getEmail(usernameCookieValue));
                            session.setAttribute("gender", model.getGender(usernameCookieValue));
                %>
                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="index">
                            <input type="submit" class="button" value="Изход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="/myAccount" method="POST">
                            <input type="submit" class="button" value="Моят акаунт">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="loginDropdown"><img id="dropdown-image" src="images/user.png"/> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li class="nav-item navigation">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form class="form" method="POST" id="login-nav"  action="index">
                                            <input type="submit" class="button form-control" value="Изход">
                                        </form>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item navigation" style="margin-bottom:20px;>
                                    <div class="row">
                            <div class="col-md-12">
                                <form class="form" action="/myAccount" id="login-nav" method="GET">
                                    <input type="submit" class="button form-control" value="Моят акаунт">
                                </form>
                            </div>
                            </li>
                        </ul>
                    </li>
                </ul>


                <%}
                }
                else{
                    System.out.println("v else sum za not logged");
                %>


                <!--<ul class="nav navbar-nav navbar-right">
                    <li class="nav-item navigation">
                        <form method="POST" action="login.jsp">
                            <input type="submit" class="button" value="Вход">
                        </form>
                    </li>
                    <li class="nav-item navigation">
                        <form action="registration.jsp">
                            <input type="submit" class="button" value="Регистрирай се">
                        </form>
                    </li>
                </ul>-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle loginDropdown" data-toggle="dropdown"><b>Вход</b> <span class="caret"></span></a>
                        <ul id="login-dp" class="dropdown-menu">
                            <li>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 style="text-align: center">Вход</h4><hr/>
                                        <form class="form" role="form" method="post" action="index" accept-charset="UTF-8" id="login-nav">
                                            <div class="form-group">
                                                <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
                                                <input type="text" placeholder="Username или имейл" class="form-control" name="email" id="email" style="display: inline;" required/>
                                            </div>
                                            <div class="form-group">
                                                <label id="icon" for="password"><i class="fa fa-key"></i></label>
                                                <input type="password" class="form-control loginText" name="password" id="password" placeholder="Парола" style="display: inline;" required/>
                                                <!--<div class="help-block text-right"><a href="">Forget the password ?</a></div>-->
                                            </div>
                                            <div class="checkbox" id="rememberCheck">
                                                <label class="containerCheckbox" for="rememberMe">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Запомни ме
                                                    <br/><input type="checkbox" name="rememberMe" id="rememberMe"/>
                                                    <span class="checkmark"></span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-block" id="loginButton">Влез</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="bottom text-center">
                                        Нямаш регистрация?<br/> <button onclick="location.href='/registration.jsp'" class="regBtn"><b>Регистрирай се</b></button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
                <%
                        }
                    }
                %>

                <!--</div>
                 </div>-->
            </div>
        </div>
    </nav>
</header>
<div class="container">
    <div class="background">
        <script type="text/javascript">
            document.getElementById('searchBtn').onclick = function() {
                <%
                    session.setAttribute("isSearching", true);
                %>
            };
        </script>

    <%
        List<Medicament> herbs=(List<Medicament>)session.getAttribute("searchResultHerbs");
        List<Medicament> medicaments=(List<Medicament>)session.getAttribute("searchResultMedicaments");

        if(medicaments.get(0).getName().contains("Няма намерени резултати") && herbs.get(0).getName().contains("Няма намерени резултати")){System.out.println("img if check");%>
    <img alt="no_results" src="/images/no_results.png">
        <%}%>
    <ul class="nav nav-tabs">
        <%
            if(!medicaments.get(0).getName().contains("Няма намерени резултати")){%>
            <li class="active"><a data-toggle="tab" href="#medicamentTreatment">Лечение с медикаменти</a></li>
            <%if(!herbs.get(0).getName().contains("Няма намерени резултати")){%>
            <li onclick = "herbTreatmentTabClick()"><a data-toggle="tab" href="#herbTreatment">Биолечение</a></li>
                <%}%>
        <%}
        else if(medicaments.get(0).getName().contains("Няма намерени резултати") && !herbs.get(0).getName().contains("Няма намерени резултати")){%>
        <li class="active" onclick = "herbTreatmentTabClick()"><a data-toggle="tab" href="#herbTreatment">Биолечение</a></li>
        <%}%>

    </ul>

    <div class="tab-content">
        <%System.out.println("Search.jsp: medicament.getName() = " + medicaments.get(0).getName());%>
        <%if(medicaments.get(0).getName().contains("Няма намерени резултати") && !herbs.get(0).getName().contains("Няма намерени резултати")){System.out.println("Im in if");%>
            <div id="herbTreatment" class="tab-pane fade in active">
        <%}
        else if(!medicaments.get(0).getName().contains("Няма намерени резултати") && !herbs.get(0).getName().contains("Няма намерени резултати")){System.out.println("Im in else");%>
            <div id="herbTreatment" class="tab-pane fade">
        <%}%>

            <%
                herbs=(List<Medicament>)session.getAttribute("searchResultHerbs");
                System.out.println(herbs);

                int i = 1;
                session.setAttribute("medicamentsCount", herbs.size());

                if(!herbs.get(0).getName().contains("Няма намерени резултати")){
                List<String> usedHerbs=(List<String>)session.getAttribute("usedMedicaments");
                    System.out.println("List usedHerbs = " + session.getAttribute("usedMedicaments"));
                for (Medicament herb : herbs) {
                    String imagePath = herb.getImagePath();
            %>


            <div class="row">
                <br/>
                <h2 id="<%=i%>" name="medicamentName"><strong><%=herb.getName().substring(0, 1).toUpperCase() + herb.getName().substring(1)%></strong></h2>
                <hr class="style18"/>
                <br/>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <%if(!herb.getName().equals("Няма намерени резултати")){%><img class="medicamentImage img-responsive" src="<%=imagePath%>"/>

                    <br/><br/>
                    <div class="row">
                        <div class="customJumbotron">
                        <div class="col-md-6">
                            <div class="short-div">
                                <div class="avgRatingName">Оценка:&nbsp;</div>
                                <%if(herb.getAverageRating()<=5 && herb.getAverageRating()>4){%>
                                <div class="avgRatingValue" style="color:#00ad45"><%=herb.getAverageRating()%></div>
                                <%}
                                else if(herb.getAverageRating()<=4 && herb.getAverageRating()>3){%>
                                <div class="avgRatingValue" style="color: #FDF501"><%=herb.getAverageRating()%></div>
                                <%}
                                else if(herb.getAverageRating()<=3 && herb.getAverageRating()>2){%>
                                <div class="avgRatingValue" style="color:#FEAD01"><%=herb.getAverageRating()%></div>
                                <%}
                                else if(herb.getAverageRating()<=2 && herb.getAverageRating()>=0){%>
                                <div class="avgRatingValue" style="color:#b20000"><%=herb.getAverageRating()%></div>
                                <%}%>
                                <br/>
                                <form method="GET" action="medicamentAssessment" name="rate<%=herb.getName()%>">
                                    <fieldset class="rating" name="rate<%=herb.getName()%>" >
                                        <input type="radio" id="<%=herb.getName()%>star5" name="rating" value="5" /><label class = "full" for="<%=herb.getName()%>star5" title="Отлично - 5 звезди"></label>
                                        <input type="radio" id="<%=herb.getName()%>star4" name="rating" value="4" /><label class = "full" for="<%=herb.getName()%>star4" title="Много добро - 4 звезди"></label>
                                        <input type="radio" id="<%=herb.getName()%>star3" name="rating" value="3" /><label class = "full" for="<%=herb.getName()%>star3" title="Добро - 3 звезди"></label>
                                        <input type="radio" id="<%=herb.getName()%>star2" name="rating" value="2" /><label class = "full" for="<%=herb.getName()%>star2" title="Средно - 2 звезди"></label>
                                        <input type="radio" id="<%=herb.getName()%>star1" name="rating" value="1" /><label class = "full" for="<%=herb.getName()%>star1" title="Без ефект - 1 звезда"></label>

                                    </fieldset>

                                    <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=herb.getName()%>" id="<%=herb.getName()%>rateButton" name="rateButton-herbTreatment-<%=i%>">Оцени</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="short-div">
                                <%
                                    if (usedHerbs!=null){
                                        if (usedHerbs.contains(herb.getName().toLowerCase())){%>
                                            <form method="GET" action="useMedicament">
                                                <div class ="medicamentTimetable">Спирам да вземам <%=herb.getName()%>: </div>
                                                <input type="hidden" name="daysToGetMedicament-<%=herb.getName()%>">
                                                <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=herb.getName()%>" id="<%=herb.getName()%>daysToGetFormButton" name="daysToGetFormButtonStop-herbTreatment-<%=i%>">Потвърди</button>
                                            </form>
                                <br/>
                                        <%}
                                        else{%>
                                            <form method="GET" action="useMedicament">
                                                <div class="medicamentTimetable">Ще вземам <%=herb.getName()%>: </div>
                                                <input type="date" placeholder="Please specify a date" onclick="$(this).removeClass('placeholderclass')"  class="dateclass placeholderclass dateField" name="daysToGetMedicament-<%=herb.getName()%>">
                                                <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=herb.getName()%>" id="<%=herb.getName()%>daysToGetFormButton" name="daysToGetFormButton-herbTreatment-<%=i%>">Потвърди</button>
                                            </form>
                                <br/>
                                        <%}
                                    }
                                    else{%>
                                        <form method="GET" action="useMedicament">
                                            <div class="medicamentTimetable">Ще вземам <%=herb.getName()%>: </div>
                                            <input type="date" placeholder="Please specify a date" onclick="$(this).removeClass('placeholderclass')"  class="dateclass placeholderclass dateField" name="daysToGetMedicament-<%=herb.getName()%>">
                                            <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=herb.getName()%>" id="<%=herb.getName()%>daysToGetFormButton" name="daysToGetFormButton-herbTreatment-<%=i%>">Потвърди</button>
                                        </form>
                                <br/>
                                <%}%>
                            </div>
                        </div>
                    <div class="short-div">
                        <br/>
                        <div class="avgRatingName">Коментари</div>
                        <div>
                            <div class="scrollbar" id="style-8">
                                <div class="force-overflow">
                                    <div id ="commentsFieldHerbs-<%=i%>" class="commentStyle">
                                        <%
                                            if(herb.getComments()!=null){
                                                System.out.println("nqma logika");
                                                for(Commentary comment : herb.getComments()) {%>
                                        <hr/>
                                        <div class="userCommented"><%=comment.getUsername()%></div><br/>
                                        <div class="comment"><i><%=comment.getContent()%></i></div>
                                        <%}
                                        }
                                        else{
                                            System.out.println("Jenite sa kato exceptionite.");
                                        }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br/><br/>
                        <textarea class="form-control textAreaComment" rows="4" cols="50" name="comment" placeholder="Въведете коментар..." form="<%=herb.getName()%>commentForm"></textarea>
                        <br/>
                        <form method="GET" name="comment<%=herb.getName()%>" action="medicamentAssessment" id="<%=herb.getName()%>commentForm">
                            <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition();" value="<%=herb.getName()%>" id="<%=herb.getName()%>commentButton" name="commentButton-herbTreatment-<%=i%>">Коментирай</button>
                        </form>
                    </div>
                    <br/>
                    </div>
                </div>
                </div>

                <div class="col-md-6">
                    <div class="short-div">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#description-<%=i%>">Описание</a></li>
                            <li><a data-toggle="tab" href="#recipe-<%=i%>">Рецепта</a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="description-<%=i%>" class="tab-pane fade in active">
                                <%if(herb.getDescription().length()>0){%><p class="description"><%=herb.getDescription().substring(0, 1).toUpperCase() + herb.getDescription().substring(1)%></p><%}%>
                            </div>

                            <div id="recipe-<%=i%>" class="tab-pane fade">
                                <h2>Рецепта</h2>
                                <div class="recipeStyle">
                                    <%
                                        String[] recipeArray = new String[20];
                                        int j=0;
                                        for (String recipe : herb.getRecipe()) {
                                            if(recipe.length()>0){%>
                                    <p class="description"><%=recipe.substring(0, 1).toUpperCase() + recipe.substring(1)%></p>
                                    <br/>
                                    <%}
                                    }%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br/>
            <%}
            System.out.println("(Rate form) isSearching = " + session.getAttribute("isSearching"));%>
            <%i++;
            }
            }
            %>



            </div>
                <%if(!medicaments.get(0).getName().contains("Няма намерени резултати")){
                System.out.println("Im in if for medicament");%>
                <div id="medicamentTreatment" class="tab-pane fade in active">
                    <%}
                    else{%>
                        <div id="medicamentTreatment" class="tab-pane fade">
                    <%}%>

            <%
                medicaments=(List<Medicament>)session.getAttribute("searchResultMedicaments");
                System.out.println(medicaments);

                i = 3;
                session.setAttribute("medicamentsCount", medicaments.size());

                List<String> usedMedicaments=(List<String>)session.getAttribute("usedMedicaments");
                System.out.println("Search.jsp: medicaments.isEmpty() = " + medicaments.isEmpty());
                for (Medicament medicament : medicaments) {
                    String imagePath = medicament.getImagePath();
            %>
            <div class="row">
                <br/>
                <h2 id="<%=i%>" name="medicamentName" style="margin-left:10px;"><strong><%=medicament.getName().substring(0, 1).toUpperCase() + medicament.getName().substring(1)%></strong></h2>
                <hr class="style18"/>
                <br/>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <%if(!medicament.getName().contains("Няма намерени резултати")){%>
                    <img class="medicamentImage" src="<%=imagePath%>"/>
                    <br/><br/>
                    <div class="row">
                        <div class="customJumbotron">
                        <div class="col-md-6">
                            <div class="short-div">
                                <div class="avgRatingName">Оценка:&nbsp;</div>
                                <%if(medicament.getAverageRating()<=5 && medicament.getAverageRating()>4){%>
                                <div class="avgRatingValue" style="color:#00ad45"><%=medicament.getAverageRating()%></div>
                                <%}
                                else if(medicament.getAverageRating()<=4 && medicament.getAverageRating()>3){%>
                                <div class="avgRatingValue" style="color: #FDF501"><%=medicament.getAverageRating()%></div>
                                <%}
                                else if(medicament.getAverageRating()<=3 && medicament.getAverageRating()>2){%>
                                <div class="avgRatingValue" style="color:#FEAD01"><%=medicament.getAverageRating()%></div>
                                <%}
                                else if(medicament.getAverageRating()<=2 && medicament.getAverageRating()>=0){%>
                                <div class="avgRatingValue" style="color:#b20000"><%=medicament.getAverageRating()%></div>
                                <%}%>
                                <br/>
                                <form method="GET" action="medicamentAssessment" name="rate<%=medicament.getName()%>">
                                    <fieldset class="rating" name="rate<%=medicament.getName()%>" >
                                        <input type="radio" id="<%=medicament.getName()%>star5" name="rating" value="5" /><label class = "full" for="<%=medicament.getName()%>star5" title="Отлично - 5 звезди"></label>
                                        <input type="radio" id="<%=medicament.getName()%>star4" name="rating" value="4" /><label class = "full" for="<%=medicament.getName()%>star4" title="Много добро - 4 звезди"></label>
                                        <input type="radio" id="<%=medicament.getName()%>star3" name="rating" value="3" /><label class = "full" for="<%=medicament.getName()%>star3" title="Добро - 3 звезди"></label>
                                        <input type="radio" id="<%=medicament.getName()%>star2" name="rating" value="2" /><label class = "full" for="<%=medicament.getName()%>star2" title="Средно - 2 звезди"></label>
                                        <input type="radio" id="<%=medicament.getName()%>star1" name="rating" value="1" /><label class = "full" for="<%=medicament.getName()%>star1" title="Без ефект - 1 звезда"></label>

                                    </fieldset>

                                    <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=medicament.getName()%>" id="<%=medicament.getName()%>rateButton" name="rateButton-medicamentTreatment-<%=i%>">Оцени</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="short-div">
                                <%
                                    if (usedMedicaments!=null){
                                        if (usedMedicaments.contains(medicament.getName().toLowerCase())){%>

                                            <form method="GET" action="useMedicament">
                                                <div class ="medicamentTimetable">Спирам да вземам <%=medicament.getName()%>: </div>
                                                <input type="hidden" name="daysToGetMedicament-<%=medicament.getName()%>">
                                                <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=medicament.getName()%>" id="<%=medicament.getName()%>daysToGetFormButton" name="daysToGetFormButtonStop-medicamentTreatment-<%=i%>">Потвърди</button>
                                            </form>
                                        <%}
                                        else{%>
                                            <form method="GET" action="useMedicament">
                                                <div class="medicamentTimetable">Ще вземам <%=medicament.getName()%>: </div>
                                                <input type="date"  placeholder="Please specify a date" onclick="$(this).removeClass('placeholderclass')"  class="dateclass placeholderclass dateField" name="daysToGetMedicament-<%=medicament.getName()%>">
                                                <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=medicament.getName()%>" id="<%=medicament.getName()%>daysToGetFormButton" name="daysToGetFormButton-medicamentTreatment-<%=i%>">Потвърди</button>
                                            </form>
                                        <%}
                                        }
                                    else{%>
                                        <form method="GET" action="useMedicament">
                                            <div class="medicamentTimetable">Ще вземам <%=medicament.getName()%>: </div>
                                            <input type="date"  placeholder="Please specify a date" onclick="$(this).removeClass('placeholderclass')"  class="dateclass placeholderclass dateField" name="daysToGetMedicament-<%=medicament.getName()%>">
                                            <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=medicament.getName()%>" id="<%=medicament.getName()%>daysToGetFormButton" name="daysToGetFormButton-medicamentTreatment-<%=i%>">Потвърди</button>
                                        </form>
                                    <%}%>
                            </div>
                            <br/>
                        </div>
                    <div class="short-div">
                        <br/>
                        <div class="avgRatingName">Коментари</div>
                        <div>
                            <div class="scrollbar" id="style-9">
                                <div class="force-overflow">
                                    <div id ="commentsFieldMedicaments-<%=i%>" class="commentStyle">
                                        <%
                                            if(medicament.getComments()!=null){
                                                System.out.println("nqma logika");
                                                for(Commentary comment : medicament.getComments()) {%>
                                        <hr/>
                                        <div class="userCommented"><%=comment.getUsername()%></div><br/>
                                        <div class="comment"><i><%=comment.getContent()%></i></div>
                                        <%}
                                        }
                                        else{
                                            System.out.println("Jenite sa kato exceptionite.");
                                        }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br/><br/>
                        <textarea class="form-control textAreaComment" rows="4" cols="50" name="comment" placeholder="Въведете коментар..." form="<%=medicament.getName()%>commentForm"></textarea>
                        <br/>
                        <form method="GET" name="comment<%=medicament.getName()%>" action="medicamentAssessment" id="<%=medicament.getName()%>commentForm">
                            <button class="btn-animated btn-1 btn-1a" type="submit" onclick="getPagePosition()" value="<%=medicament.getName()%>" id="<%=medicament.getName()%>commentButton" name="commentButton-medicamentTreatment-<%=i%>">Коментирай</button>
                        </form>
                    </div>
                    </div>
                </div>
                    <br/>
                </div>

                <div class="col-md-6">
                    <div class="short-div">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#description-<%=i%>">Описание</a></li>
                            <li><a data-toggle="tab" href="#recipe-<%=i%>">Рецепта</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="description-<%=i%>" class="tab-pane fade in active">
                                <h2>Описание</h2>
                                <%if(medicament.getDescription().length()>0){%><p class="description"><%=medicament.getDescription().substring(0, 1).toUpperCase() + medicament.getDescription().substring(1)%></p><%}%>
                            </div>
                            <div id="recipe-<%=i%>" class="tab-pane fade">
                                <h2>Рецепта</h2>
                                <div class="recipeStyle">
                                    <%
                                        String[] recipeArray = new String[20];
                                        //int j=0;
                                        for (String recipe : medicament.getRecipe()) {
                                            if(recipe.length()>0){
                                                System.out.println("Medicament name = " + medicament.getName());
                                                System.out.println("Medicament recipe = " + recipe);
                                                System.out.println("i = " + i);
                                    %>
                                    <p class="description"><%=recipe.substring(0, 1).toUpperCase() + recipe.substring(1)%></p>
                                    <br/>
                                    <%}
                                    }%>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br/>
            <%}
            else{%>
            <img src="images/no_results.png"/>
            <%}%>
            <%System.out.println("(Rate form) isSearching = " + session.getAttribute("isSearching"));%>
            <%i++;

            }
            %>

                </div>
                </div>
            </div>
    </div>
    </div>
</div>



        <%System.out.println("(Search form) isSearching = " + session.getAttribute("isSearching"));%>





            </div>

            <%
                System.out.println("Medicaments[0].getName = " + medicaments.get(0).getName());
                System.out.println("Herbs[0].getName = " + herbs.get(0).getName());

                %>

<script type="text/javascript">
    function getPagePosition(){
        <%System.out.println("IM IM THE JS PAGE FUNC");%>
        sessionStorage.SessionName = "session";
        sessionStorage.setItem("scrollPosition",document.documentElement.scrollTop);
    }
</script>
<script type = "text/javascript">
    <%if(session.getAttribute("wrongInputDate") != null){
    if((Boolean) session.getAttribute("wrongInputDate")) {
    session.removeAttribute("wrongInputDate");%>
    alert("Датата е невалидна");
    <%}
    }%>
</script>
</body>
</html>