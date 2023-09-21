<template>
  <main class="container-fluid my-4">
    <h1 class="border-bottom border-5 border-black text-center">
      Corpus Manager
    </h1>

    <div>
      <div class="rowc data-panel">
        <!-- Folders structure-->
        <div class="col-3 panel1">
          <ul class="folder-panel" style="list-style: none">
            <FolderItem
              class="item"
              :model="folderData"
              @click="onGetFiles"
            ></FolderItem>
          </ul>
        </div>

        <!-- Folder files-->
        <div class="col-9 panel2">
          <FilesGrid @rowClicked="onRowClicked"></FilesGrid>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from "axios";
// import getHeader from "../services/auth.header";
import { AHMET_API, getHeader } from "../config";

import FolderItem from "./components/FolderTree.vue";
import FilesGrid from "./components/FilesGrid.vue";

import { mapState, mapActions } from "vuex";
// import { sizeFormatter } from "../utils/formatters"; // Ag-grid display format for file size and date
import { sizeFormatter } from "../utils/formatters";
import apiconfig from "../utils/api.dict";

export default {
  data() {
    return {
      // root_folder: null,
      folderData: {
        name: "Root Folder",
        children: [
          { name: "folder1" },
          { name: "folder2" },
          {
            name: "folder3",
            children: [
              {
                name: "folder3-1",
                children: [{ name: "folder3-1-1" }, { name: "folder3-1-2" }],
              },
            ],
          },
        ],
      },
    };
  },
  components: {
    FolderItem,
    FilesGrid,
  },
  mounted() {
    // get folder structure
    console.log(
      "AHMET_API+apiconfig.GET_FOLDERS:",
      AHMET_API + apiconfig.GET_FOLDERS
    );
    axios
      .get(AHMET_API + apiconfig.GET_FOLDERS, getHeader())
      .then((response) => {
        this.folderData = response.data;
      })
      .catch((err) => console.log(err));
    this.onGetFiles();
  },
  computed: {
    ...mapState(["rowData", "root_folder"]),
  },
  methods: {
    ...mapActions(["setRootFolderFiles"]),

    onGridReady(params) {
      this.gridApi = params.api;
      this.columnApi = params.columnApi;
      params.api.sizeColumnsToFit();
      params.api.setRowData();
    },

    onRowSelected() {
      const selectedNodes = this.gridApi.getSelectedNodes();
      const selectedData = selectedNodes.map((node) => node.data);
      // const selectedDataStringPresentation = selectedData
      //   .map((node) => node.name + " " + node.file_id)
      //   .join(", ");
      this.selectedDataSizes = selectedData.map((node) => node.size);

      // get the total size
      const add = (a, b) => a + b;
      if (this.selectedDataSizes.length > 0) {
        this.status = true;
        const totalSize = { value: this.selectedDataSizes.reduce(add) };
        this.selectedDataTotal = sizeFormatter(totalSize);
      } else {
        this.status = false;
      }
    },

    submitFile() {
      console.log(this.selFile);
      if (this.selFile.size < 5000 * 1024 * 1024) {
        var vm = this;
        const fd = new FormData();
        fd.append("file", vm.selFile);
        this.$store.dispatch("postFile", fd);
      } else {
        alert("File size must be smaller than 5GB");
      }
    },

    deleteFile() {
      const selectedNodes = this.gridApi.getSelectedNodes();
      if (selectedNodes.length > 0) {
        const selectedData = selectedNodes.map((node) => node.data);
        const result_id = selectedData.map((node) => node.file_id);
        console.log(result_id);
        this.result_id = result_id;
        this.mShow = true;
        this.modal = true;
      }
    },

    handleOk() {
      this.$store.dispatch("deleteFile", this.result_id);
      this.mShow = false;
      this.status = false;
    },

    onRowClicked(filename) {
      console.log("parent: ", filename);
      this.$store.dispatch("downloadFile", filename);
    },

    onGetFiles() {
      // const data = { folder: this.root_folder };
      const data = { folder: "media" };
      // console.log("data:", data);
      axios
        .post(AHMET_API + apiconfig.GET_FOLDERS_FILES, data, getHeader())
        .then((response) => {
          let files = response.data[this.root_folder];
          this.setRootFolderFiles(files);
        })
        .catch((err) => console.log(err));
    },
  },
};
</script>

<style scoped lang="scss">
/* Style buttons */
.btn {
  margin-top: 0;
  border: none; /* Remove borders */
  color: white; /* White text */
  font-size: 16px; /* Set a font size */
  cursor: pointer; /* Mouse pointer on hover */
}
/* Darker background on mouse-over */
.btn:hover {
  background-color: Gray;
}
.rowc {
  --bs-gutter-x: 1.5rem;
  --bs-gutter-y: 0;
  display: flex;
  flex-wrap: wrap;
}
.data-panel {
  border: 2px black solid;
  border-radius: 10px;
}
.panel1 {
  //background-color: gray;
  border-right: 2px black solid;
}
.panel2 {
  //background-color: yellow;
}
</style>
