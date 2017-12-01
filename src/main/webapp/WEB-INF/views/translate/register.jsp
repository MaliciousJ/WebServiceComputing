<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
  <title>Register</title>
</head>
<body>
<form:form modelAttribute="Translate">
  Language: <form:input path="language"/><br/>
  Original: <form:input path="original"/><br/>
  Translated: <form:input path="translated"/><br/>
  favorite: <form:checkbox path="favorite"/><br/>
  <input type="submit" value="Register"/>
</form:form>
</body>
</html>