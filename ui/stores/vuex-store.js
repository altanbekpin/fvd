// import axios from "axios";
// import { createStore } from "vuex";
// // import { auth } from "./auth.module";
// // import apiconfig from "../utils/api.dict";
// import apiconfig from "../src/utils/api.dict";
// import { AHMET_API } from "@/config";

// export const vuexstore = createStore({
//   // namespaced: true,
//   // modules: {
//   //   auth,
//   // },

//   state: {
//     rowData: [],
//     root_folder: "media",
//   },

//   actions: {
//     loadFiles({ commit, state }) {
//       let data = { folder: state.root_folder };
//       axios
//         .post(apiconfig.GET_FOLDERS_FILES, data)
//         .then((res) => {
//           let rowData = res.data;
//           commit("SET_FILES", rowData);
//         })
//         .catch((error) => {
//           console.log(error);
//         });
//     },

//     postFile({ dispatch, commit }, newFile) {
//       const config = {
//         onUploadProgress() {
//           // var percentCompleted = Math.round((e.loaded * 5000) / e.total);
//         },
//       };
//       try {
//         axios
//           .post(AHMET_API + apiconfig.FILE_UPLOAD, newFile, config, {
//             headers: {
//               "Content-Type": "multipart/form-data",
//             },
//           })
//           .then(() => {
//             commit("POST_FILE", newFile);
//           })
//           .then(() => {
//             dispatch("loadFiles");
//           });
//       } catch (error) {
//         console.log(error);
//       }
//     },

//     // tested
//     deleteFile({ dispatch }, filename) {
//       let data = { path: filename };
//       axios
//         .post(AHMET_API + apiconfig.FILE_DELETE, data)
//         .then((res) => {
//           console.log("vuex - deleteFile:", res);
//           dispatch("loadFiles");
//         })
//         .catch((error) => {
//           console.log(error);
//         });
//     },

//     // tested
//     downloadFile({ dispatch }, filename) {
//       console.log(dispatch);
//       axios(AHMET_API, {
//         url: `${filename}`,
//         method: "GET",
//         responseType: "blob",
//       }).then((res) => {
//         const url = window.URL.createObjectURL(new Blob([res.data]));
//         const link = document.createElement("a");
//         link.href = url;
//         link.setAttribute("download", filename);
//         document.body.appendChild(link);
//         link.click();
//       });
//     },

//     setRootFolder({ commit }, folder) {
//       commit("SET_ROOT_FOLDER", folder);
//     },

//     setRootFolderFiles({ commit }, files) {
//       commit("SET_FILES", files);
//     },
//   },

//   mutations: {
//     SET_FILES(state, files) {
//       state.rowData = files;
//     },
//     POST_FILE(state, newFile) {
//       state.rowData.push(newFile);
//     },
//     SET_ROOT_FOLDER(state, folder) {
//       state.root_folder = folder;
//     },
//   },
// });
