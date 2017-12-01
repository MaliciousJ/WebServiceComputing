<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
  <title>Register</title>
</head>
<body>
<form:form modelAttribute="book">
  title: <form:input path="title"/><br/>
  author: <form:input path="author"/><br/>
  page: <form:password path="page"/><br/>
  <input type="submit" value="Register"/>
</form:form>
</body>
</html>