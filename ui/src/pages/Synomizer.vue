<template>
  <div class="card bounder">
    <div style="font-size: 20px; margin-right: 450px; margin-left: 50px">
      Мәтін синомайзері
    </div>
    <Toast />
    <hr height="20px" />
    <div class="row">
      <div>
        <span style="font-size: 12px; width: 500px">
          Мәтін синонимайзері қазақ тілінде енгізілген мәтіндегі сөздерді
          синонимдермен алмастыруға көмектеседі. Мәтіндегі сөз синонимдермен
          ауыстырылса жасыл түспен белгіленіп көрсетіледі. Синонимайзер арқылы
          өнделген мәтінге семантикасына қарай өзгеріс енгізу мүмкіндігі бар, ол
          үшін белгіленген сөздің үстінен басып, көрсетілген синонимдер ішінен
          мағынасына сай сөзді таңдап, түзете аласыз
        </span>
        <div
          class="card main-card"
          style="width: 100%; height: 500px; margin-top: 20px"
        >
          <WordSynomizer></WordSynomizer>
        </div>
      </div>
      <div style="height: 100%">
        <div
          class="card temp"
          style="width: 500px; height: 560px; position: relative"
        >
          <SynonymSearcher
            @custom-event="showDialog"
            @childEvent="showToast"
            @add-word="showSynToast"
          />
        </div>
      </div>
    </div>
    <div
      class="card temp-mobile"
      style="width: 100%; height: 100%; position: relative; min-height: 560px"
    >
      <SynonymSearcher
        @custom-event="showDialog"
        @childEvent="showToast"
        @add-word="showSynToast"
      />
    </div>
    <Dialog
      v-model:visible="visible"
      modal
      header="Жаңа сөз қосу"
      :style="{ width: '50vw' }"
    >
      <div
        style="display: flex; flex-direction: column; align-items: flex-start"
      >
        <InputText
          type="text"
          v-model="inputValues"
          placeholder="Түбір сөзді жазыңыз"
          :style="{ width: '25vw' }"
          style="margin-bottom: 10px"
        ></InputText>
        <div style="margin-bottom: 10px">
          <Dropdown
            v-model="selectedFamily"
            :options="word_family"
            optionLabel="name"
            placeholder="Сөз табын таңдаңыз"
            class="w-full md:w-14rem"
          />
        </div>
        <InputText
          type="text"
          v-model="meaningInput"
          style="margin-bottom: 10px"
          placeholder="Мағынасын жазыңыз"
          :style="{ width: '25vw' }"
        ></InputText>
        <InputText
          type="text"
          v-model="exampleInput"
          style="margin-bottom: 10px"
          placeholder="Мысалын жазыңыз"
          :style="{ width: '25vw' }"
        ></InputText>
        <span style="color: grey; font-size: 13px">Синонимдер</span>
        <div style="max-width: 600px">
          <Chips v-model="synonymInput" separator="," />
        </div>
        <span style="color: grey; font-size: 13px">Перифразалар</span>
        <div style="max-width: 600px">
          <Chips v-model="paraphraseInput" separator="," />
        </div>
        <div style="margin-top: auto; align-self: flex-end">
          <Button
            label="Қосу"
            style="
              margin-right: 10px;
              position: absolute;
              bottom: 0;
              right: 0;
              margin-bottom: 10px;
            "
            @click="addWord"
          ></Button>
        </div>
      </div>
    </Dialog>
  </div>
</template>
<script setup>
import { ref } from "vue";
// import axios from "axios";
import SynonymSearcher from "./components/SynonymSearcher.vue";
import WordSynomizer from "./components/WordSynomizer.vue";
// import { AHMET_API, getHeader } from "../config";
import { AhmetService } from "@/service/AhmetService";
import { useStore } from "vuex";
import { useToast } from "primevue/usetoast";
const toast = useToast();
const inputValues = ref([]);
// const inputWords = ref("");
const showSynToast = (event) => {
  if (event) {
    toast.add({
      severity: "success",
      summary: "Қабылданды",
      detail: "Сәтті жүзеге асырылды",
      life: 3000,
    });
  } else {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Операция жүзеге асырылмады",
      life: 3000,
    });
  }
};
const showToast = (data) => {
  if (data == "success") {
    toast.add({
      severity: "success",
      summary: "Қабылданды",
      detail: "Сәтті жүзеге асырылды",
      life: 3000,
    });
  } else {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Операция жүзеге асырылмады",
      life: 3000,
    });
  }
};
const visible = ref(false);

const optionSynonyms = ref([{ synonym: "синоним жоқ", words: "" }]);
console.log(optionSynonyms.value);
document.addEventListener("click", function (event) {
  console.log("tapped");
  var listBox = document.querySelector(".listbox"); // Select the ListBox element
  console.log("finished1");

  // Check if the click event occurred outside the ListBox
  if (listBox && !listBox.contains(event.target)) {
    console.log("finished2");
    listBox.style.display = "none"; // Hide the ListBox
  }
  console.log("finished");
});
const selectedFamily = ref();
const word_family = ref([
  { name: "зат есім", code: 1 },
  { name: "сын есім", code: 2 },
  { name: "сан есім", code: 3 },
  { name: "етістік", code: 4 },
  { name: "еліктеуіш", code: 5 },
  { name: "одағай", code: 6 },
  { name: "шылау", code: 7 },
  { name: "үстеу", code: 8 },
]);
const store = useStore();
const synonymInput = ref("");
const paraphraseInput = ref("");
const meaningInput = ref("");
const exampleInput = ref("");
// eslint-disable-next-line no-unused-vars
const showDialog = (data) => {
  inputValues.value = data;
  visible.value = !visible.value;
};

const addWord = () => {
  console.log("synonymInput.value: ", synonymInput.value);
  console.log("inputValues.value: ", inputValues.value);
  console.log("meaningInput.value: ", meaningInput.value);
  console.log("selectedFamily.value: ", selectedFamily.value);
  if (!store.getters.isUserRegistered) {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Сұраныс жібері үшін сайтқа тіркелу міндетті",
      life: 3000,
    });
    return;
  }
  if (inputValues.value != "" && selectedFamily.value != "") {
    try {
      AhmetService.addWord(
        synonymInput,
        inputValues,
        meaningInput,
        selectedFamily,
        paraphraseInput,
        exampleInput,
        store
      );
      toast.add({
        severity: "success",
        summary: "Сәтті",
        detail: "Ұсынысыңыз сәтті жіберілді",
        life: 3000,
      });
    } catch (error) {
      toast.add({
        severity: "error",
        summary: "Ақау",
        detail: "Қате ұсыныс",
        life: 3000,
      });
    }
    synonymInput.value = "";
    inputValues.value = "";
    meaningInput.value = "";
    selectedFamily.value = "";
    paraphraseInput.value = "";
    exampleInput.value = "";
  } else {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Қате ұсыныс",
      life: 3000,
    });
  }
};
</script>
<style setup>
.card-container {
  height: 300px;
}
.row {
  display: flex;
  align-items: center;
}
.row div {
  margin-right: 10px;
}
.texts {
  font-size: 10px;
  margin-top: 10px;
}
.rowMain {
  display: flex;
  align-items: center;
}
.temp-mobile {
  display: none;
}
.dropDown {
  border-radius: 100px;
}
/* Define the breakpoint where the menu will appear below the body */
@media screen and (max-width: 1400px) {
  /* Hide the menu when the screen width is greater than or equal to the breakpoint */
  .temp {
    display: none;
  }
  .bounder {
    height: 100%;
    width: 100%;
  }
  .temp-mobile {
    display: block;
  }
  .highlight {
    color: green;
  }
}
.border {
  border: 1px solid #ccc;
  border-radius: 4px;
}

.border-inner {
  border: none;
  margin: 0;
  padding: 0;
}
.bounder {
  height: 100%;
  width: 100%;
}
</style>
