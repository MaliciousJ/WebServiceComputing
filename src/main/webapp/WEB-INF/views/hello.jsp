<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
=======
<!DOCTYPE html>
<html>
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <link href="/resources/css/main.css" rel="stylesheet" type="text/css" />
<<<<<<< HEAD
    <script src='/resources/js/annyang.js'></script>
    <script src='/resources/js/annyangAPI.js'></script>
    <script src="/resources/js/googleAPI.js"></script>
    <title></title>

=======
    <script src="/resources/js/googleAPI.js"></script>
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        ::-webkit-scrollbar {
            display:none;
        }
        .collection { cursor: pointer;}
    </style>
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c
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

                </div>
            </div>
        </nav>

        <textarea style="height:300px;" class="textarea" width="100%" rows="100" placeholder="새로운 메모를 입력해보세요^^"></textarea>

        <div id="result">
            <span class="final" id="final_span"></span>
            <span class="interim" id="interim_span"></span>
        </div>

        <div class="fixed-action-btn" style="bottom: 35px; right: 230px;">
            <a id="test" class="btn-floating btn-large waves-effect waves-light red" onclick="start();"><i class="material-icons">mic</i></a>
        </div>

        <div class="fixed-action-btn" style="bottom: 35px; right: 170px;">
            <a id="btn-mic2" class="btn-floating btn-large waves-effect waves-light red" onclick="save_data(document.getElementById('interim_span').innerHTML);
                                                                                                            Materialize.toast('SUBMIT', 1000);
                                                                                                            "><i class="material-icons">stop</i></a>
        </div>
        <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
            <button class="btn waves-effect waves-center" type="submit" name="action"
                    onClick="Materialize.toast('SUBMIT', 1000)">Submit
                <i class="material-icons center">check_box</i>
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
<<<<<<< HEAD
<div id="result2">
    <span class="final" id="final_span2"></span>
    <span class="interim" id="interim_span2"></span>
</div>
<button id="btn-mic" class="off">마이크 <span></span></button>
<button id="btn-tts">Text to speech</button>
=======

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

    $(function(){
        $(".textarea").blur(function(){
            save_data( $(".textarea").val() );
        });
    });

    /*!
     *
     * WebRTC Lab
     * @author dodortus (codejs.co.kr / dodortus@gmail.com)
     *
     */
        if (typeof webkitSpeechRecognition != 'function') {
            alert('크롬에서만 동작 합니다.');
        }

        var recognition = new webkitSpeechRecognition();
        var isRecognizing = false;
        var ignoreOnend = false;
        var finalTranscript = '';
        var $btnMic = $('#btn-mic');
        var $result = $('#result');
        recognition.continuous = true;
        recognition.interimResults = true;

        recognition.onstart = function() {
            console.log('onstart', arguments);
            isRecognizing = true;

            //$btnMic.attr('class', 'on');
        };

        recognition.onend = function() {
            console.log('onend', arguments);
            isRecognizing = false;

            if (ignoreOnend) {
                return false;
            }


            // DO end process
            /*
            $btnMic.attr('class', 'off');
            if (!finalTranscript) {
                console.log('empty finalTranscript');
                return false;
            }*/

            if (window.getSelection) {
                window.getSelection().removeAllRanges();
                var range = document.createRange();
                range.selectNode(document.getElementById('final-span'));
                window.getSelection().addRange(range);
            }

        };

        recognition.onresult = function(event) {
            console.log('onresult', event);

            var interimTranscript = '';
            if (typeof(event.results) == 'undefined') {
                recognition.onend = null;
                recognition.stop();
                return;
            }

            for (var i = event.resultIndex; i < event.results.length; ++i) {
                if (event.results[i].isFinal) {
                    finalTranscript += event.results[i][0].transcript;
                } else {
                    interimTranscript += event.results[i][0].transcript;
                }
            }

            finalTranscript = capitalize(finalTranscript);
            final_span.innerHTML = linebreak(finalTranscript);
            interim_span.innerHTML = linebreak(interimTranscript);

            console.log('finalTranscript', finalTranscript);
            console.log('interimTranscript', interimTranscript);
            fireCommand(interimTranscript);
        };

        function fireCommand(string) {
            if (string.endsWith('알람') || string.endsWith('알 람')) {
                alert('알람');
            } else if (string.endsWith('노래 켜') || string.endsWith('음악 켜')) {
                audio.play();
                $iconMusic.addClass('visible');
            } else if (string.endsWith('노래 꺼') || string.endsWith('음악 꺼')) {
                audio.pause();
                $iconMusic.removeClass('visible');
            } else if (string.endsWith('볼륨 업') || string.endsWith('볼륨업')) {
                audio.volume += 0.2;
            } else if (string.endsWith('볼륨 다운') || string.endsWith('볼륨다운')) {
                audio.volume -= 0.2;
            } else if (string.endsWith('스피치') || string.endsWith('말해줘') || string.endsWith('말 해 줘')) {
                textToSpeech($('#final_span').text() || '전 음성 인식된 글자를 읽습니다.');
            }
        }

        recognition.onerror = function(event) {
            console.log('onerror', event);

            if (event.error == 'no-speech') {
                ignoreOnend = true;
            } else if (event.error == 'audio-capture') {
                ignoreOnend = true;
            } else if (event.error == 'not-allowed') {
                ignoreOnend = true;
            }

            //$btnMic.attr('class', 'off');
        };

        var two_line = /\n\n/g;
        var one_line = /\n/g;
        var first_char = /\S/;

        function linebreak(s) {
            return s.replace(two_line, '<p></p>').replace(one_line, '<br>');
        }

        function capitalize(s) {
            return s.replace(first_char, function(m) {
                return m.toUpperCase();
            });
        }

        function start(event) {
            if (isRecognizing) {
                recognition.stop();
                return;
            }
            /*
            if(final_span.innerHTML != '') {
                save_data(document.getElementById('final').innerHTML);
            }*/
            //recognition.lang = 'en-US';
            recognition.lang = 'ko-KR';
            recognition.start();
            ignoreOnend = false;

            finalTranscript = '';
            final_span.innerHTML = '';
            interim_span.innerHTML = '';

        }

        /**
         * textToSpeech
         * 지원: 크롬, 사파리, 오페라, 엣지
         */
        function textToSpeech(text) {
            console.log('textToSpeech', arguments);

            // simple version
            speechSynthesis.speak(new SpeechSynthesisUtterance(text));
        }

        function requestServer() {
            $.ajax({
                method: 'post',
                url: 'https://www.google.com/speech-api/v2/recognize?output=json&lang=en-us&key=AIzaSyDX-LaY9JyYWxwAIb7BlPGZBKYUBtHzah4',
                data: '/examples/speech-recognition/hello.wav',
                contentType: 'audio/l16; rate=16000;', // 'audio/x-flac; rate=44100;',
                success: function(data) {

                },
                error: function(xhr) {

                }
            });
        }

        $btnMic.click(start);
        $('#btn-tts').click(function() {
            textToSpeech($('#final_span').text() || '전 음성 인식된 글자를 읽습니다.');
        });

        function removeScript( id ) {
            id = ''
        }

</script>

>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c

<script type = "text/javascript">
    var t = document.getElementById('btn-mic');
    t.addEventListener('click', function(event){
        start();
    });
    t.addEventListener('click', function(event){
        start2();
    });
</script>

</body>
