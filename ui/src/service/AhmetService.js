import { AHMET_API, getHeader } from "@/config";
import store from "../store";
import api from "./api";
import axios from "axios";

export const AhmetService = {
  getTreeTableNodes(parentID) {
    let param = parentID ? String(parentID) : "";
    return api.get("/getlegacies/" + param, { baseURL: AHMET_API });
  },
  getFile(fileID) {
    window.location.href = AHMET_API + "/legacy/download/" + fileID;
    // console.log(fileID);
  },
  async getSchoolTermins(lazyParams) {
    // console.log("store:", store.getters.getAccessToken);
    return await api.post(
      AHMET_API + "/getTermins",
      {
        data: lazyParams,
      },
      getHeader()
    );
  },
  async loadBooks() {
    return await api.get(`${AHMET_API}/get/school/books`, {
      headers: getHeader(),
    });
  },
  async getLegaciesByID(id) {
    return await api.get(AHMET_API + `/get/legacies/${id}`, {
      headers: getHeader(),
    });
  },
  async countSchoolBooks() {
    return await api.get(AHMET_API + `/get/amount/school/books`, {
      headers: getHeader(),
    });
  },
  async deleteTagLag(data, access_token) {
    await api.post(
      AHMET_API + `/delete/tag/leg`,
      {
        data: data,
      },
      getHeader(access_token)
    );
  },
  async getTokenizerInfo() {
    return await api.get(AHMET_API + "/tokenizer/getinfo", {
      headers: getHeader(),
    });
  },
  async sendComment(data) {
    await api.post(
      AHMET_API + "/sendcomment",
      { data: data },
      {
        headers: getHeader(),
      }
    );
  },
  async getComments(termin_id, access_token) {
    return await api.get(`${AHMET_API}/getcomments/${termin_id}`, {
      headers: getHeader(access_token),
    });
  },
  async deleteComments(data, access_token) {
    await api.post(
      AHMET_API + "/deletecomment",
      { data: data },
      {
        headers: getHeader(access_token),
      }
    );
  },
  async getNextSentenceForTagging() {
    return await api.get(AHMET_API + "/tokenizer/getnexttaggingline", {
      headers: getHeader(),
    });
  },

  async countSchoolTermins() {
    return await api.get(AHMET_API + "/countTermins", { headers: getHeader() });
  },
  async countChildrenTermins() {
    return await api.get(AHMET_API + "/countChildrenTermins", {
      headers: getHeader(),
    });
  },
  async getSubjects() {
    return await api.get(AHMET_API + "/get/class/subject", {
      headers: getHeader(),
    });
  },
  async saveTermin(request, access_token) {
    // console.log("access_token:", access_token);
    // console.log("getHeader(access_token):", getHeader(access_token));
    await api.post(
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
    await api.post(
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
    await api.post(
      AHMET_API + "/register",
      {
        data: { email: email, password: password, full_name: full_name },
      },
      { headers: getHeader() }
    );
  },
  async logout(access_token) {
    await api.delete(`${AHMET_API}/logout`, {
      headers: getHeader(access_token),
    });
  },
  async getTokenAndRoles(email, password) {
    var response;
    var roles = [];
    response = await api.post(
      `${AHMET_API}/login/`,
      {
        data: {
          email: email,
          password: password,
        },
      },
      { headers: getHeader() }
    );
    const temp = response.data["access_token"];
    const refresh_token = response.data["refresh_token"];

    // console.log("temp:", temp);
    response = await api.get(`${AHMET_API}/who_am_i/`, {
      headers: { Authorization: `Bearer ${temp}` },
    });
    // console.log("response:", response);
    roles = response.data["roles"];
    // console.log("who am i returns:");
    return { access_token: temp, roles: roles, refresh_token: refresh_token };
  },
  async confirm(email, code) {
    // console.log("email:", email);
    // console.log("code:", code);
    const response = await api.post(
      `${AHMET_API}/confirm`,
      {
        data: { email: email, code: code },
      },
      { headers: getHeader() }
    );
    return response.data["message"];
  },
  async getOffers(access_token, lazyParams) {
    const response = await api.get(`${AHMET_API}/offers`, {
      params: {
        lazyEvent: JSON.stringify(lazyParams),
      },
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
    await api.post(
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
  async addWord(
    synonymInput,
    inputValues,
    meaningInput,
    selectedFamily,
    paraphraseInput,
    exampleInput,
    store
  ) {
    return await api.post(
      `${AHMET_API}/add/word/`,
      {
        synonyms: synonymInput.value,
        word: inputValues.value,
        meaning: meaningInput.value,
        family: selectedFamily.value,
        paraphrases: paraphraseInput.value,
        example: exampleInput.value,
      },
      {
        headers: {
          Authorization: `Bearer ${store.getters.getAccessToken}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      }
    );
  },
  async research(_value, word) {
    const response = await api.post(
      `${AHMET_API}/research/`,
      {
        value: _value,
        word: word,
      },
      { headers: getHeader() }
    );
    // console.log("RESPONSE:", response);
    return response.data;
  },
  async onChange(event, words_family) {
    var response = {};
    try {
      await api
        .post(`${AHMET_API}/word/synomize/`, {
          value: event.target.value,
          words_family: words_family,
        })
        .then((_) => (response = _.data));
    } catch (error) {
      response = null;
    }
    // console.log(event.target.value);
    // console.log("response word in console: ", response);
    return response;
  },
  async getOffersAmount(access_token) {
    const response = await api.get(`${AHMET_API}/offers/count`, {
      headers: getHeader(access_token),
    });
    // console.log("response:", response);
    return response["data"];
  },
  async getWordsAmount(access_token) {
    const response = await api.get(`${AHMET_API}/offers/count/words`, {
      headers: getHeader(access_token),
    });
    return response.data;
  },
  async getUsersAmount(access_token) {
    const response = await api.get(`${AHMET_API}/offers/count/users`, {
      headers: getHeader(access_token),
    });
    return response.data;
  },
  async getSynPhrasesAmount(access_token) {
    const response = await api.get(`${AHMET_API}/offers/count/synphrase`, {
      headers: getHeader(access_token),
    });
    return response.data;
  },
  async userInfo(access_token, start = "") {
    const response = await api.get(`${AHMET_API}/user/info`, {
      params: {
        start: JSON.stringify(start),
      },
      headers: getHeader(access_token),
    });
    return response.data;
  },
  async wordDates(access_token, dates) {
    const response = await api.get(`${AHMET_API}/word/overview`, {
      params: {
        dates: JSON.stringify(dates),
      },
      headers: getHeader(access_token),
    });
    return response;
  },
  async userResults(access_token) {
    const response = await api.get(`${AHMET_API}/user/table`, {
      headers: getHeader(access_token),
    });
    return response;
  },
  async lastNews(access_token) {
    const response = await api.get(`${AHMET_API}/last/news`, {
      headers: getHeader(access_token),
    });
    return response.data;
  },
  async manage_user(access_token, todo, id) {
    if (todo == "delete") {
      await api.delete(`${AHMET_API}/manage/user`, {
        params: {
          id: JSON.stringify(id),
        },
        headers: getHeader(access_token),
      });
      return;
    }
    await api.put(`${AHMET_API}/manage/user`, null, {
      params: {
        id: JSON.stringify(id),
      },
      headers: getHeader(access_token),
    });
  },
  async delete_syn(access_token, synonym_id) {
    const response = await api.delete(`${AHMET_API}/delete/synonym`, {
      params: {
        synonym_id: JSON.stringify(synonym_id),
      },
      headers: getHeader(access_token),
    });
    return response.status;
  },
  async delete_par(access_token, paraphrase_id) {
    const response = await api.delete(`${AHMET_API}/delete/paraphrase`, {
      params: {
        paraphrase_id: JSON.stringify(paraphrase_id),
      },
      headers: getHeader(access_token),
    });
    return response.status;
  },
  async delete_family(access_token, word_id) {
    const response = await api.delete(`${AHMET_API}/delete/family`, {
      params: {
        word_id: JSON.stringify(word_id),
      },
      headers: getHeader(access_token),
    });
    return response.status;
  },
  async update_user(access_token, email, full_name, id) {
    // console.log("email:", email);
    // console.log("access_token:", access_token);
    await api.post(
      AHMET_API + "/updateuser",
      {
        data: { email, full_name, id },
      },
      getHeader(access_token)
    );
  },
  async textToSpeech(text) {
    return api.post(
      AHMET_API + "/ttspeech",
      { text: text },
      {
        headers: getHeader(),
        responseType: "blob",
      }
    );
  },
  async changeTermin(request, access_token) {
    await api.post(
      `${AHMET_API}/change/termin`,
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
  async ask(question) {
    return await api.post(
      `${AHMET_API}/getontology/ask/test`,
      { question: question },
      {
        headers: {
          // Authorization: `Bearer ${access_token}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      }
    );
  },

  getQuestions(question, id) {
    const cancelToken = axios.CancelToken.source(); // Создаем объект отмены запроса
    return {
      request: api.post(
        `${AHMET_API}/getontology/questions/`,
        {
          question: question,
          id: id,
        },
        {
          headers: {
            "Access-Control-Allow-Credentials": "true",
            "Content-Type": "application/json",
            Accept: "*/*",
          },
          cancelToken: cancelToken.token, // Используем token объекта отмены запроса
        }
      ),
      cancel: cancelToken.cancel, // Функция для отмены запроса
    };
  },
  async changeOrder(value, oldSynonyms) {
    return await api.put(
      `${AHMET_API}/change/order`,
      { value: value, oldSynonyms: oldSynonyms },
      {
        headers: getHeader(),
      }
    );
  },
  async refresh_token() {
    const response = await api.post(
      `${AHMET_API}/refresh`,
      {},
      { headers: getHeader(store.getters.getRefreshToken) }
    );

    store.commit("updateAccessToken", response["access_token"]);
  },
};
