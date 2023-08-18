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
              >Жалғастыру үшін email аккаунтыңызға жіберілген кодты
              көріңіз</span
            >
          </div>

          <div class="w-full md:w-10 mx-auto">
            <label for="code" class="block text-900 text-xl font-medium mb-2"
              >Кодты теріңіз</label
            >
            <InputText
              id="code"
              v-model="code"
              type="text"
              class="w-full mb-3"
              placeholder="Код"
              style="padding: 1rem"
            />
            <Button
              label="Кодты растау"
              class="w-full p-3 text-xl"
              @click="confirm"
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
      code: "",
    };
  },
  computed: {
    logoColor() {
      if (this.$appState.darkTheme) return "white";
      return "dark";
    },
  },
  mounted() {
    this.$toast.add({
      severity: "success",
      summary: "Сәтті",
      detail: "email аккаунтыңызға жіберілген кодты тексеріңіз",
      life: 3000,
    });
  },
  methods: {
    async confirm() {
      const email = store.state.user.email;
      console.log("access_token:", email);
      var response = { message: "Қате код" };
      try {
        response = await AhmetService.confirm(email, this.code);
        console.log("Response:", response);
        this.$toast.add({
          severity: "success",
          summary: "Сәтті",
          detail: response,
          life: 3000,
        });
        this.$router.push("/");
      } catch (e) {
        console.log(e);
        this.$toast.add({
          severity: "error",
          summary: "Ақау",
          detail: response["message"],
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
