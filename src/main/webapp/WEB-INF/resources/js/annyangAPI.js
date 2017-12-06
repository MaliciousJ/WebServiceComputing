/*!
 *
 * WebRTC Lab
 * @author dodortus (codejs.co.kr / dodortus@gmail.com)
 *
 */
function start2() {
    if (typeof webkitSpeechRecognition != 'function') {
        alert('크롬에서만 동작 합니다.');
        return false;
    }

    var isRecognizing = false;
    var ignoreOnend = false;
    var audio = document.getElementById('audio');

    var $btnMic = $('#btn-mic');
    var $result = $('#result');
    var $iconMusic = $('#icon-music');

    var recognition2 = annyang.getSpeechRecognizer();
    var finalTranscript2 = '';


    // 버튼을 눌렀을 때
    recognition2.onstart = function() {
        console.log('onstart', arguments);
        isRecognizing = true;

        // 버튼의 불을 켠다
        $btnMic.attr('class', 'on');
    };

    recognition2.onend = function() {
        console.log('onend', arguments);

        isRecognizing = false;

        if (ignoreOnend) {
            return false;
        }

        // 버튼의 불을 끈다
        $btnMic.attr('class', 'off');

        // 최종 스크립트가 비어있다면 종료
        if (!finalTranscript2) {
            console.log('empty finalTranscript');
            return false;
        }

        // 텍스트영역을 비움
        if (window.getSelection) {
            window.getSelection().removeAllRanges();
            var range = document.createRange();
            range.selectNode(document.getElementById('final-span2'));
            window.getSelection().addRange(range);
        }
    };

    recognition2.onresult = function(event) {
        var interimTranscript = '';
        finalTranscript = '';
        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                finalTranscript += event.results[i][0].transcript;
                //console.log("final_transcript = "+finalTranscript);
                //annyang.trigger(final_transcript); //If the sentence is "final" for the Web Speech API, we can try to trigger the sentence
            } else {
                interimTranscript += event.results[i][0].transcript;
                //console.log("interim_transcript="+interimTranscript);
            }
        }
        // 첫 문자를 대문자로 변경
        finalTranscript = capitalize(finalTranscript);

        // 텍스트 영역에 번역결과 삽입
        final_span2.innerHTML = linebreak(finalTranscript);
        interim_span2.innerHTML = linebreak(interimTranscript);


        console.log('### = '+finalTranscript);
    };

    // 에러 결과 처리
    recognition2.onerror = function(event) {
        console.log('onerror', event);

        if (event.error == 'no-speech') {
            ignoreOnend = true;
        } else if (event.error == 'audio-capture') {
            ignoreOnend = true;
        } else if (event.error == 'not-allowed') {
            ignoreOnend = true;
        }

        $btnMic.attr('class', 'off');
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

    // 버튼이 눌렸을 때 번역 시작 함수
    function start2(event) {
        if (isRecognizing) {
            recognition2.pause();
            return;
        }

        recognition2.start({autoRestart: false, continuous: true});
        recognition2.interimResults = true;
        ignoreOnend = false;

        finalTranscript2 = '';
        final_span2.innerHTML = '';
        interim_span2.innerHTML = '';

    }

};