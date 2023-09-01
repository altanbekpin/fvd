<template>
  <div class="flex justify-center">
    <div class="card items-start mainbox">
      <div class="card-header">
        <p1>Тезарус</p1>
      </div>
      <!-- <Listbox
        v-if="OntNames.length != 0"
        v-model="selectedOnto"
        :options="OntNames"
        optionLabel="name"
        class="w-full listbox-scrollable"
      /> -->
      <Tree
        @nodeExpand="selectedOnto"
        v-if="nodes"
        :value="nodes"
        class="w-full"
        selectionMode="single"
        v-model:selectionKeys="selectedNode"
        style="border: none"
      ></Tree>
      <div v-else class="skeleton-container">
        <Skeleton class="mb-2"></Skeleton>
        <Skeleton width="10rem" class="mb-2"></Skeleton>
        <Skeleton width="5rem" class="mb-2"></Skeleton>
        <Skeleton height="2rem" class="mb-2"></Skeleton>
        <Skeleton width="10rem" height="4rem"></Skeleton>
      </div>
    </div>
    <div class="card col" style="min-width: 400px">
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
      nodes: null,
      selectedNode: null,
      OntoInner: "",
      textController: "",
      loading: false,
    };
  },
  methods: {
    countDashes(str) {
      return str.split("-").length - 1;
    },
    findAndReplaceObject(arr, targetKey, replacementObject) {
      console.log("arr:", arr);
      console.log("targetKey:", targetKey);
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].key === targetKey) {
          arr[i] = replacementObject;
          return true; // Object found and replaced
        }

        if (arr[i].children) {
          if (
            this.findAndReplaceObject(
              arr[i].children,
              targetKey,
              replacementObject
            )
          ) {
            return true; // Object found and replaced in children
          }
        }
      }

      return false; // Object not found
    },
    modifyKey(num, key) {
      const components = key.split("-");
      if (components.length <= num + 1) {
        return key; // Return the original key if the requested number of components is equal or more than the original key's components
      }
      return components.slice(0, num + 1).join("-");
    },
    // sortArray(array, object){

    // },
    async getJson() {
      // console.log("AHMET_API:", `${AHMET_API}/getontology/kz/`);
      this.loading = true;
      var reqbody = {
        question: "Тіл құрал",
        pkey: 0,
      };
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      this.OntoInner = temp.data.txt;
      this.nodes = temp.data.childs;
      this.loading = false;
    },
    async searchFunc() {
      this.loading = true;
      var reqbody = {
        question: this.textController,
        pkey: 0,
      };
      console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      this.OntoInner = temp.data.txt;
      this.loading = false;
    },
    async selectedOnto(node) {
      //this.selectedNode =node
      let _node = { ...node };
      _node.children = [];
      this.loading = true;
      // console.log(this.selectedOnto["name"]);
      this.textController = this.selectedOnto["name"];
      var reqbody = {
        question: node.label,
        pkey: node.key,
      };

      // console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      this.OntoInner = temp.data.txt;
      _node.children = temp.data.childs;
      // let _nodes = { ...this.nodes };
      // _nodes[node.key] = _node;
      console.log("_node:", _node);
      console.log("nodes:", this.nodes);
      this.findAndReplaceObject(this.nodes, _node.key, _node);
      this.textController = _node.label
      console.log("nodes after modification:", this.nodes);
      // this.nodes = _nodes;
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
      self.loading = true;
      // console.log(text);
      self.textController = text;
      var reqbody = {
        question: text,
        pkey: 0,
      };

      // console.log(reqbody);
      var temp = await axios.post(`${AHMET_API}/getontology/ask/`, reqbody, {
        headers: getHeader(),
      });
      // console.log(temp.data);
      self.OntoInner = temp.data.txt;
      self.textController = text;
      self.loading = false;
    };
    this.loading = false;
    // console.log(this.OntNames.length);
  },
  watch: {
    // OntNames(newValue){
    //     console.log(newValue[0])
    // },

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
.skeleton-container {
  display: flex;
  flex-direction: column;
  margin-left: 25px; /* Adjust the left margin */
  margin-right: 25px; /* Adjust the right margin */
}

.skeleton-container .mb-2 {
  margin-bottom: 1rem; /* Add margin between each element */
}
</style>
