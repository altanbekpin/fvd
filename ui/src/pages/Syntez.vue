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
        <!-- <Button
          class="btn btn-primary"
          icon="pi pi-search"
          @click="sendText"
          :loading="loading"
          >Synthesize</Button
        > -->

        <Button
          class="btn btn-primary"
          type="button"
          label="Синтездеу"
          icon="pi pi-angle-double-right"
          :loading="loading"
          @click="sendText"
        />
      </div>
      <div class="container-fluid" style="width: 100%">
        <audio
          controls
          class="container-fluid"
          style="width: 100%"
          ref="audioElement"
          src="../assets/sample/wav"
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
// import axios from "axios";
const input_text = ref("Менің атым Қазақ.");
const audioElement = ref(null);
const loading = ref(false);
import { AhmetService } from "@/service/AhmetService";

async function sendText() {
  if (input_text.value !== "") {
    
      loading.value = true;
      AhmetService.textToSpeech(input_text.value)
        .then((response) => {
          let blob = new Blob([response.data], { type: "audio/wav" });
          let blobUrl = URL.createObjectURL(blob);
          // Set the Blob URL as the source for the audio element
          audioElement.value.src = blobUrl;
          audioElement.value.play();
          loading.value = false;

          
    })

    
}
}
</script>
