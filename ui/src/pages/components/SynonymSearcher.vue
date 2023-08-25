<template>
  <div class="row">
    <div>Сөзді енгізіңіз</div>
    <div style="position: relative; width: 100%">
      <InputText
        type="text"
        v-model="word"
        style="width: 100%"
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
    <Button
      label="Іздеу"
      style="padding-right: 30px; padding-left: 10px"
      @click="onSearchTap"
    ></Button>
  </div>
  <div v-if="word != '' && meaning != ''" style="padding-top: 5px">
    <Tag
      :value="isfromsyn ? 'Синоним сөз' : 'Негізгі сөз'"
      style="margin-bottom: 2%"
    ></Tag>
    <div style="margin-bottom: 5px">Сөз: {{ words }}</div>
    <div style="margin-bottom: 5px">Түсіндірмесі: {{ meaning }}</div>
    <div style="margin-bottom: 10px">Мысалы: {{ example }}</div>
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
      <div class="row">
        <div
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="showDialog"
        >
          <i class="pi pi-plus" style="font-size: 1rem"></i>
        </div>
        <div
          v-if="isUserAdmin || isUserExpert"
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="
            (showDeleteDialog = true),
              (showDeleteWord = true),
              (showDeleteParaphrases = false),
              (showDeleteSynonyms = false)
          "
        >
          <i class="pi pi-trash" style="font-size: 1rem"></i>
        </div>
      </div>
    </div>

    <div class="row" v-if="isUserAdmin || isUserExpert">
      <OrderList
        v-model="synonyms"
        @update:selection="updateSynonyms"
        @reorder="updateOrder"
        listStyle="max-width: 95%; max-height: 5rem"
        dataKey="id"
        style="
          font-size: 12px;
          padding: 4px;
          width: 100%;
          margin-left: 2%;
          max-height: 50%;
        "
      >
        <template #header> Синонимдері </template>
        <template #item="data">
          <div class="flex items-center gap-1">
            <span class="font-semibold">{{ data.item.synonym }}</span>
          </div>
        </template>
      </OrderList>
      <div class="row">
        <div
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="changeSynDialog"
        >
          <i class="pi pi-plus" style="font-size: 1rem"></i>
        </div>
        <div
          v-if="isUserAdmin || isUserExpert"
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="
            (showDeleteDialog = true),
              (showDeleteWord = false),
              (showDeleteParaphrases = false),
              (showDeleteSynonyms = true)
          "
        >
          <i class="pi pi-trash" style="font-size: 1rem"></i>
        </div>
      </div>
    </div>

    <div v-else class="row" style="margin-top: 10px">
      <div>синонимдері:</div>
      <Listbox
        v-model="selectedSyn"
        :options="synonyms"
        optionLabel="synonym"
        class="w-full md:w-14rem"
        listStyle="max-height:100px"
      />
      <div class="row">
        <div
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="changeSynDialog"
        >
          <i class="pi pi-plus" style="font-size: 1rem"></i>
        </div>
        <div
          v-if="isUserAdmin || isUserExpert"
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="
            (showDeleteDialog = true),
              (showDeleteWord = false),
              (showDeleteParaphrases = false),
              (showDeleteSynonyms = true)
          "
        >
          <i class="pi pi-trash" style="font-size: 1rem"></i>
        </div>
      </div>
    </div>
    <div class="row" style="margin-top: 10px">
      <div>Перифраза:</div>
      <Listbox
        v-model="SelectedPar"
        :options="paraphrases"
        optionLabel="paraphrase"
        class="w-full md:w-14rem"
        style="margin-left: 10px"
        listStyle="max-height:100px"
      />
      <div class="row">
        <div
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="changeParDialog"
        >
          <i class="pi pi-plus" style="font-size: 1rem"></i>
        </div>
        <div
          v-if="isUserAdmin || isUserExpert"
          class="centered-card"
          style="width: 10px; height: 10px"
          @click="
            (showDeleteDialog = true),
              (showDeleteWord = false),
              (showDeleteParaphrases = true),
              (showDeleteSynonyms = false)
          "
        >
          <i class="pi pi-trash" style="font-size: 1rem"></i>
        </div>
      </div>
    </div>
  </div>
  <div v-else-if="loading">
    <Skeleton class="mb-2" style="margin-top: 5%"></Skeleton>
    <Skeleton width="10rem" class="mb-2"></Skeleton>
    <Skeleton width="5rem" class="mb-2"></Skeleton>
    <Skeleton height="2rem" class="mb-2"></Skeleton>
    <Skeleton width="10rem" height="4rem"></Skeleton
    ><Skeleton class="mb-2" style="margin-top: 5%"></Skeleton>
    <Skeleton width="10rem" height="4rem"></Skeleton>
    <Skeleton height="2rem" class="mb-2" style="margin-top: 5%"></Skeleton>
    <Skeleton height="2rem" class="mb-2"></Skeleton>
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
  <Dialog
    v-model:visible="showDeleteDialog"
    modal
    header="Өшіру"
    :style="{ width: '50vw' }"
  >
    <p v-if="showDeleteWord">
      "{{ words }}" сөзінің {{ family["family"] }} сөз табын өшіруге сендімдісіз
      бе?
    </p>
    <p v-if="showDeleteParaphrases">
      "{{ words }}" сөзінің {{ SelectedPar["paraphrase"] }} перифразасын өшіруге
      сендімдісіз бе?
    </p>
    <p v-if="showDeleteSynonyms">
      "{{ words }}" сөзінің {{ selectedSyn["synonym"] }} синонимін өшіруге
      сенімдісіз бе?
    </p>
    <template #footer>
      <Button
        label="Жоқ"
        icon="pi pi-times"
        @click="showDeleteDialog = false"
        text
      />
      <Button label="Иә" icon="pi pi-check" @click="onTrashClick" autofocus />
    </template>
  </Dialog>
</template>
<script>
// import { ref } from "vue";
import axios from "axios";
import { AHMET_API } from "../../config";
import { useStore } from "vuex";
import { AhmetService } from "@/service/AhmetService";
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
      showDeleteDialog: false,
      showDeleteSynonyms: false,
      showDeleteParaphrases: false,
      showDeleteWord: false,
      sonynomToAdd: [],
      paraphraseToAdd: [],
      selectedWord: null,
      access_token: null,
      example: "",
      selectedSyn: "",
      SelectedPar: "",
      Word_id: "",
      isUserAdmin: false,
      isUserExpert: false,
      oldSynonyms: null,
      isfromsyn: false,
      loading: false,
    };
  },
  mounted() {
    const store = useStore();
    this.access_token = store.getters.getAccessToken;
    this.isUserAdmin = store.getters.isUserAdmin;
    this.isUserExpert = store.getters.isUserExpert;
  },
  methods: {
    updateSynonyms(newVal) {
      this.selectedSyn = newVal[0];
    },
    async updateOrder(event) {
      console.log("this.synonyms:", this.synonyms);
      console.log("event:", event);
      await AhmetService.changeOrder(event.value, this.oldSynonyms);
      this.synonyms = event.value;
      this.oldSynonyms = event.value;
      this.onSearchTap();
    },
    async onTrashClick() {
      // console.log("this.SelectedPar['id']:", this.SelectedPar["id"]);
      var statusCode = 400;
      if (this.showDeleteSynonyms) {
        console.log("this.selectedSyn:", this.selectedSyn);
        statusCode = await AhmetService.delete_syn(
          this.access_token,
          this.selectedSyn["id"]
        );
      }
      if (this.showDeleteParaphrases) {
        statusCode = await AhmetService.delete_par(
          this.access_token,
          this.SelectedPar["id"]
        );
      }
      if (this.showDeleteWord) {
        statusCode = await AhmetService.delete_family(
          this.access_token,
          this.Word_id
        );
      }
      this.showDeleteDialog = false;
      if (statusCode == 200) {
        this.$emit("childEvent", "success");
      } else {
        this.$emit("childEvent", "error");
      }
      this.onSearchTap();
    },
    async onChange(event, words_family) {
      var response = {};
      // console.log("onChagne:", event);
      try {
        this.loading = true;
        response = await AhmetService.onChange(event, words_family);
        this.loading = false;
        // console.log(
        //   `response[0]["example"] inside onChange:`,
        //   response[0]["example"]
        // );
      } catch (error) {
        response = null;
      }
      // console.log(event.target.value);
      // console.log("response word in console: ", response);
      if (response != null) {
        this.Word_id = response[0]["id"];
        this.showSynAdd = false;
        this.example =
          response[0]["example"] == ""
            ? "Мысалы енгізілмеген"
            : response[0]["example"];
        this.meaning =
          response[0]["meaning"] == ""
            ? "Мағынасы енгізілмеген"
            : response[0]["meaning"];
        this.word_id = response[0]["id"];
        this.family = { family: response[0]["words_family"] };
        this.words = response[0]["words"];
        this.synonyms = response[1];
        this.oldSynonyms = this.synonyms;
        console.log("synonyms:", this.synonyms);
        this.paraphrases = response[2];
        this.all_words = response[3];
        // console.log("this.family: ", this.family);
        // console.log("this.words:", this.word);
        // console.log("this.families:", this.families);
        this.families = response[4];
        this.isfromsyn = response[5];
        console.log("this.isfromsyn:", this.isfromsyn);
        return true;
      } else {
        // console.log("NULL");
        this.meaning = "";
        return false;
      }
    },
    clearArray(array) {
      const uniqueArray = [];
      const synonymSet = new Set();

      for (const obj of array) {
        if (!synonymSet.has(obj.words_family)) {
          synonymSet.add(obj.words_family);
          uniqueArray.push(obj);
        }
      }
      return uniqueArray;
    },
    onSelectionChange() {
      // console.log("selectedWord.value.name: ", this.selectedWord);
      const word = this.selectedWord["words"];
      const event = {
        target: {
          value: word,
        },
      };
      this.onChange(event, "");
    },
    changeSynDialog() {
      this.showDialogSynonyms = !this.showDialogSynonyms;
    },
    changeParDialog() {
      this.showDialogParaphrases = !this.showDialogParaphrases;
    },
    async handleSelection(selectedItem) {
      // console.log("Selected item:", selectedItem.value["family"]);
      const event = {
        target: {
          value: this.word,
        },
      };
      return await this.onChange(event, selectedItem.value["family"]);
    },
    async onSearchTap() {
      // console.log("onSearchTap");
      const event = {
        target: {
          value: this.word,
        },
      };
      const synWasFound = await this.onChange(event, "");
      if (synWasFound) {
        // console.log("showSynAdd.value: ", this.showSynAdd);
        this.showSynAdd = false;
        return;
      }
      this.inputValues = this.word;
      this.showSynAdd = true;
      // console.log("this.showSynAdd: ", this.showSynAdd);
    },
    showDialog() {
      this.$emit("custom-event", this.word);
    },
    async addSynonym() {
      const repsonse = await axios.post(
        `${AHMET_API}/add/synonym/`,
        {
          synonyms: this.sonynomToAdd,
          word: this.word,
          family: this.family,
        },
        {
          headers: {
            Authorization: `Bearer ${this.access_token}`,
            "Access-Control-Allow-Credentials": "true",
            "Content-Type": "application/json",
            Accept: "*/*",
          },
        }
      );
      this.$emit("add-word", repsonse.status == 200);
      this.changeSynDialog();
      // this.onSearchTap();
    },
    async addParaphrase() {
      const response = await axios.post(
        `${AHMET_API}/add/paraphrase/`,
        {
          paraphrases: this.paraphraseToAdd,
          word: this.word,
          family: this.family,
        },
        {
          headers: {
            Authorization: `Bearer ${this.access_token}`,
            "Access-Control-Allow-Credentials": "true",
            "Content-Type": "application/json",
            Accept: "*/*",
          },
        }
      );
      this.$emit("add-word", response.status == 200);
      this.changeParDialog();
    },
  },
};
</script>
<style scoped>
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
