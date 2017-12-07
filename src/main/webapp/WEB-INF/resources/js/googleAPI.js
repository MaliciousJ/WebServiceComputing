
var recognition = new webkitSpeechRecognition();
var isRecognizing = false;
var ignoreOnend = false;
var finalTranscript = '';
musicCnt = 0;
maxMusic = 3;
announce = false;
submitted = false;
recognition.continuous = true;
recognition.interimResults = true;
a = 0;
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
    if ('undefined' == typeof(event.results)) {
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

    if(location.href.indexOf("/translate/register") != -1) {
        for_translate.value = linebreak(finalTranscript);
    }
    console.log('finalTranscript', finalTranscript);
    console.log('interimTranscript', interimTranscript);
    fireCommand(interimTranscript);
};
function moveMusic(txt) {
    var audio = document.getElementById('audio');
    var audio2 = document.getElementById('audio2');
    var audio3 = document.getElementById('audio3');

    if(txt == 'next')
        musicCnt = (musicCnt + 1) % maxMusic;
    else if(txt == 'prev'){
        musicCnt = (musicCnt - 1 + maxMusic) % maxMusic;
    }
    console.log('musicCount : ' + musicCnt);
    if(musicCnt == 0){
        audio2.pause();
        audio3.pause();
        audio.currentTime = 0;
        audio.play();
    }

    else if(musicCnt == 1){
        audio.pause();
        audio3.pause();
        audio2.currentTime = 0;
        audio2.play();
    }
    else if(musicCnt == 2){
        audio.pause();
        audio2.pause();
        audio3.currentTime = 0;
        audio3.play();
    }
}

function fireCommand(string) {
    if (string.endsWith('몇시야') || string.endsWith('몇 시야')|| string.endsWith('몇시 야')) {
        var d = new Date();
        if(announce == false) {
            textToSpeech('지금 시각은' + d.getHours() + '시' + d.getMinutes() + '분 입니다');
            announce = true;
        } else
            announce = false;
    } else if (string.endsWith('저장') || string.endsWith('저 장')) {
        if(submitted == false) {
            alertStr('제출 완료');
            submitted = true;
        } else
            submitted = false;

    } else if (string.endsWith('노래 켜') || string.endsWith('음악 켜')) {
        var audio = document.getElementById('audio');
        audio.play();
    } else if (string.endsWith('노래 꺼') || string.endsWith('음악 꺼')) {
        var audio = document.getElementById('audio');
        audio.pause();
    } else if (string.endsWith('볼륨 업') || string.endsWith('볼륨업')) {
        var audio = document.getElementById('audio');
        audio.volume += 0.3;
    } else if (string.endsWith('볼륨 다운') || string.endsWith('볼륨다운')) {
        var audio = document.getElementById('audio');
        audio.volume -= 0.3;
    } else if (string.endsWith('다음')|| string.endsWith('다 음')|| string.endsWith('다 음 다 음')|| string.endsWith('다음 다음')) {
        moveMusic('next');
    }  else if (string.endsWith('이전')|| string.endsWith('이 전')) {
        moveMusic('prev');
    } else if (string.endsWith('스피치') || string.endsWith('말해줘') || string.endsWith('말 해 줘')|| string.endsWith('말해 줘')|| string.endsWith('말 해줘')) {
        textToSpeech($('#final_span').text() || '전 음성 인식된 글자를 읽습니다.');
    } else if (string.endsWith('번역') || string.endsWith('번 역')) {
        location.href = "/translate/register";
    } else if (string.endsWith('녹음') || string.endsWith('녹 음')) {
        location.href = "/translate/register";
    } else if (string.endsWith('메모') || string.endsWith('메 모')) {
        location.href = "/memo";
    } else if (string.endsWith('홈') || string.endsWith('메인')) {
        location.href = "/";
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

function removeScript( id ) {
    id = ''
}


function alertStr(msg) {
    alert(msg);
    save_data( $(".textarea").val() );
}

function resetTXT() {
    $('.textarea').innerHTML = '';
    $('#final_span').innerHTML = '';
    $('#interim_span').innerHTML = '';
    $('#for_translate').innerHTML = '';
}