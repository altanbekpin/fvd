<template>
  <div class="grid">
    <Toast></Toast>
    <Card>
      <template #title> Ахметтану интеллектуалды жүйесі </template>
      <template #content>
        <img src="/images/Ahmet.jpeg" />
      </template>
    </Card>
    <Card>
      <template #title> Тұлғасы </template>
      <template #content>
        <ul>
          <li>
            <span class="button" id="1">АҒАРТУШЫ</span>,
            <span class="button" id="2">ҰЛТ ҰСТАЗЫ</span>,
            <span class="button" id="3">ҚОҒАМ ҚАЙРАТКЕРІ</span>
          </li>
          <li>
            <span class="button" id="4">ТІЛТАНУШЫ</span>,
            <span class="button" id="5">ТҮРКІТАНУШЫ</span>,
            <span class="button" id="6">ТЕРМИНТАНУШЫ</span>
          </li>
          <li>
            <span class="button" id="7"
              >ҚАЗАҚ ЖАЗУЫ МЕН ЕМЛЕСІНІҢ РЕФОРМАТОРЫ</span
            >
          </li>
          <li>
            <span class="button" id="8">ӘДЕБИЕТТАНУШЫ</span>,
            <span class="button" id="9">ФОЛЬКЛОРТАНУШЫ</span>,
            <span class="button" id="10">ӨНЕРТАНУШЫ</span>
          </li>
          <li>
            <span class="button" id="11">АҚЫН</span>,
            <span class="button" id="12">ЖАЗУШЫ</span>,
            <span class="button" id="13">ПУБЛИЦИСТ</span>,
            <span class="button" id="14">АУДАРМАШЫ</span>
          </li>
          <li>
            <span class="button" id="15">ӘДІСКЕР</span>,
            <span class="button" id="16">ПЕДАГОГ</span>,
            <span class="button" id="17">ПСИХОЛОГ</span>
          </li>
          <li>
            <span class="button" id="18">ЗАҢГЕР</span>,
            <span class="button" id="19">САЯСАТКЕР</span>,
            <span class="button" id="20">ДЕМОГРАФ</span>,
            <span class="button" id="21">ТАРИХШЫ</span>
          </li>
        </ul>
        <div class="card">
          <div class="row" style="justify-content: space-between">
            <!-- <Button  type="button" icon="pi pi-file" @click="searchBook" rounded/> -->
            <div class="row">
              <i class="pi pi-file"></i>
              <div style="margin-left: 15px">
                {{ this.label }}
              </div>
            </div>
            <Button
              type="button"
              icon="pi pi-download"
              @click="searchBook"
              rounded
            />
          </div>
        </div>
      </template>
    </Card>
  </div>
  <!-- #optiongroup="slotProps" -->
</template>

<script>
import vad from "voice-activity-detection";
import axios from "axios";
import { getWaveBlob } from "./webm-to-wav-converter";
import { faWindowRestore } from "@fortawesome/free-solid-svg-icons";
import { AhmetService } from "@/service/AhmetService";
import { AHMET_API } from "../config";
export default {
  name: "AudioSpeechRecognition",
  mounted() {
    //AhmetService.getFile(4)
    console.log("mounted");
    // Select the buttons and add event listeners
    const buttons = document.querySelectorAll(".button");
    buttons.forEach((button) => {
      button.addEventListener("click", () => {
        this.selectedWord = button.innerText;
        console.log(`${this.selectedWord} button clicked`);
        axios
          .post(`${AHMET_API}/search/book/file/`, {
            global: this.selectedWord,
          })
          .then((resp) => {
            console.log(`response ${resp.data[0].label} `);
            this.label = resp.data[0].label;
            this.key = resp.data[0].key;
          });
      });
    });
  },
  data() {
    return {
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
      stopEnable: false,
      filename: this.$t("common.select"),
      audioFile: null,
      OntNames: [],
      selectedOnto: "",
      selectedWord: "",
      response: null,
      label: "Баталар.pdf",
      data: "",
      key: 4,
    };
  },
  methods: {
    searchBook() {
      AhmetService.getFile(this.key);
    },
    getJson() {
      axios
        .get(`${AHMET_API}/getontology/`)
        .then((response) => (this.OntNames = response.data));
    },
    uploadAudioFile() {
      if (this.$refs.audioFile.files.length > 0) {
        this.audioFile = this.$refs.audioFile.files[0];

        this.filename = this.audioFile.name;
        var fileReader = new FileReader();
        var app = this;
        fileReader.onload = function () {
          var arrayBuffer = this.result;
          app.medaiToWav(arrayBuffer);
        };
        fileReader.readAsArrayBuffer(this.audioFile);
        //let audioBtn = this.$refs.audioBtn.$el.querySelector('button');
        //audioBtn.focus()
        console.log(document.getElementById("audioBtn"));

        document.getElementById("audioBtn").focus();
      }
    },
    async requestMic() {
      this.recording = true;
      console.log(this.$salem);
      try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        this.audioContext = new AudioContext();
        faWindowRestore.audioContext = this.audioContext;
        navigator.getUserMedia =
          navigator.getUserMedia ||
          navigator.webkitGetUserMedia ||
          navigator.mozGetUserMedia ||
          navigator.msGetUserMedia;
        this.$media.stream = await navigator.getUserMedia(
          { audio: true, video: false },
          this.startUserMedia,
          this.handleMicConnectError
        );
      } catch (e) {
        this.handleUserMediaError();
      }
    },
    handleUserMediaError() {
      console.warn("Mic input is not supported by the browser.");
    },
    handleMicConnectError() {
      console.warn(
        "Could not connect microphone. Possible rejected by the user or is blocked by the browser."
      );
    },
    startUserMedia(stream) {
      var app = this;
      const mime = [
        "audio/wav",
        "audio/mpeg",
        "audio/webm",
        "audio/ogg",
      ].filter(MediaRecorder.isTypeSupported)[0];
      app.$media.recorder = new MediaRecorder(stream, {
        mimeType: mime,
      });
      app.$media.recorder.ondataavailable = function (e) {
        app.$media.blobs.push(e.data);
      };
      app.$media.recorder.start();
      app.$media.recorder.onstop = function () {
        //var blob = new Blob(app.$media.blobs, { 'type' : 'audio/wav;' });
        getWaveBlob(app.$media.blobs, false, app.audioContext).then((e) => {
          app.sendSpeechToTranslate(e);
        });

        app.$media.blobs = [];
      };
      var options = {
        onVoiceStart: function () {
          if (app.$media.recorder.state !== "recording")
            app.$media.recorder.start();
          //app.stopEnable = false;
          console.log("voice start");
        },
        onVoiceStop: function () {
          app.stopEnable = true;
          console.log("voice stop");
          console.log(app.$media.recorder);
          if (app.$media.recorder.state === "recording") {
            app.$media.recorder.stop();
            app.$media.recorder.start();
          }
        },
        onUpdate: function (val) {
          var as = val;
          val = as;
        },
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
      var data = new FormData();
      data.append("speech", blob);
      axios
        .post("http://localhost:8000/speechtt", data, {
          headers: {
            "Access-Control-Allow-Credentials": "true",
            "Content-Type": "multipart/form-data",
            mode: "no-cors",
          },
        })
        .then((response) => {
          if (response.data.text) {
            this.speechText += response.data.text + " ";
            this.translatedText += response.data.translatedText + " ";
            this.textToSpeech(response.data.translatedText, "ru-RU");
          }
        });
    },
    textToSpeech(text, languageCode) {
      axios
        .post(
          "http://localhost:8000/ttspeech",
          { text: text, langCode: languageCode },
          {
            headers: {
              "Access-Control-Allow-Credentials": "true",
              "Content-Type": "application/json",
              mode: "no-cors",
            },
            responseType: "blob",
          }
        )
        .then((response) => {
          var clipContainer = document.createElement("article");
          var audio = document.createElement("audio");

          clipContainer.classList.add("clip");
          audio.setAttribute("controls", "");
          audio.controls = true;
          audio.src = window.URL.createObjectURL(
            new Blob([response.data], { type: "audio/mpeg" })
          );
          clipContainer.appendChild(audio);
          this.$refs.clips.insertBefore(audio, this.$refs.clips.firstChild);
        });
    },
    medaiToWav(mp3data) {
      var app = this;
      var audioContext = new (window.AudioContext ||
        window.webkitAudioContext)();
      audioContext.decodeAudioData(mp3data, function (buffer) {
        getWaveBlob(mp3data, false, audioContext, buffer).then((e) => {
          app.audioFile = e;
        });
      });
    },
  },
};
</script>
<style scoped>
.row {
  display: flex;
  align-items: center;
}
.row div {
  margin-right: 10px;
}
.custom-file-upload {
  border: 1px solid #ccc;
  display: inline-block;
  padding: 6px 12px;
  cursor: pointer;
  width: inherit;
}
.button {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  border: 1px solid #ccc;
  border-radius: 4px;
  color: #333;
  background-color: #fff;
  text-decoration: none;
}
/* Style the links when hovered */
.button:hover {
  background-color: #f5f5f5;
  border-color: #adadad;
}
</style>
