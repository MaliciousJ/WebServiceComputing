<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
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
  </style>
</head>

<body>
<div class="row">
  <div class="col s3" style="padding:0; margin:0; overflow-y:auto; overflow-x:hidden; height:540px; -ms-overflow-style: none;">
    <!-- Grey navigation panel -->
    <ul class="collection"  style="padding:0; margin:0;"></ul>
  </div>

  <div class="col s9" style="padding:0; margin:0; max-height:540px;">
    <!-- Teal page content  -->
    <nav>
      <div class="nav-wrapper">
        <div class="col s12">
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
    </nav>
    <form:form modelAttribute="Translate">
      Source:<br><br>
      <form:radiobutton path="source" value="ko" label ="한국어"/>&ensp;
      <form:radiobutton path="source" value="en" label ="영어"/>&ensp;<br><br>
      Target:<br><br>
      <form:radiobutton path="target" value="ko" label ="한국어"/>&ensp;
      <form:radiobutton path="target" value="en" label ="영어"/>&ensp;<br><br>
      Voice Recording:<br><br/>


      <div id="result">

        <span class="final" id="final_span"></span>
        <span class="interim" id="interim_span"></span>
        <form:input type="hidden" path="original" id="for_translate" class="final" value="" />
      </div>

      <div class="fixed-action-btn" style="position: relative; top: 1px; left: 24px;">
        <button class="btn waves-effect waves-center" type="submit" value="Register" id="trans_submit" style="font-size: 20pt"
                onClick="alertStr('번역 완료!') ">Register
          <i class="material-icons center">check_box</i>
        </button>
      </div>
      <div class="fixed-action-btn" style="position: relative; bottom: 51px; left: 236px">
        <a class="btn-floating btn-large waves-effect waves-light blue" style="height: 37px; width: 37px; padding: 2px; border-radius: 3px" onclick="start();" >
          <img class="translation-icon" src="/resources/mic.png" width="32" height="34"></a>
      </div>


    </form:form>
  </div>

  <div class="preloader-wrapper big active" style="position:absolute; z-index:1000; left:50%; top:50%; display:none;">
    <div class="spinner-layer spinner-blue-only">
      <div class="circle-clipper left">
        <div class="circle"></div>
      </div><div class="gap-patch">
      <div class="circle"></div>
    </div><div class="circle-clipper right">
      <div class="circle"></div>
    </div>
    </div>
  </div>
</div>

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

<!--Import jQuery before materialize.js-->
<script src="${pageContext.request.contextPath}/resources/js/firebaseAPI.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/googleAPI.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.6.2/firebase.js"></script>
</body>
</html>