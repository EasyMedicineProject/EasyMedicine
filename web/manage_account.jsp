<%--
  Created by IntelliJ IDEA.
  User: ivan
  Date: 1/11/2018
  Time: 12:46 AM
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
    <title>Manage acoount</title>
</head>
<body>
<button class="btn btn-success" onclick="accountDeleteConfirm()">Изтрий акаунт</button><br/>
        <form action="index" style="visibility:hidden " method="post">
            <input id="password" name="password" style="visibility:hidden" type="password" placeholder="парола"/>
            <input  id="password_confirm" style="visibility:hidden" type="submit"  class="btn btn-danger" value="потвърди"/>
        </form>


        <script>
            function accountDeleteConfirm(){
                var txt;
                if (confirm("Сигурни ли сте, че искате ПЕРМАНЕНТНО дда изтриете акаунта си?") == true) {
                    document.getElementById("password").style.visibility="visible";
                    document.getElementById("password_confirm").style.visibility="visible";
                } else {
                    txt = "You pressed Cancel!";
                }
                document.getElementById("demo").innerHTML = txt;
            }
        </script>
    <form action="password_change.jsp">
        <input type="submit" class="btn btn-info" value="Смяна на парола"/>
    </form>
</body>
</html>
