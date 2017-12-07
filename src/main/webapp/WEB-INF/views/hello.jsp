<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
    <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
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
            <div class="nav-wrapper" STYLE="background-color:#191970;">
                <div class="col s12">
                    <a href="#!" class="breadcrumb" >
                        <span id="modifyDate"></span></a>
                    <button class="btn waves-effect waves-center" type="submit" name="action"
                            style="width: 100pt; height: 48pt;  right: 10px; font-size: 20pt; border: 0px solid #7a157a;
                            -moz-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           -webkit-box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                           box-shadow: 0px 1px 3px rgba(255,255,255,0.5), inset 0px 0px 2px rgba(238,98,115,1);
                          font-weight: bold; background-color:#191970;"
                            onClick="location.href='/'";>BACK
                    </button>
                    <img class="WCT-logo" src="/resources/cse_logo2.png" height="70" align="right" alt/>
                </div>

            </div>
        </nav>

        <div class="fixed-action-btn" style="position: relative; top: 10px; left: 1px">
            <a class="btn-floating btn-large waves-effect waves-light red" onClick="start();" style="border-radius: 12px"><i class="material-icons">headset_mic</i></a>
        </div>

        <div id="instruction" style="position: relative; border: 1px solid; padding: 10px;margin-top: -40px; margin-left: 61px; margin-right: 10px;">
            메모, 녹음, 번역

            <ul>[음성 인식]</ul>
            <ul>아래에 인식된 음성이 출력됩니다.</ul>
            <span class="final" id="final_span"></span>
            <span class="interim" id="interim_span"></span>
            <form:input  path="original" id="for_translate" class="final" value="" />
        </div>

        <div class="fixed-action-btn" style="position: relative; top: 70px; left: 350px;">
            <button class="btn waves-effect waves-center" type="button" onclick="location.href='/memo'"; name="memo"
                    style="background-color: #191970; border: none; height: 150px; width: 150px; border-radius: 12px;
            color: white; padding: 10px 15px; text-align: center; text-decoration: none; display: inline-block; font-size: 25px;">
                <img class="notepad-icon" src="/resources/notepad.png" alt>MEMO
            </button>
        </div>

        <div class="fixed-action-btn" style="position: relative; bottom: 95px; left: 505px">
            <button class="btn waves-effect waves-center" type="button" onClick="location.href='/translate/register'" name="translation"
                    style="background-color: #191970; border: none; height: 150px; width: 150px; border-radius: 12px;
            color: white; padding: 5px 15px; text-align: center; text-decoration: none; display: inline-block; font-size: 23px;">
                <img class="translation-icon" src="/resources/translation.png" width="100" height="100" alt>번역
            </button>
        </div>

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

<footer class="page-footer" STYLE="background-color:#191970;">
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
                    <li><a class="white-text text-lighten-3" href="https://github.com/MaliciousJ/WebServiceComputingGitHub">GitHub</a></li>
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

<script src="${pageContext.request.contextPath}/resources/js/firebaseAPI.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/googleAPI.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.6.2/firebase.js"></script>
<script>
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
            var txt =data.val().txt;
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
        $(".collection").append(html);
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

</script>
</body>
</html>
