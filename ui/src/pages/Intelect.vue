<template>
  <div class="flex justify-center">
    <div class="card items-start mainbox">
      <div class="card-header">
        <p1>Тезарус</p1>
      </div>
      <Listbox
        v-model="selectedOnto"
        :options="OntNames"
        optionLabel="name"
        class="w-full listbox-scrollable"
      />
    </div>
    <div class="card col">
      <div class="card-header">
        <p1>Іздеу</p1>
      </div>
      <div class="search-container">
        <div style="display: flex; flex-direction: row">
          <div>
            <span class="p-input-icon-left">
              <i class="pi pi-search" />
              <InputText
                v-model="textController"
                placeholder="..."
                class="md:w-20rem input-field"
              />
            </span>
          </div>

          <div class="flex justify-content-center">
            <Button
              label="Іздеу"
              class="md:w-5rem search-button"
              @click="searchFunc"
            />
          </div>
        </div>
        <div v-if="loading">
          <Skeleton class="mb-2"></Skeleton>
          <Skeleton width="10rem" class="mb-2"></Skeleton>
          <Skeleton width="5rem" class="mb-2"></Skeleton>
          <Skeleton height="2rem" class="mb-2"></Skeleton>
          <Skeleton width="10rem" height="4rem"></Skeleton>
        </div>
        <div v-else v-html="this.OntoInner" ref="myElement"></div>
      </div>
    </div>

    <div></div>
  </div>
</template>
<script>
import axios from "axios";
import { AHMET_API, getHeader } from "../config";

export default {
  name: "Intelect",
  data() {
    return {
      OntNames: [],
      selectedOnto: "",
      OntoInner: "",
      textController: "",
      loading: false,
    };
  },
  methods: {
    getJson() {
      console.log("AHMET_API:", `${AHMET_API}/getontology/kz/`);
      axios
        .get(`${AHMET_API}/getontology/kz/`)
        .then((response) => (this.OntNames = response.data));
    },
    async searchFunc() {
      this.loading = true;
      var reqbody = {
        question: this.textController,
      };
      console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });

      this.OntoInner = temp.data;
      this.loading = false;
    },
    // async DoSubmit(text){
    // }
  },
  async mounted() {
    this.getJson(`${AHMET_API}/getontology/ask/`);
    const self = this;
    this.loading = true;
    window.DoSubmit = async function (text) {
      console.log(text);
      self.textController = text;
      var reqbody = {
        question: text,
      };

      console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      console.log(temp.data);
      self.OntoInner = temp.data;
      self.textController = text;
    };
    this.loading = false;
    console.log(this.OntNames.length);
  },
  watch: {
    // OntNames(newValue){
    //     console.log(newValue[0])
    // },
    async selectedOnto() {
      this.loading = true;
      console.log(this.selectedOnto["name"]);
      this.textController = this.selectedOnto["name"];
      var reqbody = {
        question: this.selectedOnto["name"],
      };

      console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      console.log(temp.data);
      this.OntoInner = temp.data;
      this.loading = false;
    },
    OntoInner(newValue) {
      console.log(newValue);
    },
  },
};
</script>
<style scoped>
.mainbox {
  width: 100%;
  max-width: 300px;

  padding-right: 0;
  padding-left: 0;
  padding-top: 0;
}
.input-field {
  height: 50px;
}
.search-button {
  margin-left: 10px;
  height: 50px;
  border-radius: 10px;
}
.col {
  position: relative;
  width: 100%;
  padding-right: 0;
  padding-left: 0;
  display: block;
  max-width: 400px;
  margin-left: 15px;
  padding-top: 0;
}
.listbox-scrollable {
  max-height: 600px; /*set the maximum height of the ListBox*/
  overflow: auto; /* set the overflow property to auto to enable scrolling */
  /* margin-left: 25px; */
  box-sizing: border-box;
  height: 100%;
  border-color: white;
}
.card-header:first-child {
  border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0;
}
.card-header {
  padding: 0.75rem 1.25rem;
  margin-bottom: 15px;
  margin-top: 0;
  background-color: x rgba(0, 0, 0, 0.03);
  border-bottom: 1px solid rgba(0, 0, 0, 0.125);
  box-sizing: border-box;
  border-radius: inherit;
}
.listbox-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
.search-container {
  display: flex;
  flex-direction: column;
  margin-left: 15px;
  margin-right: 15px;
}
.p-input-icon-left {
  margin-bottom: 1rem; /* Add some spacing between the search input and the Listbox */
}
.input-field {
  border-radius: 10px;
}
</style>
