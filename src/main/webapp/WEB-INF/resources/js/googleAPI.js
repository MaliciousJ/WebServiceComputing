/*!
 *
 * WebRTC Lab 
 * @author dodortus (codejs.co.kr / dodortus@gmail.com)
 *
 */
function start() {
    if (typeof webkitSpeechRecognition != 'function') {
<<<<<<< HEAD
       alert('크롬에서만 동작 합니다.');
        return false;
     }
=======
        alert('크롬에서만 동작 합니다.');
        return false;
    }
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c

    var recognition = new webkitSpeechRecognition();
    var isRecognizing = false;
    var ignoreOnend = false;
    var finalTranscript = '';
<<<<<<< HEAD

=======
    var $btnMic = $('#btn-mic');
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c
    var $result = $('#result');
    recognition.continuous = true;
    recognition.interimResults = true;

<<<<<<< HEAD
    // 버튼을 눌렀을 때
     recognition.onstart = function() {
       console.log('onstart', arguments);
      isRecognizing = true;

       // 버튼의 불을 켠다
       $btnMic.attr('class', 'on');
     };

    recognition.onend = function() {
      console.log('onend', arguments);

      isRecognizing = false;

      if (ignoreOnend) {
        return false;
      }

      // 버튼의 불을 끈다
      $btnMic.attr('class', 'off');

      // 최종 스크립트가 비어있다면 종료
      if (!finalTranscript) {
        console.log('empty finalTranscript');
        return false;
      }

      // 텍스트영역을 비움
      if (window.getSelection) {
          window.getSelection().removeAllRanges();
          var range = document.createRange();
          range.selectNode(document.getElementById('final_span'));
          window.getSelection().addRange(range);
      }
  };

    // 번역결과 저장함수
    recognition.onresult = function(event) {
    console.log('onresult', event);

    var interimTranscript = '';

    // 결과가 비어있다면 종료
    if (typeof(event.results) == 'undefined') {
      recognition.onend = null;
      recognition.stop();
      return;
    }

    // 번역된 결과의 글자 수만큼 반복
    for (var i = event.resultIndex; i < event.results.length; ++i) {
      // 마지막 글자라면 최종 스크립트에 추가
      if (event.results[i].isFinal) {
        finalTranscript += event.results[i][0].transcript;
      // 아니라면 중간번역 스크립트에 추가
      } else {
        interimTranscript += event.results[i][0].transcript;
      }
    }

    // 첫 문자를 대문자로 변경
    finalTranscript = capitalize(finalTranscript);

    // 텍스트 영역에 번역결과 삽입
    final_span.innerHTML = linebreak(finalTranscript);
    interim_span.innerHTML = linebreak(interimTranscript);

    console.log('@@@ = ', finalTranscript);
    // 키워드 인식
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
  // 에러 결과 처리
  recognition.onerror = function(event) {
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
=======
    recognition.onstart = function() {
        console.log('onstart', arguments);
        isRecognizing = true;

        $btnMic.attr('class', 'on');
    };

    recognition.onend = function() {
        console.log('onend', arguments);
        isRecognizing = false;

        if (ignoreOnend) {
            return false;
        }

        // DO end process
        $btnMic.attr('class', 'off');
        if (!finalTranscript) {
            console.log('empty finalTranscript');
            return false;
        }

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

        $btnMic.attr('class', 'off');
    };
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c

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

<<<<<<< HEAD
    // 버튼이 눌렸을 때 번역 시작 함수수
    function start(event) {
        if (isRecognizing) {
        recognition.stop();
        return;
    }
    //recognition.lang = 'en-US';
    recognition.lang = 'ko-KR';
    recognition.start();

    ignoreOnend = false;

    finalTranscript = '';
    final_span.innerHTML = '';
    interim_span.innerHTML = '';
  }

    function requestServer() {
        $.ajax({
        method: 'post',
        url: 'https://www.google.com/speech-api/v2/recognize?output=json&lang=en-us&key=AIzaSyDX-LaY9JyYWxwAIb7BlPGZBKYUBtHzah4',
        data: '/examples/speech-recognition/hello.wav',
        contentType: 'audio/l16; rate=16000;', // 'audio/x-flac; rate=44100;',
        success: function(data) { },
        error: function(xhr) { }
        });
    }

=======
    function start(event) {
        if (isRecognizing) {
            recognition.stop();
            return;
        }
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

        /*
        var u = new SpeechSynthesisUtterance();
        u.text = 'Hello world';
        u.lang = 'en-US';
        u.rate = 1.2;
        u.onend = function(event) {
          log('Finished in ' + event.elapsedTime + ' seconds.');
        };
        speechSynthesis.speak(u);
        */

        // simple version
        speechSynthesis.speak(new SpeechSynthesisUtterance(text));
    }

    /**
     * requestServer
     * key - AIzaSyDiMqfg8frtoZflA_2LPqfGdpjmgTMgWhg
     */
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
>>>>>>> 41a2a87436bffb6e7c57b0dda8929fc0400a0a3c
};
