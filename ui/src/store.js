import { createStore } from "vuex";
import createPersistedState from "vuex-persistedstate";
import Cookies from "js-cookie";
import axios from "axios";
import apiconfig from "../src/utils/api.dict";
import { AHMET_API } from "@/config";
const store = createStore({
  state: {
    user: {
      email: "",
      password: "",
      roles: [],
      access_token: "",
      refresh_token: "",
      full_name: "",
    },
    ChosenTheme: {
      theme: "bootstrap4-light-blue",
      dark: false,
    },
    rowData: [],
    root_folder: "media",
  },
  actions: {
    loadFiles({ commit, state }) {
      let data = { folder: state.root_folder };
      axios
        .post(apiconfig.GET_FOLDERS_FILES, data)
        .then((res) => {
          let rowData = res.data;
          commit("SET_FILES", rowData);
        })
        .catch((error) => {
          console.log(error);
        });
    },

    postFile({ dispatch, commit }, newFile) {
      const config = {
        onUploadProgress() {
          // var percentCompleted = Math.round((e.loaded * 5000) / e.total);
        },
      };
      try {
        axios
          .post(AHMET_API + apiconfig.FILE_UPLOAD, newFile, config, {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          })
          .then(() => {
            commit("POST_FILE", newFile);
          })
          .then(() => {
            dispatch("loadFiles");
          });
      } catch (error) {
        console.log(error);
      }
    },

    // tested
    deleteFile({ dispatch }, filename) {
      let data = { path: filename };
      axios
        .post(AHMET_API + apiconfig.FILE_DELETE, data)
        .then((res) => {
          console.log("vuex - deleteFile:", res);
          dispatch("loadFiles");
        })
        .catch((error) => {
          console.log(error);
        });
    },

    // tested
    downloadFile({ dispatch }, filename) {
      console.log(dispatch);
      axios(AHMET_API, {
        url: `${filename}`,
        method: "GET",
        responseType: "blob",
      }).then((res) => {
        const url = window.URL.createObjectURL(new Blob([res.data]));
        const link = document.createElement("a");
        link.href = url;
        link.setAttribute("download", filename);
        document.body.appendChild(link);
        link.click();
      });
    },

    setRootFolder({ commit }, folder) {
      commit("SET_ROOT_FOLDER", folder);
    },

    setRootFolderFiles({ commit }, files) {
      commit("SET_FILES", files);
    },
  },
  mutations: {
    SET_FILES(state, files) {
      state.rowData = files;
    },
    POST_FILE(state, newFile) {
      state.rowData.push(newFile);
    },
    SET_ROOT_FOLDER(state, folder) {
      state.root_folder = folder;
    },
    updateUser(state, data) {
      // console.log("updateUser:");
      // console.log(data);
      state.user = data;
      // console.log("state after updating:");
      // console.log(state.user);
      localStorage.setItem("user", JSON.stringify(data));
    },
    updateAccessToken(state, access_token) {
      state.user.access_token = access_token;
      const user = state.user;
      localStorage.setItem("user", JSON.stringify(user));
    },
    changeTheme(state, Theme) {
      Cookies.set("Theme", Theme, { expires: 7 });
      state.ChosenTheme.theme = Theme.theme;
      state.ChosenTheme.dark = Theme.dark;
      // console.log(state.ChosenTheme);
    },
    unLogUser(state) {
      const data = {
        email: "",
        password: "",
        roles: [],
        access_token: "",
      };
      state.user = data;
    },
    // Define your state mutations here
  },
  getters: {
    getRoles: (state) => {
      if (state.user) {
        return state.user.roles;
      } else {
        return [];
      }
    },
    isUserRegistered: (state) => {
      if (state.user.access_token != "") {
        return true;
      }
      return false;
    },
    isUserAdmin: (state) => {
      if (state.user.roles.includes("admin")) {
        return true;
      }
      return false;
    },
    isUserExpert: (state) => {
      if (state.user.roles.includes("expert")) {
        return true;
      }
      return false;
    },
    getAccessToken: (state) => {
      return state.user.access_token;
    },
    getRefreshToken: (state) => {
      return state.user.refresh_token;
    },
  },
  plugins: [
    createPersistedState({
      storage: window.sessionStorage,
    }),
  ],
  //plugins: [vuexLocal.plugin],
});
export default store;
