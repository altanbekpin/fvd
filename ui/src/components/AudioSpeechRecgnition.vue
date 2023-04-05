<template>
   <div class="grid">
    <Card>
		<template #title>
        Ахметтану интеллектуалды жүйесі
        </template>
        <template #content>
        <img src="/images/Ahmet.jpeg"/>
        </template>
    </Card>
    <Card>
		<template #title>
        Тұлғасы
        </template>
        <template #content>
            <ul>
            <li>АҒАРТУШЫ, ҰЛТ ҰСТАЗЫ, ҚОҒАМ ҚАЙРАТКЕРІ</li>
            <li>ТІЛТАНУШЫ, ТҮРКІТАНУШЫ, ТЕРМИНТАНУШЫ</li>
            <li>ҚАЗАҚ ЖАЗУЫ МЕН ЕМЛЕСІНІҢ РЕФОРМАТОРЫ</li>
            <li>ӘДЕБИЕТТАНУШЫ, ФОЛЬКЛОРТАНУШЫ, ӨНЕРТАНУШЫ</li>
            <li>АҚЫН, ЖАЗУШЫ, ПУБЛИЦИСТ, АУДАРМАШЫ</li>
            <li>ӘДІСКЕР, ПЕДАГОГ, ПСИХОЛОГ</li>
            <li>ЗАҢГЕР, САЯСАТКЕР, ДЕМОГРАФ, ТАРИХШЫ</li>
        </ul>
        </template>
    </Card>
    </div>
        
    
</template>


<script>
import vad from "voice-activity-detection";
import axios from 'axios'
import { getWaveBlob } from "./webm-to-wav-converter"
import { faWindowRestore } from "@fortawesome/free-solid-svg-icons";

export default {
  name: 'AudioSpeechRecognition',
  data() {
        return  {
        vad: vad,
        audioContext: null,
        stateText: "s",
        valueText: "v",
        mediaRecorderGlob: null,
        streamGlob: null,
        blobsGlob: [],
        recording: false,
        speechText: "",
        translatedText: "",
        resultTemp: "sasasa",
        context: null,
        stopEnable:false, 
        filename: this.$t('common.select'), 
        audioFile: null,
    }
  },
  mounted() {
    
    
  },
  methods: {
    uploadAudioFile() {
        if (this.$refs.audioFile.files.length >0) {
            this.audioFile = this.$refs.audioFile.files[0];

            this.filename = this.audioFile.name
            var fileReader  = new FileReader;
            var app = this
            fileReader.onload = function(){
                var arrayBuffer = this.result;
                app.medaiToWav(arrayBuffer)
                }
            fileReader.readAsArrayBuffer(this.audioFile);
            //let audioBtn = this.$refs.audioBtn.$el.querySelector('button');
            //audioBtn.focus()
            console.log(document.getElementById('audioBtn'))

            document.getElementById('audioBtn').focus()
        }
    },
    async requestMic() {
        this.recording = true
        console.log(this.$salem)
        try {
            window.AudioContext = window.AudioContext || window.webkitAudioContext
            this.audioContext = new AudioContext()
            faWindowRestore.audioContext = this.audioContext
            navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
            this.$media.stream =  await navigator.getUserMedia({audio: true, video: false}, this.startUserMedia, this.handleMicConnectError);
        }
        catch (e) {
            this.handleUserMediaError();
        }
    },
    handleUserMediaError() {
        console.warn('Mic input is not supported by the browser.')
    },
    handleMicConnectError() {
        console.warn('Could not connect microphone. Possible rejected by the user or is blocked by the browser.');
    },
    startUserMedia(stream) {
        var app = this
        const mime = ['audio/wav', 'audio/mpeg', 'audio/webm', 'audio/ogg']
        .filter(MediaRecorder.isTypeSupported)[0];
        app.$media.recorder = new MediaRecorder(stream, {
        mimeType: mime
        }); 
        app.$media.recorder.ondataavailable = function(e) {
            app.$media.blobs.push(e.data);
        }
        app.$media.recorder.start();
        app.$media.recorder.onstop = function() {

            //var blob = new Blob(app.$media.blobs, { 'type' : 'audio/wav;' });
            getWaveBlob(app.$media.blobs,false, app.audioContext).then((e)=>{
                app.sendSpeechToTranslate(e);
            });
            
            app.$media.blobs = [];
            

           
            }
        var options = {
            onVoiceStart: function() {
                if (app.$media.recorder.state !== 'recording') 
                app.$media.recorder.start();
                //app.stopEnable = false;
                console.log('voice start');
            },
            onVoiceStop: function() {
                app.stopEnable = true
                console.log('voice stop');
                console.log(app.$media.recorder)
                if (app.$media.recorder.state === 'recording') {
                    app.$media.recorder.stop();
                    app.$media.recorder.start();
                }
            },
            onUpdate: function(val) {
                var as = val
                val = as
            }
        };
       

        vad(this.audioContext, stream, options);
    },
    stopRecording() {
        this.$media.recorder.stop();
        this.recording = false;
         if (this.audioContext) {
            this.audioContext.close();
            this.audioContext = null;
        }
    },
    sendSpeechToTranslate(blob) {
        var data = new FormData()
            data.append('speech', blob)
            axios.post('http://localhost:8000/speechtt', data, {
                headers: {
                    'Access-Control-Allow-Credentials':'true',
                    'Content-Type': 'multipart/form-data',
                    'mode': 'no-cors',
                },    
             
            }).then(response => 
             {
                if (response.data.text) {
                    this.speechText +=  response.data.text +  " "
                    this.translatedText += response.data.translatedText +  " "
                    this.textToSpeech(response.data.translatedText, "ru-RU")

                }
            });
    },
    textToSpeech(text, languageCode) {
        axios.post('http://localhost:8000/ttspeech', {text: text, langCode: languageCode}, {
                headers: {
                    'Access-Control-Allow-Credentials':'true',
                    'Content-Type': 'application/json',
                    'mode': 'no-cors',
                },    
                responseType: 'blob',
             
            }).then(response => 
            {
                var clipContainer = document.createElement('article');
                var audio = document.createElement('audio');

                clipContainer.classList.add('clip');
                audio.setAttribute('controls', '');
                audio.controls = true;
                audio.src = window.URL.createObjectURL(new Blob([response.data], {type: "audio/mpeg"}))
                clipContainer.appendChild(audio);
                this.$refs.clips.insertBefore(audio,this.$refs.clips.firstChild)
            
            });
    },
    medaiToWav(mp3data) {
        var app = this
        var audioContext = new (window.AudioContext || window.webkitAudioContext)()
        audioContext.decodeAudioData(mp3data, function (buffer) {
            getWaveBlob(mp3data,false, audioContext, buffer).then((e)=>{
                app.audioFile = e
            });
        })

    },
   



  }
}
</script>
<style scoped>
 .custom-file-upload {
    border: 1px solid #ccc;
    display: inline-block;
    padding: 6px 12px;
    cursor: pointer;
    width: inherit;
}
</style>
