import { AHMET_API, getHeader } from "@/config";
import api from "./api";
import axios from "axios";
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
    console.log("getHeader(access_token):", getHeader(access_token));
    await axios.post(
      `${AHMET_API}/add/termin`,
      { data: request },
      {
        headers: {
          Authorization: `Bearer ${access_token}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      }
    );
  },
  async saveSubject(subject, access_token) {
    await axios.post(
      `${AHMET_API}/add/subject`,
      { data: subject },
      {
        headers: {
          Authorization: `Bearer ${access_token}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      }
    );
  },
  async register(email, password, full_name) {
    await api.post(AHMET_API + "/register", {
      headers: getHeader(),
      data: { email: email, password: password, full_name: full_name },
    });
  },
  async getTokenAndRoles(email, password) {
    var response;
    var roles = [];
    response = await api.post(`${AHMET_API}/login/`, {
      data: {
        email: email,
        password: password,
      },
    }, {headers: getHeader(),});
    const temp = response.data["access_token"];

    console.log("temp:", temp);
    response = await api.get(`${AHMET_API}/who_am_i/`, {
      headers: { Authorization: `Bearer ${temp}` },
    });
    console.log("response:", response);
    roles = response.data["roles"];
    console.log("who am i returns:");
    return { access_token: temp, roles: roles };
  },
  async confirm(email, code) {
    console.log("email:", email);
    console.log("code:", code);
    const response = await api.post(`${AHMET_API}/confirm`, {
      headers: getHeader(),
      data: { email: email, code: code },
    });
    return response.data["message"];
  },
  async getOffers(access_token) {
    const response = await axios.get(`${AHMET_API}/offers`, {
      headers: {
        Authorization: `Bearer ${access_token}`,
        "Access-Control-Allow-Credentials": "true",
        "Content-Type": "application/json",
        Accept: "*/*",
      },
    });
    return response;
  },
  async activate(offer_id, access_token, activate_type) {
    await axios.post(
      `${AHMET_API}/activate`,
      { offer_id: offer_id, activate_type: activate_type },
      {
        headers: {
          Authorization: `Bearer ${access_token}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      }
    );
  },
};
