<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Translate list</title>
  <style>
    table, tr, td {
      border: 1px solid black;
      text-align:center;
    }
  </style>
</head>
<body>
<a href="/translate/register">새 번역 등록하기</a>
<br/>
<table>
  <thead>
  <tr>
    <td>ID</td>
    <td>언어</td>
    <td>원문</td>
    <td>번역문</td>
    <td>즐겨찾기 여부</td>
    <td>등록자</td>
    <td>등록일</td>
    <td></td>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="u" items="${translate}">
    <tr>
      <td>${u.id}</td>
      <td>${u.language}</td>
      <td>${u.original}</td>
      <td>${u.translated}</td>
      <td>${u.favorite}</td>
      <td>${u.userid}</td>
      <td>${u.date}</td>
      <td>
        <a href="/translate/delete?id=${u.id}">삭제</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

</body>
</html>
