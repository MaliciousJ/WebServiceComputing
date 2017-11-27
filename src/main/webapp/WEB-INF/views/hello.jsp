<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">

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
    <div class="col s3" style="padding:0; margin:0; overflow-y:auto; overflow-x:hidden; height:1080px; -ms-overflow-style: none;">
        <!-- Grey navigation panel -->
        <ul class="collection"  style="padding:0; margin:0;"></ul>
    </div>

    <div class="col s9" style="padding:0; margin:0; max-height:1080px;">
        <!-- Teal page content  -->
        <nav>
            <div class="nav-wrapper">
                <div class="col s12">
                    <a href="#!" class="breadcrumb"><span id="modifyDate"></span></a>

                </div>
            </div>
        </nav>

        <textarea style="height:1000px;" class="textarea" width="100%" rows="1000" placeholder="새로운 메모를 입력해보세요^^"></textarea>
    </div>

    <div class="fixed-action-btn" style="bottom: 35px; right: 170px;">
        <a class="btn-floating btn-large waves-effect waves-light red" onclick='initMemo()'><i class="material-icons">mic</i></a>
    </div>
    <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
        <button class="btn waves-effect waves-center" type="submit" name="action"
                onClick="Materialize.toast('SUBMIT', 1000)">Submit
            <i class="material-icons center">check_box</i>
        </button>
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

<!--Import jQuery before materialize.js-->
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

    function save_data(){
        var memoRef = database.ref('memos/'+ userInfo.uid );
        var txt = $(".textarea").val();
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

    $(function(){
        $(".textarea").blur(function(){
            save_data();
        });
    });


</script>


</body>
</html>
