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
    table, tr, td {
        border: 1px solid black;
        text-align:center;
    }
    .db_collection { cursor: pointer;}
    table, tr, td {
        border: 1px solid black;
        text-align:center;
    }
  </style>
</head>

<body>
<div class="row">
  <div class="col s3" style="padding:0; margin:0; overflow-y:auto; overflow-x:hidden; height:540px; -ms-overflow-style: none;">
    <!-- Grey navigation panel -->
    <ul class="collection" id="fb_collection"  style="padding:0; margin:0;" ></ul>
  </div>

  <div class="col s6" style="padding:0; margin:0; max-height:540px;">
    <!-- Teal page content  -->
    <nav>
      <div class="nav-wrapper"STYLE="background-color:#191970;">
        <div class="col s12">
          <a href="#!" class="breadcrumb"><span id="modifyDate"></span></a>
            <button class="btn waves-effect waves-center" type="submit" name="action"
                    style="width: 140pt; height: 44pt;  right: 10px; font-size: 20pt; border: 0px solid #7a157a;
                            -moz-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           -webkit-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                          font-weight: bold; background-color:#191970;"
                    onClick="location.href='/'";>◀  BACK
            </button>
          <img class="WCT-logo" src="/resources/cse_logo2.png" height="70" align="right" alt/>
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
        <form:input path="original" id="for_translate" class="final" value="" />
      </div>

      <div class="fixed-action-btn" style="position: relative; top: 1px; left: 24px;">
        <button class="btn waves-effect waves-center" type="submit" value="Register" id="trans_submit" style="font-size: 20pt"
                onClick="alertStr('번역 완료!') ">Register
          <i class="material-icons center">check_box</i>
        </button>
      </div>
      <div class="fixed-action-btn" style="position: relative; bottom: 51px; left: 236px">
        <a class="btn-floating btn-large waves-effect waves-light blue" style="height: 37px; width: 37px; padding: 3px; border-radius: 3px" onclick="start();" >
          <img class="translation-icon" src="/resources/mic.png" width="32" height="32"></a>
      </div>
    </form:form>
  </div>

  <div class="col s3" style="padding:0; margin:0; overflow-y:auto; overflow-x:hidden; -ms-overflow-style: none;">
    <c:forEach var="u" items="${translates}">
      <!-- Grey navigation panel -->
      <ul class="collection"  style="padding:0; margin:0;">
        <li id='"+key+"' class="collection-item avatar" onclick="fn_get_data_one(this.id);" >
          <i class="material-icons circle red">a</i>
          <span class="title"></span><p class='txt'>#날짜 : ${u.date}</p>
          <span class="title"></span><p class='txt'>#원문 : ${u.original}</p>
          <span class="title"></span><p class='txt'>#번역결과 : ${u.translated}</p>
          <span class="title"></span><p class='txt'>#번역 횟수 : ${u.favorite}</p>
        </li>
      </ul>
    </c:forEach>
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

<footer class="page-footer"STYLE="background-color:#191970;">
  <div class="container">
    <div class="row">
      <div class="col l6 s12">
        <img class="cse-logo" src="${pageContext.request.contextPath}/resources/Team_Text.png">
      </div>
      <div class="col l4 offset-l2 s12">
        <h5 class="white-text">Team Member</h5>
        <ul>
          <li  class="white-text text-lighten-3">컴퓨터 공학부 2014136068 손지원</li>
          <li  class="white-text text-lighten-3">컴퓨터 공학부 2011136124 진규환</li>
          <li  class="white-text text-lighten-3">컴퓨터 공학부 2013136134 최준혁</li>
        </ul>
      </div>
      <div class="col l4 offset-l2 s12">
        <h5 class="white-text">CONTACT</h5>
        <ul>
          <li><a class="white-text text-lighten-3" href="https://github.com/MaliciousJ/WebServiceComputing">GitHub</a></li>
          <li><a class="white-text text-lighten-3" href="https://www.koreatech.ac.kr/kor.do">KOREATECH</a></li>
          <li><a class="white-text text-lighten-3" href="https://cse.koreatech.ac.kr/">컴퓨터 공학부</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="footer-copyright">
    <div class="container">
      © 2017 Copyright Text
    </div>
  </div>
</footer>

<!--Import jQuery before materialize.js-->
<script src="${pageContext.request.contextPath}/resources/js/firebaseAPI.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/googleAPI.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.6.2/firebase.js"></script>
<script>
    var auth, database, userInfo, selectedKey;
    // Initialize Firebase
    var config = {
        apiKey: "AIzaSyAea4uK811VPcIuhP8T0yVnbpLOjJyvGhE",
        authDomain: "memowebapp-192af.firebaseapp.com",
        databaseURL: "https://memowebapp-192af.firebaseio.com",
        projectId: "memowebapp-192af",
        storageBucket: "memowebapp-192af.appspot.com",
        messagingSenderId: "1083012160638"
    };
    firebase.initializeApp(config);

    auth = firebase.auth();
    database = firebase.database();
    var authProvider = new firebase.auth.GoogleAuthProvider();

    auth.onAuthStateChanged(function(user){
        if(user){
            // 인증 성공부
            console.log("success");
            console.log(user);
            //
            userInfo = user;
            get_memo_list();
        }
        else{
            // 인증 실패부
            auth.signInWithPopup(authProvider);
        }
    });

    function get_memo_list(){
        console.log(userInfo.uid);
        var memoRef = database.ref('memos/'+ userInfo.uid);

        memoRef.on('child_added', on_child_added);
        memoRef.on('child_changed', function(data){
            console.log(data.key);
            console.log(data.val());

            var key = data.key;
            var txt = data.val().txt;
            var title = txt.substr(0, txt.indexOf('\n'));
            // 갱신
            $("#"+ key + " >.title").text(title);
            $("#"+ key + " >.txt").text(txt);
        });
    }

    function on_child_added(data){
        var key = data.key;
        var memoData = data.val();
        var txt = memoData.txt;
        var title = txt.substr(0, txt.indexOf('\n'));
        var firstTxt =txt.substr(0, 1);

        var html =
            "<li id='"+key+"' class=\"collection-item avatar\" onclick=\"fn_get_data_one(this.id);\" >" +
            "<i class=\"material-icons circle red\">" + firstTxt + "</i>" +
            "<span class=\"title\">" + title + "</span>" +
            "<p class='txt'>" + txt + "<br>" +
            "</p>" +
            "<a href=\"#!\" onClick=\"fn_delete_data('"+key+"')\"class=\"secondary-content\"><i class=\"material-icons\">clear</i></a>"+
            "</li>";
        $("#fb_collection").append(html);
    }

    function fn_get_data_one(key){
        selectedKey = key;
        var memoRef = database.ref('memos/'+ userInfo.uid + '/' + key)
            .once('value').then(function(snapshot){
                $(".textarea").val(snapshot.val().txt);
            });
    }

    function fn_delete_data(key){
        if(!confirm('삭제하시겠습니까?')){
            return;
        }
        var memoRef = database.ref('memos/' + userInfo.uid+'/'+key);
        memoRef.remove();
        $("#"+key).remove();
        initMemo();
    }

    function save_data( txt ){
        var memoRef = database.ref('memos/'+ userInfo.uid );
        //var txt = $(".textarea").val();
        if(txt == ''){
            return;
        }
        if( selectedKey ){
            memoRef = database.ref('memos/'+ userInfo.uid + '/' + selectedKey);
            memoRef.update({
                txt : txt,
                createDate : new Date().getTime(),
                updateDate : new Date().getTime()
            });
        } else{
            // push
            memoRef.push({
                txt : txt,
                createDate : new Date().getTime()
            });
        }
    }

    function initMemo(){
        $('.textarea').val('');
        selectedKey=null;
    }

    function alertStr(msg) {
        alert(msg);
        save_data( $(".textarea").val() );
    }

</script>
</body>
</html>