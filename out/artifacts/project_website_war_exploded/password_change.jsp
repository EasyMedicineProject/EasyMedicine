<%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/11/2018
  Time: 1:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/RegisterStyle.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>
    <title>Easy Medicine</title>
</head>
<body>
<form method="post" action="login">
    <label id="icon" for="currentPassword">Current password: </label>
    <input type="password" name="currentPassword" id="currentPassword" placeholder="Current password"/><br/>
    <label id="icon" for="currentPassword">New password: </label>
    <input type="password" name="newPassword" id="newPassword" placeholder="New password"/><br/>
    <label id="icon" for="newPasswordRepeated">Repeat new password: </label>
    <input type="password" name="newPasswordRepeated" id="newPasswordRepeated" onchange="check()" placeholder="Repeat new password"/><br/>
    <div style="color: red" id="passwordMatch"></div>

    <input type="submit" class="btn btn-success" value="Потвърди"/>

    <script type="text/javascript">
        function check() {
            if (document.getElementById("newPassword").value != document.getElementById("newPasswordRepeated").value)
                document.getElementById("passwordMatch").innerHTML = "Паролите не съвпадат";
        }
    </script>
</form>
</body>
</html>
