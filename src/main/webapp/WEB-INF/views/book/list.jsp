<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Book list</title>
  <style>
    table, tr, td {
      border: 1px solid black;
      text-align:center;
    }
  </style>
</head>
<body>
<a href="/book/register">책 등록하기</a>
<br/>
<table>
  <thead>
  <tr>
    <td>ID</td>
    <td>서적명</td>
    <td>저자</td>
    <td>페이지 수</td>
    <td>userID</td>
    <td></td>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="u" items="${books}">
    <tr>
      <td>${u.id}</td>
      <td>${u.title}</td>
      <td>${u.author}</td>
      <td>${u.page}</td>
      <td>${u.userid}</td>
      <td>
        <a href="/book/delete?id=${u.id}">삭제</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>
