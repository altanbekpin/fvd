<template>
  <div class="row">
    <div>Сөзді енгізіңіз</div>
    <div style="position: relative">
      <InputText
        type="text"
        v-model="word"
        style="width: 230px"
        @input="onChange($event, '')"
      />
      <div v-if="synonyms.length > 1" ref="listbox">
        <div style="position: absolute; top: 100%; width: 230px; z-index: 2">
          <div class="listbox">
            <Listbox
              v-model="selectedWord"
              :options="all_words"
              optionLabel="words"
              class="w-full md:w-14rem"
              @change="onSelectionChange"
            />
          </div>
        </div>
      </div>
    </div>
    <!-- <Listbox v-model="selectedCity" :options="cities" filter optionLabel="name" class="w-full md:w-14rem" /> -->
    <Button
      label="Іздеу"
      style="margin-left: 20px"
      @click="onSearchTap"
    ></Button>
  </div>
  <div
    v-if="word.valueOf() != '' && meaning.valueOf() != ''"
    style="padding-top: 20px"
  >
    <div>Сөз: {{ words.valueOf() }}</div>
    <div style="margin-bottom: 10px">Түсіндірмесі: {{ meaning }}</div>
    <div class="row">
      <div>Сөз табы:</div>
      <Listbox
        v-model="family"
        :options="families"
        optionLabel="family"
        class="w-full md:w-14rem"
        style="margin-left: 26.5px"
        listStyle="max-height:100px"
        @change="handleSelection"
      />
      <div
        class="centered-card"
        style="width: 10px; height: 10px"
        @click="showDialog"
      >
        <i class="pi pi-plus" style="font-size: 1rem"></i>
      </div>
    </div>
    <div class="row" style="margin-top: 10px">
      <div>синонимдері:</div>
      <Listbox
        v-model="j"
        :options="synonyms"
        optionLabel="synonym"
        class="w-full md:w-14rem"
        listStyle="max-height:100px"
      />
      <div
        class="centered-card"
        style="width: 10px; height: 10px"
        @click="changeSynDialog"
      >
        <i class="pi pi-plus" style="font-size: 1rem"></i>
      </div>
    </div>
    <div class="row" style="margin-top: 10px">
      <div>Перифраза:</div>
      <Listbox
        v-model="j"
        :options="paraphrases"
        optionLabel="paraphrase"
        class="w-full md:w-14rem"
        style="margin-left: 10px"
        listStyle="max-height:100px"
      />
      <div
        class="centered-card"
        style="width: 10px; height: 10px"
        @click="changeParDialog"
      >
        <i class="pi pi-plus" style="font-size: 1rem"></i>
      </div>
    </div>
  </div>
  <div v-if="showSynAdd">
    <Button
      label="Жаңа сөз қосу"
      style="
        position: absolute;
        bottom: 0;
        right: 0;
        margin-right: 10px;
        margin-bottom: 10px;
      "
      @click="showDialog"
    ></Button>
  </div>
  <Dialog
    v-model:visible="showDialogSynonyms"
    modal
    header="Жаңа синоним қосу"
    :style="{ width: '50vw' }"
  >
    <Chips v-model="sonynomToAdd" />
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
        @click="addSynonym"
      ></Button>
    </div>
  </Dialog>
  <Dialog
    v-model:visible="showDialogParaphrases"
    modal
    header="Жаңа перифраза қосу"
    :style="{ width: '50vw' }"
  >
    <Chips v-model="paraphraseToAdd" />
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
        @click="addParaphrase"
      ></Button>
    </div>
  </Dialog>
</template>
<script>
// import { ref } from "vue";
import axios from "axios";
export default {
  data() {
    return {
      word: "",
      showSynAdd: false,
      meaning: "",
      word_id: "",
      all_words: "",
      family: "",
      words: "",
      synonyms: [{ synonym: "Табылмады" }],
      paraphrases: [{ paraphrase: "Табылмады" }],
      families: [
        { family: "етістік" },
        { family: "зат есім" },
        { family: "сын есім" },
        { family: "сан есім" },
      ],
      inputValues: [],
      showDialogSynonyms: false,
      showDialogParaphrases: false,
      sonynomToAdd: [],
      paraphraseToAdd: [],
    };
  },
  methods: {
    async onChange(event, words_family) {
      var response = {};
      try {
        await axios
          .post("http://kazlangres.enu.kz/word/synomize/", {
            value: event.target.value,
            words_family: words_family,
          })
          .then((_) => console.log((response = _.data)));
      } catch (error) {
        response = null;
      }
      console.log(event.target.value);
      console.log("response word in console: ", response);
      if (response != null) {
        this.showSynAdd = false;
        this.meaning = response[0]["meaning"];
        this.word_id = response[0]["id"];
        this.family = { family: response[0]["words_family"] };
        this.words = response[0]["words"];
        this.synonyms = response[1];
        this.paraphrases = response[2];
        this.all_words = response[3];
        console.log("this.family: ", this.family);
        this.families = response[4];
        return true;
      } else {
        console.log("NULL");
        this.meaning = "";
        return false;
      }
    },
    changeSynDialog() {
      this.showDialogSynonyms = !this.showDialogSynonyms;
    },
    changeParDialog() {
      this.showDialogParaphrases = !this.showDialogParaphrases;
    },
    async handleSelection(selectedItem) {
      console.log("Selected item:", selectedItem.value["family"]);
      const event = {
        target: {
          value: this.word,
        },
      };
      return await this.onChange(event, selectedItem.value["family"]);
    },
    async onSearchTap() {
      console.log("onSearchTap");
      const event = {
        target: {
          value: this.word,
        },
      };
      const synWasFound = await this.onChange(event, "");
      if (synWasFound) {
        console.log("showSynAdd.value: ", this.showSynAdd);
        this.showSynAdd = false;
        return;
      }
      this.inputValues = this.word;
      this.showSynAdd = true;
      console.log("this.showSynAdd: ", this.showSynAdd);
    },
    showDialog() {
      this.$emit("custom-event", this.word);
    },
    async addSynonym() {
      await axios.post("http://kazlangres.enu.kz/add/synonym/", {
        synonyms: this.sonynomToAdd,
        word: this.word,
        family: this.family,
      });
    },
    async addParaphrase() {
      await axios.post("http://kazlangres.enu.kz/add/paraphrase/", {
        paraphrases: this.paraphraseToAdd,
        word: this.word,
        family: this.family,
      });
    },
  },
};
</script>
<style>
.centered-card {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #007bff;
  color: white;
  padding: 20px;
  border-radius: 10px;
}
</style>
