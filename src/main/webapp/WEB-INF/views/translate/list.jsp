<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
  <title>Translate list</title>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
  <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
  <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
  <script src="${pageContext.request.contextPath}/resources/js/googleAPI.js"></script>
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

    <div class="nav-wrapper">
      <div class="col s12"><!--TODO 어째선지 버튼 오른쪽의 배경이 적용되지 않고 있음. 해결 필요-->
        <a href="#!" class="breadcrumb"><span id="modifyDate"></span></a>
        <button class="btn waves-effect waves-center" type="submit" name="action"
                style="width: 100pt; height: 48pt;  right: 10px; font-size: 20pt; border: 0px solid #7a157a;
                            -moz-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           -webkit-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                          font-weight: bold; background-color: #ee6e73;"
                onClick="location.href='/'">BACK
        </button>
      </div>
    </div>

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

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/googleAPI.js"></script>
</body>


<footer class="page-footer">
  <div class="container">
    <div class="row">
      <div class="col l6 s12">
        <h5 class="white-text">Web Service Coputing Term Project</h5>
        <img class="cse-logo" src="/resources/cse_logo.png" alt>
      </div>
      <div class="col l4 offset-l2 s12">
        <h5 class="white-text">Team Member</h5>
        <ul>
          <li  class="grey-text text-lighten-3">컴퓨터 공학부 2014136068 손지원</li>
          <li  class="grey-text text-lighten-3">컴퓨터 공학부 2011136124 진규환</li>
          <li  class="grey-text text-lighten-3">컴퓨터 공학부 2013136134 최준혁</li>
        </ul>
      </div>
      <div class="col l4 offset-l2 s12">
        <h5 class="white-text">CONTACT</h5>
        <ul>
          <li><a class="grey-text text-lighten-3" href="https://github.com/MaliciousJ/WebServiceComputingGitHub">GitHub</a></li>
          <li><a class="grey-text text-lighten-3" href="https://www.koreatech.ac.kr/kor.do">KOREATECH</a></li>
          <li><a class="grey-text text-lighten-3" href="https://cse.koreatech.ac.kr/">컴퓨터 공학부</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="footer-copyright">
    <div class="container">
      © 2017 Copyright Text
      <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
    </div>
  </div>
</footer>
</html>
