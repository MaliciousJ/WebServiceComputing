<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>User list</title>
  <style>
    table, tr, td {
      border: 1px solid black;
      text-align:center;
    }
  </style>
</head>
<body>
<a href="/user/signup">회원가입으로 가기</a>
<br/>
<table>
  <thead>
  <tr>
    <td>ID</td>
    <td>이름</td>
    <td>E-mail</td>
    <td>비밀번호</td>
    <td>나이</td>
    <td></td>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="u" items="${users}">
    <tr>
      <td>${u.id}</td>
      <td>${u.name}</td>
      <td>${u.email}</td>
      <td>${u.password}</td>
      <td>${u.age}</td>
      <td>
        <a href="/user/edit?id=${u.id}">수정</a><br/>
        <a href="/user/delete?id=${u.id}">삭제</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>
