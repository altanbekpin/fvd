<template>
  <div
    class="surface-0 flex align-items-center justify-content-center min-h-screen min-w-screen overflow-hidden"
  >
    <div class="grid justify-content-center p-2 lg:p-0" style="min-width: 80%">
      <Toast />
      <div
        class="col-12 xl:col-6"
        style="
          border-radius: 56px;
          padding: 0.3rem;
          background: linear-gradient(
            180deg,
            var(--primary-color),
            rgba(33, 150, 243, 0) 30%
          );
        "
      >
        <div
          class="h-full w-full m-0 py-7 px-4"
          style="
            border-radius: 53px;
            background: linear-gradient(
              180deg,
              var(--surface-50) 38.9%,
              var(--surface-0)
            );
          "
        >
          <div class="text-center mb-5">
            <div class="text-900 text-3xl font-medium mb-3">
              Қайта оралуыңызбен!
            </div>
            <span class="text-600 font-medium"
              >Жалғастыру үшін аккаунтқа кіріңіз</span
            >
          </div>

          <div class="w-full md:w-10 mx-auto">
            <label for="email1" class="block text-900 text-xl font-medium mb-2"
              >Логин</label
            >
            <InputText
              id="email1"
              v-model="email"
              type="text"
              class="w-full mb-3"
              placeholder="Логин"
              style="padding: 1rem"
            />

            <label
              for="password1"
              class="block text-900 font-medium text-xl mb-2"
              >Пароль</label
            >
            <Password
              id="password1"
              v-model="password"
              placeholder="Пароль"
              :toggleMask="true"
              class="w-full mb-3"
              inputClass="w-full"
              inputStyle="padding:1rem"
            ></Password>

            <div class="flex align-items-center justify-content-between mb-5">
              <div class="flex align-items-center">
                <Checkbox
                  id="rememberme1"
                  v-model="checked"
                  :binary="true"
                  class="mr-2"
                ></Checkbox>
                <label for="rememberme1">Сақтау</label>
              </div>
              <a
                class="font-medium no-underline ml-2 text-right cursor-pointer"
                style="color: var(--primary-color)"
                @click="$router.push('/register')"
                >Біріншірет кіріп тұрсыз ба? Тіркелу</a
              >
            </div>
            <Button
              label="Кіру"
              class="w-full p-3 text-xl"
              @click="postLogin"
            ></Button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import axios from "axios";
//import { store } from './store.js';
import store from "../store.js";
// import { AHMET_API } from "../config";
import { AhmetService } from "@/service/AhmetService";

export default {
  data() {
    return {
      email: "",
      password: "",
      checked: false,
    };
  },
  computed: {
    logoColor() {
      if (this.$appState.darkTheme) return "white";
      return "dark";
    },
  },
  methods: {
    async postLogin() {
      try {
        const repo = await AhmetService.getTokenAndRoles(
          this.email,
          this.password
        );
        this.$toast.add({
          severity: "info",
          summary: "Аккаунтқа кіру",
          detail: "Сәтті жүзеге асырылды",
          life: 3000,
        });
        const data = {
          email: this.email,
          password: this.password,
          roles: repo["roles"],
          access_token: repo["access_token"],
          full_name: "",
        };
        store.commit("updateUser", data);
        this.$router.push("/");
      } catch (e) {
        // console.log("ERROR:", e);
        this.$toast.add({
          severity: "error",
          summary: "Сәтсіз",
          detail: "Қате логин немесе пароль",
          life: 3000,
        });
      }
      // var temp = "";
      // var response;
      // var roles = [];
      // try {
      //   await axios
      //     .post(`${AHMET_API}/login/`, {
      //       email: this.email,
      //       password: this.password,
      //     })
      //     .then((_response) => {
      //       response = _response;
      //     });
      // } catch (error) {
      //   this.$toast.add({
      //     severity: "error",
      //     summary: "Сәтсіз",
      //     detail: "Қате логин немесе пароль",
      //     life: 3000,
      //   });
      //   return;
      // }
      // temp = response.data["access_token"];

      // console.log("temp:", temp);
      // await axios
      //   .get(`${AHMET_API}/who_am_i/`, {
      //     headers: { Authorization: `Bearer ${temp}` },
      //   })
      //   .then((response) => console.log((roles = response.data["roles"])));
      // console.log("who am i returns:");
      // if (response.status == 200) {
      //   this.$toast.add({
      //     severity: "info",
      //     summary: "Аккаунтқа кіру",
      //     detail: "Сәтті жүзеге асырылды",
      //     life: 3000,
      //   });
      //   console.log(store.state.roles);
      //   const data = {
      //     email: this.email,
      //     password: this.password,
      //     roles: roles,
      //     access_token: temp,
      //     full_name: "",
      //   };
      //   store.commit("updateUser", data);
      //   console.log("outside of updateUser:");
      //   console.log(store.state.user);
      //   this.$router.push("/");
      // } else {
      //   this.$toast.add({
      //     severity: "error",
      //     summary: "Ақау",
      //     detail: "Қате логин немесе пароль",
      //     life: 3000,
      //   });
      // }
      //console.log(store.roles)
    },
  },
};
</script>

<style scoped>
.pi-eye {
  transform: scale(1.6);
  margin-right: 1rem;
}

.pi-eye-slash {
  transform: scale(1.6);
  margin-right: 1rem;
}
</style>
