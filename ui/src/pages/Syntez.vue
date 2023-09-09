<template>
  <main class="container-fluid text-center my-4">
    <h1 class="border-bottom border-5 border-black">Cөз синтезі</h1>
    <div id="main" class="flex flex-wrap p-4">
      <textarea
        style="width: 100%; height: 150px; margin-right: 2dvh"
        class="container-fluid"
        type="text"
        v-model="input_text"
      ></textarea>
      <div class="w-full m-4">
        <Button class="btn btn-primary" @click="sendText">Synthesize</Button>
      </div>
      <div class="container-fluid" style="width: 100%">
        <audio
          controls
          class="container-fluid"
          style="width: 100%"
          ref="audioElement"
        >
          <source id="myAudio" type="audio/wav" />
          Your browser does not support the audio element.
        </audio>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref } from "vue";
import axios from "axios";

const input_text = ref("Менің атым Аскар.");
const audioElement = ref(null);

async function sendText() {
  if (input_text.value !== "") {
    try {
      const response = await axios.post(
        "http://localhost:5001/ttspeech",
        { text: input_text.value },
        {
          responseType: "blob",
        }
      );

      const blob = new Blob([response.data], { type: "audio/wav" });
      const blobUrl = URL.createObjectURL(blob);

      // Set the Blob URL as the source for the audio element
      audioElement.value.src = blobUrl;
    } catch (error) {
      console.error("Error:", error);
    }
  }
}
</script>
