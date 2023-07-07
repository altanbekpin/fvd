import { AHMET_API, getHeader } from "@/config";
import api from "./api";
import { useStore } from "vuex";
export const AhmetService = {
  getTreeTableNodes(parentID) {
    let param = parentID ? String(parentID) : "";
    return api.get("/getlegacies/" + param, { baseURL: AHMET_API });
  },
  getFile(fileID) {
    window.location.href = AHMET_API + "/legacy/download/" + fileID;
    console.log(fileID);
  },
  async getSchoolTermins(lazyParams) {
    return await api.post(AHMET_API + "/getTermins", {
      data: lazyParams,
      headers: getHeader(),
    });
  },
  async countSchoolTermins() {
    return await api.get(AHMET_API + "/countTermins", { headers: getHeader() });
  },
  async getSubjects() {
    return await api.get(AHMET_API + "/get/class/subject", {
      headers: getHeader(),
    });
  },
  async saveTermin(request, access_token) {
    console.log("access_token:", access_token);
    await api.post(AHMET_API + "/add/termin", {
      data: request,
      headers: getHeader(access_token),
    });
  },
  async saveSubject(subject) {
    const store = useStore();
    const access_token = store.getters.getAccessToken;
    await api.post(AHMET_API + "/add/subject", {
      data: subject,
      headers: getHeader(access_token),
    });
  },
};
