<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Translate list</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
  <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
  <link href="/resources/css/main.css" rel="stylesheet" type="text/css" />
  <script src="/resources/js/googleAPI.js"></script>
  <!--Let browser know website is optimized for mobile-->
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <style>
    ::-webkit-scrollbar {
      display:none;
    }
    .collection { cursor: pointer;}
    table, tr, td {
      border: 1px solid black;
      text-align:center;
    }
  </style>
</head>
<body>
<div class="row">
  <div class="col s3" style="padding:0; margin:0; overflow-y:auto; overflow-x:hidden; height:1080px; -ms-overflow-style: none;">

    <c:forEach var="u" items="${translate}">
      <!-- Grey navigation panel -->
      <ul class="collection"  style="padding:0; margin:0;">
        <li id='"+key+"' class="collection-item avatar" onclick="fn_get_data_one(this.id);" >
          <i class="material-icons circle red">a</i>
          <span class="title"></span><p class='txt'>#날짜 : ${u.date}</p>
          <span class="title"></span><p class='txt'>#원문 : ${u.original}</p>
          <span class="title"></span><p class='txt'>#번역결과 : ${u.translated}</p>

        </li>
      </ul>
    </c:forEach>
  </div>
</div>

</body>
</html>
