<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Signin</title>
</head>
<body>
    <form action="j_spring_security_check" method="post">
        <input type="text" placeholder="email" name="j_username"/>
        <input type="password" placeholder="password" name="j_password"/>
        <input type="submit" value="Signin"/>
    </form>
</body>
</html>