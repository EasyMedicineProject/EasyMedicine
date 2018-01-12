<%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/6/2018
  Time: 6:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link rel="stylesheet" type="text/css" href="css/RegisterStyle.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>
</head>
<body>
<div class="testbox">
    <h1>NATURAL MEDICINE</h1>

    <form method="POST" action="index">
        <hr>
        <p style="margin-left:65px">Регистрация</p>
        <hr>
        <label id="icon" for="email"><i class="fa fa-envelope"></i></label>
        <input type="text" name="email" id="email" placeholder="Имейл" required/>
        <label id="icon" for="password"><i class="fa fa-key"></i></label>
        <input type="password" name="password" id="password" placeholder="Парола" required/>
        <input type="submit" class="btn btn-success" value="Влез">
    </form>
</div>
</body>
</form>
</body>
</html>
