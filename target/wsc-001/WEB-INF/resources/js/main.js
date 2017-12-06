
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