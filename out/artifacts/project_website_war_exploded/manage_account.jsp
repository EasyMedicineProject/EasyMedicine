<%@ page import="Models.UserMedicament" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="Models.LoginModel" %><%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/11/2018
  Time: 12:46 AM
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
    <link rel="stylesheet" type="text/css" href="css/buttonA.css">
    <link rel="stylesheet" type="text/css" href="css/clndr.css">
    <link rel="stylesheet" type="text/css" href="css/MainStyle.css">
    <link rel="stylesheet" type="text/css" href="css/LoginStyle.css">
    <link rel="stylesheet" type="text/css" href="css/NewNavbar.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script type="text/javascript">
        window.addEventListener("pageshow", function (event) {
            if (event.persisted) {
                window.location.replace("http://"+window.location.href.split('/')[2]+"/manage_account.jsp");//etuka go fiksvame s redirect shtoto tupiq session zima stoinostta ot cache (vse edno sme lognati) i kato refreshnem vzima stoinostite nanovo
            }
        });
    </script>


    <title>Easy Medicine</title>
    <meta charset = "UTF-8"/>
</head>
<body>
<%
    System.out.println("Current url:"  + request.getRequestURL().toString());
    if(!request.getRequestURL().toString().contains("/myAccount")) {
        System.out.println("in if 1");
        if ( session.getAttribute("manageAccountFlag") == null||!(boolean) session.getAttribute("manageAccountFlag") ) {
            System.out.println("in if 2");
            System.out.println("Splitted = " + request.getRequestURL().toString().split("/")[2]);

            //response.sendRedirect(request.getRequestURL().toString().split("/")[2] + "/home");
            session.setAttribute("manageAccountFlag", true);
            //response.setHeader("Refresh", "0;http://" + request.getRequestURL().toString().split("/")[2] + "/myAccount");
            response.sendRedirect("/myAccount");
        }
        else{
            session.setAttribute("manageAccountFlag", false);
        }
    }
%>
<header>
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
                                        <form class="form" method="POST" id="login-nav" onclick="logoutClick()" action="index">
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

                <%
                        }
                    }
                %>
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
                                            <input type="submit" onclick="logoutClick()" class="button form-control" value="Изход">
                                        </form>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>


                <% System.out.println("(After if) Index: isLogged = " + session.getAttribute("isLogged"));
                }
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
                                            <input type="submit" onclick="logoutClick()" class="button form-control" value="Изход">
                                        </form>
                                    </div>
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
                <%
                        }
                    }
                %>
            </div>
        </div>
    </nav>
</header>


<div class="container">
    <div class="background">
        <div class="customJumbotron" style="padding: 35px 25px 35px 25px; margin-bottom: 20px;">
    <div class="row">
        <div class="col-md-4">
            <img src="/images/user.png" class="userImage"/>
        </div>
        <div class="col-md-2">
            <%if(session.getAttribute("isLogged")!= null){
                if ((Boolean)session.getAttribute("isLogged"));{
            %>
            <%            System.out.println("(Before) Manage account: isLogged = " + session.getAttribute("isLogged")); %>

            <button class="btn-animated btn-1 btn-1a" onclick="accountDeleteConfirm()">Изтрий акаунт</button>
            <form action="index" style="visibility:hidden " method="post">
                <input id="password" name="password" class="deleteAccountField" style="visibility:hidden" type="password" placeholder="парола"/>
                <input  id="password_confirm" style="visibility:hidden" type="submit"  class="btn-animated btn-1 btn-1a" value="потвърди"/>
                <p style="color:red; visibility: hidden" id="wrongPasswordLabel">Грешна парола</p>
                <%

                    if ((session.getAttribute("wrongPasswordAccountDelete") != null)&&((Boolean)session.getAttribute("wrongPasswordAccountDelete"))){%>

                <script>
                    document.getElementById("password").style.visibility="visible";
                    document.getElementById("password_confirm").style.visibility="visible";
                    document.getElementById("wrongPasswordLabel").style.visibility="visible";

                </script>
                <%
                    }
                %>
            </form>



            <form action="password_change.jsp">
                <button type = "submit" class="btn-animated btn-1 btn-1a">Смяна на парола</button>
            </form>
            <%}}
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

            <button class="btn-animated btn-1 btn-1a" onclick="accountDeleteConfirm()">Изтрий акаунт</button>
            <form action="index" style="visibility:hidden " method="post">
                <input id="password" name="password" class="deleteAccountField" style="visibility:hidden" type="password" placeholder="парола"/>
                <input  id="password_confirm" style="visibility:hidden" type="submit"  class="btn-animated btn-1 btn-1a" value="потвърди"/>
                <p style="color:red; visibility: hidden" id="wrongPasswordLabel">Грешна парола</p>
                <%

                    if ((session.getAttribute("wrongPasswordAccountDelete") != null)&&((Boolean)session.getAttribute("wrongPasswordAccountDelete"))){%>

                <script>
                    document.getElementById("password").style.visibility="visible";
                    document.getElementById("password_confirm").style.visibility="visible";
                    document.getElementById("wrongPasswordLabel").style.visibility="visible";

                </script>
                <%
                    }
                %>
            </form>




            <form action="password_change.jsp">
                <button type = "submit" class="btn-animated btn-1 btn-1a">Смяна на парола</button>
            </form>

            <%}
            }
            else{//etuka vliza ot taq sesiq
                session.setAttribute("previousURL", request.getRequestURL().toString());
                System.out.println("Previous URL = " + request.getRequestURL().toString().split("/")[2]);
                response.sendRedirect("/login.jsp");
            }
            }

            %>
        </div>
        <div class="col-md-1"></div>
        <div class="col-md-5">
            <h3>Потребителско име: </h3><span><%=session.getAttribute("username")%></span>
            <h3>Имейл: </h3><span><%=session.getAttribute("email")%></span>
            <%if(session.getAttribute("gender")!=null){%>
            <%if(session.getAttribute("gender").equals("m")){%>
            <h3>Пол: </h3><span>Мъж</span>
            <%}
            else{%>
                <h3>Пол: </h3><span>Жена</span>
            <%}
            }
            %>
        </div>
    </div>
    <br/><br/>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="row">
                <div class="cal1"></div>
            </div>
            <div class="row">
                <form method="GET" action="useMedicament">
                    <span class="medicamentTimetable">Ще вземам  </span>
                    <input type = "text" id="customMedicamentBox" placeholder="Въведете медикамент" name="medicamentToGet"/>
                    <input type="date"  placeholder="Please specify a date" onclick="$(this).removeClass('placeholderclass')" class="dateclass placeholderclass dateField" name="daysToGetMedicament" style="width:290px;">
                    <button type="submit" onclick="getPagePosition()" value="%>" class="btn-animated btn-1 btn-1a" id="daysToGetFormButton" name="daysToGetFormButton-medicamentTreatment">Потвърди</button>
                </form>
            </div>
        </div>
            <div class="col-md-6">
                <div class="row" style="margin-left: 15px;">
                    <div class="col-md-12">
                    <%if (session.getAttribute("todayMedicaments")!=null){%>
                    <h3 style="text-align: center">Днес</h3>
                    <hr class="style18"/>
                    <div class="scrollbar" id="style-8">
                        <div class="force-overflow">
                            <div style="overflow-y: auto; overflow-x:hidden; width:auto; height:auto;max-width: 100%;max-height: 200px;">
                                <%  int counter=0;
                                    for (UserMedicament todayMedicament : (List<UserMedicament>)session.getAttribute("todayMedicaments")) {
                                    Date dateFrom = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(todayMedicament.getDateFrom());
                                    String formattedDateFrom = new SimpleDateFormat("d-MMMM-yyyy").format(dateFrom);
                                    Date deadline = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(todayMedicament.getDeadline());
                                    String formattedDeadline = new SimpleDateFormat("d-MMMM-yyyy").format(deadline);

                                    counter++;
                                    if(formattedDateFrom.contains("January")){ formattedDateFrom = formattedDateFrom.replaceAll("January", "Януари"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("February")){ formattedDateFrom = formattedDateFrom.replaceAll("February", "Февруари"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("March")){ formattedDateFrom = formattedDateFrom.replaceAll("March", "Март"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("April")){ formattedDateFrom = formattedDateFrom.replaceAll("April", "Април"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("May")){ formattedDateFrom = formattedDateFrom.replaceAll("May", "Май"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("June")) { formattedDateFrom = formattedDateFrom.replaceAll("June", "Юни"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("July")){ formattedDateFrom = formattedDateFrom.replaceAll("July", "Юли"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("August")){ formattedDateFrom = formattedDateFrom.replaceAll("August", "Август"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("September")){ formattedDateFrom = formattedDateFrom.replaceAll("September", "Септември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("October")){ formattedDateFrom = formattedDateFrom.replaceAll("October", "Октомври"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("November")){ formattedDateFrom = formattedDateFrom.replaceAll("November", "Ноември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                    else if(formattedDateFrom.contains("December")) { formattedDateFrom = formattedDateFrom.replaceAll("December", "Декември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }

                                    if(formattedDeadline.contains("January")){ formattedDeadline = formattedDeadline.replaceAll("January", "Януари"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("February")){ formattedDeadline = formattedDeadline.replaceAll("February", "Февруари"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("March")){ formattedDeadline = formattedDeadline.replaceAll("March", "Март"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("April")){ formattedDeadline = formattedDeadline.replaceAll("April", "Април"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("May")){ formattedDeadline = formattedDeadline.replaceAll("May", "Май"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("June")) { formattedDeadline = formattedDeadline.replaceAll("June", "Юни"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("July")){ formattedDeadline = formattedDeadline.replaceAll("July", "Юли"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("August")){ formattedDeadline = formattedDeadline.replaceAll("August", "Август"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("September")){ formattedDeadline = formattedDeadline.replaceAll("September", "Септември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("October")){ formattedDeadline = formattedDeadline.replaceAll("October", "Октомври"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("November")){ formattedDeadline = formattedDeadline.replaceAll("November", "Ноември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                    else if(formattedDeadline.contains("December")) { formattedDeadline = formattedDeadline.replaceAll("December", "Декември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                %>

                                <h3 style="background:transparent;"><%=todayMedicament.getMedicamentName().substring(0,1).toUpperCase()%><%=todayMedicament.getMedicamentName().substring(1,todayMedicament.getMedicamentName().length())%></h3>
                                Вие вземате <%=todayMedicament.getMedicamentName()%> от <span style="background-color:transparent;"><%=formattedDateFrom%></span>
                                до <span style="background-color:transparent;"><%=formattedDeadline%></span>
                                <% }
                                    System.out.println("counter (today) = " + counter);
                                if(counter==0){%>
                                <span class="medicamentTimetable" style="background:transparent;">Днес не сте приемали медикаменти или билки</span>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <%}
                    else{%>
                        <h3 style="text-align: center">Днес</h3>
                        <hr class="style18"/>
                        <div class="scrollbar" id="style-8">
                            <div class="force-overflow">
                                <div style="overflow-y: auto; overflow-x:hidden; width:auto; height:auto;max-width: 100%;max-height: 200px;">
                                    <span class="medicamentTimetable" style="background:transparent;">Днес не сте приемали медикаменти или билки</span>
                                </div>
                            </div>
                        </div>
                    <%}%>
                    </div>
                </div>
                <div class="row" style="margin-left: 15px;">
                    <div class="col-md-12">
                        <%if (session.getAttribute("currentDateMedicaments")!=null){
                            System.out.println("Selected date = " + session.getAttribute("selectedDate"));
                            Date selectedDate = new SimpleDateFormat("yyyy-MM-dd").parse(session.getAttribute("selectedDate").toString());
                            String formattedSelectedDate = new SimpleDateFormat("dd-MMMM-yyyy").format(selectedDate);
                            if(formattedSelectedDate.contains("January")){ formattedSelectedDate = formattedSelectedDate.replaceAll("January", "Януари"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("February")){ formattedSelectedDate = formattedSelectedDate.replaceAll("February", "Февруари"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("March")){ formattedSelectedDate = formattedSelectedDate.replaceAll("March", "Март"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("April")){ formattedSelectedDate = formattedSelectedDate.replaceAll("April", "Април"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("May")){ formattedSelectedDate = formattedSelectedDate.replaceAll("May", "Май"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("June")) { formattedSelectedDate = formattedSelectedDate.replaceAll("June", "Юни"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("July")){ formattedSelectedDate = formattedSelectedDate.replaceAll("July", "Юли"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("August")){ formattedSelectedDate = formattedSelectedDate.replaceAll("August", "Август"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("September")){ formattedSelectedDate = formattedSelectedDate.replaceAll("September", "Септември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("October")){ formattedSelectedDate = formattedSelectedDate.replaceAll("October", "Октомври"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("November")){ formattedSelectedDate = formattedSelectedDate.replaceAll("November", "Ноември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                            else if(formattedSelectedDate.contains("December")) { formattedSelectedDate = formattedSelectedDate.replaceAll("December", "Декември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        %>
                        <h3 style="text-align: center"><%=formattedSelectedDate%></h3>
                        <hr class="style18"/>
                        <div class="scrollbar" id="style-8">
                            <div class="force-overflow">
                                <div style="overflow-y: auto; overflow-x:hidden; width:auto; height:auto;max-width: 100%;max-height: 200px;">
                                    <%
                                        int counter = 0;
                                        for (UserMedicament currentMedicament : (List<UserMedicament>)session.getAttribute("currentDateMedicaments")) {
                                        Date dateFrom = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(currentMedicament.getDateFrom());
                                        String formattedDateFrom = new SimpleDateFormat("d-MMMM-yyyy").format(dateFrom);
                                        Date deadline = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(currentMedicament.getDeadline());
                                        String formattedDeadline = new SimpleDateFormat("d-MMMM-yyyy").format(deadline);

                                        counter++;

                                        if(formattedDateFrom.contains("January")){ formattedDateFrom = formattedDateFrom.replaceAll("January", "Януари"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("February")){ formattedDateFrom = formattedDateFrom.replaceAll("February", "Февруари"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("March")){ formattedDateFrom = formattedDateFrom.replaceAll("March", "Март"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("April")){ formattedDateFrom = formattedDateFrom.replaceAll("April", "Април"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("May")){ formattedDateFrom = formattedDateFrom.replaceAll("May", "Май"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("June")) { formattedDateFrom = formattedDateFrom.replaceAll("June", "Юни"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("July")){ formattedDateFrom = formattedDateFrom.replaceAll("July", "Юли"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("August")){ formattedDateFrom = formattedDateFrom.replaceAll("August", "Август"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("September")){ formattedDateFrom = formattedDateFrom.replaceAll("September", "Септември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("October")){ formattedDateFrom = formattedDateFrom.replaceAll("October", "Октомври"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("November")){ formattedDateFrom = formattedDateFrom.replaceAll("November", "Ноември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }
                                        else if(formattedDateFrom.contains("December")) { formattedDateFrom = formattedDateFrom.replaceAll("December", "Декември"); formattedDateFrom = formattedDateFrom.replaceAll("-", " "); }

                                        if(formattedDeadline.contains("January")){ formattedDeadline = formattedDeadline.replaceAll("January", "Януари"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("February")){ formattedDeadline = formattedDeadline.replaceAll("February", "Февруари"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("March")){ formattedDeadline = formattedDeadline.replaceAll("March", "Март"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("April")){ formattedDeadline = formattedDeadline.replaceAll("April", "Април"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("May")){ formattedDeadline = formattedDeadline.replaceAll("May", "Май"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("June")) { formattedDeadline = formattedDeadline.replaceAll("June", "Юни"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("July")){ formattedDeadline = formattedDeadline.replaceAll("July", "Юли"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("August")){ formattedDeadline = formattedDeadline.replaceAll("August", "Август"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("September")){ formattedDeadline = formattedDeadline.replaceAll("September", "Септември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("October")){ formattedDeadline = formattedDeadline.replaceAll("October", "Октомври"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("November")){ formattedDeadline = formattedDeadline.replaceAll("November", "Ноември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }
                                        else if(formattedDeadline.contains("December")) { formattedDeadline = formattedDeadline.replaceAll("December", "Декември"); formattedDeadline = formattedDeadline.replaceAll("-", " "); }


                                    %>
                                    <h3 style="background:transparent;"><%=currentMedicament.getMedicamentName().substring(0,1).toUpperCase()%><%=currentMedicament.getMedicamentName().substring(1,currentMedicament.getMedicamentName().length())%></h3>
                                    Вие вземате <%=currentMedicament.getMedicamentName()%> от <span style="background-color:transparent;"><%=formattedDateFrom%></span>
                                    до <span style="background-color:transparent;"><%=formattedDeadline%></span>
                                    <% }
                                        System.out.println("counter (calendarDay) = " + counter);
                                    if(counter==0){%>
                                    <span class="medicamentTimetable" style="background:transparent;">На тази дата не сте приемали медикаменти или билки</span>
                                        <%}%>
                                </div>
                            </div>
                        </div>
                        <%}
                        else if(session.getAttribute("selectedDate")!=null){
                        System.out.println("Selected date = " + session.getAttribute("selectedDate"));
                        Date selectedDate = new SimpleDateFormat("yyyy-MM-dd").parse(session.getAttribute("selectedDate").toString());
                        String formattedSelectedDate = new SimpleDateFormat("dd-MMMM-yyyy").format(selectedDate);
                        if(formattedSelectedDate.contains("January")){ formattedSelectedDate = formattedSelectedDate.replaceAll("January", "Януари"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("February")){ formattedSelectedDate = formattedSelectedDate.replaceAll("February", "Февруари"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("March")){ formattedSelectedDate = formattedSelectedDate.replaceAll("March", "Март"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("April")){ formattedSelectedDate = formattedSelectedDate.replaceAll("April", "Април"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("May")){ formattedSelectedDate = formattedSelectedDate.replaceAll("May", "Май"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("June")) { formattedSelectedDate = formattedSelectedDate.replaceAll("June", "Юни"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("July")){ formattedSelectedDate = formattedSelectedDate.replaceAll("July", "Юли"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("August")){ formattedSelectedDate = formattedSelectedDate.replaceAll("August", "Август"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("September")){ formattedSelectedDate = formattedSelectedDate.replaceAll("September", "Септември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("October")){ formattedSelectedDate = formattedSelectedDate.replaceAll("October", "Октомври"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("November")){ formattedSelectedDate = formattedSelectedDate.replaceAll("November", "Ноември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        else if(formattedSelectedDate.contains("December")) { formattedSelectedDate = formattedSelectedDate.replaceAll("December", "Декември"); formattedSelectedDate = formattedSelectedDate.replaceAll("-", " "); }
                        %>
                        <h3 style="text-align: center"><%=formattedSelectedDate%></h3>
                        <hr class="style18"/>
                        <div class="scrollbar" id="style-8">
                            <div class="force-overflow">
                                <div style="overflow-y: auto; overflow-x:hidden; width:auto; height:auto;max-width: 100%;max-height: 200px;">
                                    <span class="medicamentTimetable" style="background:transparent;">На тази дата не сте приемали медикаменти или билки</span>
                                </div>
                            </div>
                        </div>
                        <%}%>
                </div>
        </div>
    </div>
    </div>
    </div>

    <script>
        function logoutClick() {
            var now = new Date();
            var time = now.getTime();
            time += 5 * 1000;
            now.setTime(time);
            document.cookie =
                'logoutButtonClicked='+true+';';
        }
    </script>

<script>
    function accountDeleteConfirm(){
        var txt;
        if (confirm("Сигурни ли сте, че искате ПЕРМАНЕНТНО да изтриете акаунта си?") == true) {
            document.getElementById("password").style.visibility="visible";
            document.getElementById("password_confirm").style.visibility="visible";
        } else {
            txt = "You pressed Cancel!";
        }
        document.getElementById("demo").innerHTML = txt;
        <%session.removeAttribute("logoutButtonClick");%>
    }
</script>
<script type="text/javascript">
    document.getElementById('searchBtn').onclick = function() {
        <%
            session.setAttribute("isSearching", true);
        %>
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
<script src="javascript/clndr.js"></script>
<script src="javascript/demo.js"></script>
</div>
</body>
</html>
