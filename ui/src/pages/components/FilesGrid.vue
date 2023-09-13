<template>
  <table class="table table-striped table-hover">
    <thead>
      <tr>
        <th scope="col">No.</th>
        <th scope="col">
          <span class="w-50">Filename </span>
          <!-- <span class="ml-auto w-50">
            <a data-bs-toggle="modal" data-bs-target="#uploadModal">
              <font-awesome-icon icon="file-circle-plus" />
            </a>
          </span> -->
          <i
            data-bs-toggle="modal"
            data-bs-target="#uploadModal"
            class="pi pi-file"
          ></i>
        </th>
        <th scope="col">Size</th>
        <th scope="col">Controls</th>
      </tr>
    </thead>
    <tbody>
      <!-- Populate rows with data in the loop -->
      <tr v-for="item in rowData" :key="item.id">
        <th scope="row">{{ item.id }}</th>
        <td>{{ item.name }}</td>
        <td>{{ formatSize(item.size) }}</td>
        <td>
          <!-- Show either View or Play button -->
          <button
            v-if="isTxtFile(item.name)"
            class="btn"
            data-bs-toggle="modal"
            data-bs-target="#exampleModal"
            @click="setPath(item.path, item.name)"
          >
            <!-- <font-awesome-icon icon="eye" /> -->
            <i class="pi pi-eye"></i>
          </button>
          <button v-else class="btn play" @click="playFile(item.path, item.id)">
            <!-- <font-awesome-icon :icon="playOrPause[item.id]" /> -->
            <i :class="playOrPause[item.id]"></i>
          </button>

          <!-- Download selected file -->
          <button class="btn download" @click="downloadFile(item.path)">
            <!-- <font-awesome-icon icon="download" /> -->
            <i class="pi pi-download"></i>
          </button>

          <!-- View and Edit transcription -->
          <button
            type="button"
            class="btn eye"
            data-bs-toggle="modal"
            data-bs-target="#staticBackdrop"
            @click="setPath(item.path, item.name)"
          >
            <!-- <font-awesome-icon icon="file-pen" /> -->
            <i class="pi pi-pencil"></i>
          </button>

          <!-- Delete selected file -->
          <button class="btn delete">
            <!-- <font-awesome-icon icon="trash" @click="deleteFile(item.path)" /> -->
            <i class="pi pi-trash" @click="deleteFile(item.path)"></i>
          </button>
        </td>
      </tr>
    </tbody>
  </table>

  <!-- Modal 1 (File Viewer and Editor) -->
  <div
    class="modal fade"
    id="staticBackdrop"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
    tabindex="-1"
    aria-labelledby="staticBackdropLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="staticBackdropLabel">
            File: {{ uttFile.name }}
          </h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>

        <div class="modal-body">
          <div class="container-fluid">
            <div class="row">
              <div class="col">Recording:</div>
            </div>

            <div class="row">
              <div class="col w-100">
                <audio
                  id="auPlayer"
                  class="w-100"
                  :src="uttFile.wavPath"
                  controls
                ></audio>
              </div>
            </div>

            <div class="row">
              <div class="col">Transcription</div>
            </div>

            <div class="row">
              <div class="col">
                <textarea
                  class="container-fluid"
                  type="text"
                  v-model="uttFile.transcript"
                  :disabled="disableTextarea"
                  rows="3"
                ></textarea>
              </div>
            </div>

            <div v-if="message" class="row">
              <div class="col alert alert-danger">
                {{ message }}
              </div>
            </div>
          </div>
        </div>
        <!-- Modal body -->

        <div class="modal-footer">
          <button
            v-if="isEditing"
            class="btn btn-success"
            @click="saveTranscript()"
          >
            Save
          </button>
          <button v-else class="btn btn-primary" @click="editTranscript()">
            Edit
          </button>
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
            Close
          </button>
        </div>
      </div>
    </div>
  </div>
  <!-- End of Modal 1 -->

  <!-- Modal 2 (Transcript viewer) -->
  <div
    class="modal fade"
    id="exampleModal"
    tabindex="-1"
    aria-labelledby="exampleModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">
            File: {{ uttFile.txtName }}
          </h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col">
              <textarea
                class="container-fluid"
                type="text"
                v-model="uttFile.transcript"
                disabled
                rows="3"
              ></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- End of Modal 2 -->

  <!-- Modal 3 (File uploader)-->
  <div
    class="modal fade"
    id="uploadModal"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
    tabindex="-1"
    aria-labelledby="uploadModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="uploadModalLabel">
            Upload to: {{ root_folder }}
          </h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <input
            type="file"
            @change="getSelectedFile"
            placeholder="Drop a file here..."
          />
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary" @click="uploadFile()">
            Submit &nbsp; &nbsp;
          </button>
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  </div>
  <!-- End of Modal 3 -->
</template>

<script>
// import "bootstrap";
// import "bootstrap/dist/css/bootstrap.min.css";
import axios from "axios";
import { getHeader, AHMET_API } from "../../config";
import { mapState, mapActions } from "vuex";
import apiconfig from "../../utils/api.dict";

import { sizeFormatter } from "../../utils/formatters"; // Ag-grid display format for file size and date

let emptyUttFile = {
  name: "",
  wavPath: "",
  wavName: "",
  txtPath: "",
  txtName: "",
  transcript: "",
};

export default {
  name: "FilesGrid",
  emits: ["rowClicked"],

  // COMPONENT DATA
  data() {
    return {
      audio: new Audio(),
      playOrPause: [],
      // modal data
      disableTextarea: true,
      isEditing: false,
      uttFile: emptyUttFile,
      message: "",
      msgColor: "",
      selectedFile: "",
    };
  },
  computed: {
    ...mapState(["rowData", "root_folder"]),
  },

  // COMPONENT HOOKS
  created() {
    for (let i = 0; i < 400; i++) {
      this.playOrPause.push("pi pi-play");
    }
  },

  mounted() {
    let _this = this;
    this.audio.addEventListener("ended", function () {
      this.currentTime = 0;
      for (let i = 0; i < 400; i++) {
        _this.playOrPause[i] = "pi pi-play";
      }
    });

    var myModalEl = document.getElementById("staticBackdrop");
    myModalEl.addEventListener("hidden.bs.modal", function () {
      // do something...
      let audio = document.getElementById("auPlayer");

      // reset audio
      audio.pause();
      audio.currentTime = 0;

      // reset modal
      _this.uttFile = emptyUttFile;
      _this.disableTextarea = true;
      _this.isEditing = false;
    });
  },

  // COMPONEMT METHODS
  methods: {
    ...mapActions(["setRootFolderFiles"]),

    isTxtFile(filename) {
      if (filename) {
        return filename.split(".").pop() == "txt";
      } else {
        return "";
      }
    },

    formatSize(size) {
      let param = {};
      param["value"] = size;
      return sizeFormatter(param);
    },

    setPath(path, filename) {
      console.log("path:", path);
      console.log("filename:", filename);
      const AHMET_API2 = AHMET_API + "/";
      this.uttFile.name = filename.substring(0, filename.length - 4);
      this.uttFile.wavPath =
        AHMET_API2 + path.substring(0, path.length - 4) + ".wav";
      this.uttFile.wavName =
        filename.substring(0, filename.length - 4) + ".wav";
      this.uttFile.txtPath =
        AHMET_API2 + path.substring(0, path.length - 4) + ".txt";
      this.uttFile.txtName =
        filename.substring(0, filename.length - 4) + ".txt";

      // get transcript from server
      let data = {
        path: path.substring(0, path.length - 4) + ".txt",
      };
      axios
        .post(AHMET_API2 + apiconfig.FILE_GET_TRANSCRIPT, data, getHeader())
        .then((response) => {
          this.uttFile.transcript = response.data["transcript"];
        })
        .catch((err) => console.log(err));
      console.log("this.uttFile.wavPath:", this.uttFile.wavPath);
    },

    downloadFile(filename) {
      this.$emit("rowClicked", filename);
    },

    playFile(filename, id) {
      // reset icons
      if (this.playOrPause[id] === "pi pi-play") {
        for (let i = 0; i < 400; i++) {
          this.playOrPause[i] = "pi pi-play";
        }
        this.playOrPause[id] = "pi pi-pause";
        // const AHMET_API = "http://127.0.0.1:8000";
        // change audio src
        console.log("AHMET_API + filename:", AHMET_API + "/" + filename);
        this.audio.src = AHMET_API + "/" + filename;
        this.audio.play();
      } else {
        // stop audio
        this.playOrPause[id] = "pi pi-play";
        this.audio.pause();
        this.audio.currentTime = 0;
      }
    },

    deleteFile(filename, id) {
      console.log("id:", id);
      let _this = this;

      let data = { path: filename };
      axios
        .post(AHMET_API + apiconfig.FILE_DELETE, data, getHeader())
        .then((res) => {
          console.log("deleteFile:", res);
          //_this.$store.dispatch('loadFiles')

          let data = { folder: _this.root_folder };

          axios
            .post(AHMET_API + apiconfig.GET_FOLDERS_FILES, data, getHeader())
            .then((response) => {
              let files = response.data[_this.root_folder];
              _this.setRootFolderFiles(files);
            })
            .catch((err) => console.log(err));
        })
        .catch((error) => {
          console.log(error);
        });
    },

    getSelectedFile(event) {
      const files = event.target.files;
      this.selectedFile = files[0];
    },

    uploadFile() {
      console.log("uploading a file:", this.selectedFile);

      if (this.selectedFile && this.root_folder) {
        let filename = this.selectedFile.name;
        console.log("filename:", filename);
        if (this.selectedFile.size < 1000 * 1024 * 1024) {
          const fd = new FormData();
          fd.append("file", this.selectedFile);
          fd.append("path", this.selectedFile.name);
          fd.append("folder", this.root_folder);

          console.log("paths:", this.root_folder, this.selectedFile.name);

          const _this = this;

          getHeader();
          const mime_config = {
            headers: {
              "content-type": "multipart/form-data",
            },
          };

          const all_headers = Object.assign(
            {},
            mime_config["headers"],
            getHeader()["headers"]
          );
          const config = {
            headers: all_headers,
          };

          console.log(config);

          axios
            .post(AHMET_API + apiconfig.FILE_UPLOAD, fd, config)
            .then((res) => {
              console.log("uploadedFile:", res);

              let data = { folder: _this.root_folder };

              axios
                .post(
                  AHMET_API + apiconfig.GET_FOLDERS_FILES,
                  data,
                  getHeader()
                )
                .then((response) => {
                  let files = response.data[_this.root_folder];
                  _this.setRootFolderFiles(files);
                })
                .catch((err) => console.log(err));
            })
            .catch((error) => {
              console.log(error);
            });
        } else {
          alert("File size must be smaller than 1GB");
        }
      } else {
        alert("Please specify correct folder and file to upload.");
      }
    },

    editTranscript() {
      this.disableTextarea = false;
      this.isEditing = true;
      console.log("Edit:", this.uttFile);
    },

    saveTranscript() {
      this.disableTextarea = true;
      this.isEditing = false;

      let data = {
        path: this.root_folder,
        filename: this.uttFile.txtName,
        transcript: this.uttFile.transcript,
      };

      let _this = this;

      axios
        .post(AHMET_API + apiconfig.FILE_UPDATE_TRANSCRIPT, data, getHeader())
        .then((res) => {
          console.log("update_transcript:", res.data);

          this.message = res.data["message"];

          let data = { folder: _this.root_folder };

          axios
            .post(AHMET_API + apiconfig.GET_FOLDERS_FILES, data, getHeader())
            .then((response) => {
              let files = response.data[_this.root_folder];
              _this.setRootFolderFiles(files);
            })
            .catch((err) => console.log(err));
        })
        .catch((error) => {
          console.log(error);
        });

      console.log("Save", this.uttFile.name);
    },
  },
};
</script>

<style scoped>
/* @import "bootstrap";
@import "bootstrap/dist/css/bootstrap.css"; */
@import "~bootstrap/dist/css/bootstrap.min.css";
</style>
