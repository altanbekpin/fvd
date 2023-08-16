<template>
  <div class="card grid flex justify-content-left">
    <div class="col-12">
      <Inplace style="width:100%;">
        <template #display><InlineMessage  :style="{ border: 'solid #696cff', borderWidth: '0 0 0 6px', color: '#696cff' }" severity="info"><span v-if="tokenCount>0">Токен саны: {{tokenCount}}</span> Токенайзерді толықтыру/қайта оқыту </InlineMessage></template>
        <template #content>
          <FileUpload :url="url"   @upload="handleFileUpload" :multiple="false" accept="text/*">
            <template #empty>
                <p>Файлды сүйреп әкеліңіз</p>
            </template>
          </FileUpload>
        </template>
      </Inplace>
    </div>
    <div class="col-12">
      <Button label="Тегтеуді жалғастыру" @click="GetNextSentenceForTagging" />
    </div>
    <div>
      <Panel v-if="tokens.sentence" header="Сөйлем">
        <p class="m-0">
           {{ tokens.sentence }}
        </p>
      </Panel>
      <Panel class="pt-2" v-if="tokens.tokens && tokens.tokens.length>0" header="Токендер">
        <p class="m-0">
           {{ tokens.sentence }}
        </p>
      </Panel>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { AHMET_API } from "../config.js";
import store from "../store.js";
import { AhmetService } from "@/service/AhmetService";
const loading = ref(false);
const url = computed(() => AHMET_API + "/tokenize");
const tokenCount = ref(0);
const tokens = ref({tokens:[], sentence: ""})



const handleFileUpload = (event) => {
  const file = event.files[0];
  const formData = new FormData();
  formData.append("file.txt", file);
  loading.value = true;
  fetch(`${AHMET_API}/tokenize`, {
    method: "POST",
    headers: { Authorization: `Bearer ${store.state.user.access_token}`,'Access-Control-Allow-Credentials':'true',},
    body: formData,
  })
    .then((response) => {
      console.log("response: ", response);
      loading.value = false;
    })
    .catch((error) => {
      console.log('There"s a issue:', error);
      loading.value = false;

    });
};
const GetNextSentenceForTagging  =() =>{
  loading.value = true;
  AhmetService.getNextSentenceForTagging().then((resp) => {
    tokens.value = resp.data
    loading.value = false;
  });
};

onMounted(() => {
  loading.value = true;
  AhmetService.getTokenizerInfo().then((resp) => {
    console.log(resp.data.numtokens)
    tokenCount.value = resp.data.numtokens
    loading.value = false;
  });
});




</script>
<style scoped>
:deep(.p-fileupload) {
    width: 100%;
}
:deep(.p-inplace-display) {
  padding: 0px;
}

</style>
