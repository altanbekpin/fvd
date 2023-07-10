<template>
  <div
    class="surface-0 flex align-items-center justify-content-center min-h-screen min-w-screen overflow-hidden"
  >
    <div class="grid justify-content-center p-2 lg:p-0" style="min-width: 80%">
      <Toast></Toast>
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
            <!-- <img src="layout/images/avatar.png" alt="Image" height="50" class="mb-3"> -->
            <div class="text-900 text-3xl font-medium mb-3">Қош келдіңіз</div>
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
            <label
              for="fullname"
              class="block text-900 text-xl font-medium mb-2"
              >Аты жөні</label
            >
            <InputText
              id="fullname"
              v-model="fullname"
              type="text"
              class="w-full mb-3"
              placeholder="Аты жөні"
              style="padding: 1rem"
            />
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
                @click="$router.push('/auth')"
                >Аккаунтыңыз бар ма? Кіру</a
              >
            </div>
            <Button
              label="Код жіберу"
              class="w-full p-3 text-xl"
              @click="register"
            ></Button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import store from "../store.js";
import { AhmetService } from "@/service/AhmetService";

export default {
  data() {
    return {
      email: "",
      password: "",
      checked: false,
      fullname: "",
    };
  },
  computed: {
    logoColor() {
      if (this.$appState.darkTheme) return "white";
      return "dark";
    },
  },
  methods: {
    async register() {
      try {
        await AhmetService.register(this.email, this.password, this.fullname);
        const data = {
          email: this.email,
          password: this.password,
          roles: [],
          access_token: "",
          full_name: this.fullname,
        };
        store.commit("updateUser", data);
        this.$router.push("/confirmcode");
      } catch (e) {
        console.log(e);
        this.$toast.add({
          severity: "error",
          summary: "Сәтсіз",
          detail: e,
          life: 3000,
        });
      }
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
