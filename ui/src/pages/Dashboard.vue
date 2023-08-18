<template>
  <div class="grid">
    <Toast></Toast>
    <div class="col-12 lg:col-6 xl:col-3">
      <div class="card mb-0">
        <div class="flex justify-content-between mb-3">
          <div>
            <span class="block text-500 font-medium mb-3">Жалпы ұсыныстар</span>
            <div class="text-900 font-medium text-xl">{{ offercount }}</div>
          </div>
          <div
            class="flex align-items-center justify-content-center bg-blue-100 border-round"
            style="width: 2.5rem; height: 2.5rem"
          >
            <i class="pi pi-shopping-cart text-blue-500 text-xl"></i>
          </div>
        </div>
        <span class="text-green-500 font-medium"
          >{{ todayoffercount }} жаңа
        </span>
        <span class="text-500">бүгінгі сұраныстар</span>
      </div>
    </div>
    <div class="col-12 lg:col-6 xl:col-3">
      <div class="card mb-0">
        <div class="flex justify-content-between mb-3">
          <div>
            <span class="block text-500 font-medium mb-3">Сөздер саны</span>
            <div class="text-900 font-medium text-xl">
              {{ wordscount }}
            </div>
          </div>
          <div
            class="flex align-items-center justify-content-center bg-orange-100 border-round"
            style="width: 2.5rem; height: 2.5rem"
          >
            <i class="pi pi-map-marker text-orange-500 text-xl"></i>
          </div>
        </div>
        <span class="text-green-500 font-medium"
          >{{ wordscountactivated }}
        </span>
        <span class="text-500"> қабылданған сөздер</span>
      </div>
    </div>
    <div class="col-12 lg:col-6 xl:col-3">
      <div class="card mb-0">
        <div class="flex justify-content-between mb-3">
          <div>
            <span class="block text-500 font-medium mb-3"
              >Қолданушылар саны</span
            >
            <div class="text-900 font-medium text-xl">{{ usersAmount }}</div>
          </div>
          <div
            class="flex align-items-center justify-content-center bg-cyan-100 border-round"
            style="width: 2.5rem; height: 2.5rem"
          >
            <i class="pi pi-inbox text-cyan-500 text-xl"></i>
          </div>
        </div>
        <span class="text-green-500 font-medium">{{ adminsAmount }} </span>
        <span class="text-500"> админдер саны</span>
      </div>
    </div>
    <div class="col-12 lg:col-6 xl:col-3">
      <div class="card mb-0">
        <div class="flex justify-content-between mb-3">
          <div>
            <span class="block text-500 font-medium mb-3"
              >Синоним және перифраза қосу</span
            >
            <div class="text-900 font-medium text-xl">
              {{ amountsynphrases }} жалпы
            </div>
          </div>
          <div
            class="flex align-items-center justify-content-center bg-purple-100 border-round"
            style="width: 2.5rem; height: 2.5rem"
          >
            <i class="pi pi-comment text-purple-500 text-xl"></i>
          </div>
        </div>
        <span class="text-green-500 font-medium"
          >{{ activatedsynphrases }}
        </span>
        <span class="text-500"> қабылданғандар</span>
      </div>
    </div>

    <div class="col-12 xl:col-6">
      <div class="card">
        <div class="row-container" style="margin-bottom: 10px">
          <h5>Қолданушылар</h5>
          <InputText type="text" v-model="searchUser" />
        </div>
        <DataTable
          v-if="usersinfo != null"
          :value="usersinfo"
          :rows="5"
          :paginator="true"
          responsiveLayout="scroll"
        >
          <Column style="width: 15%">
            <template #header> Басқару </template>
            <template #body="data">
              <Button label="Басқару" @click="openDialog(data)"></Button>
            </template>
          </Column>
          <Column
            field="full_name"
            header="Аты жөні"
            :sortable="true"
            style="width: 35%"
            ><template #body="data">
              {{ data.data.full_name }}
            </template></Column
          >
          <Column
            field="email"
            header="Email"
            :sortable="true"
            style="width: 35%"
          >
            <template #body="data">
              {{ data.data.email }}
            </template>
          </Column>
          <Column
            field="name"
            header="Рұқсаттары"
            :sortable="true"
            style="width: 35%"
          >
            <template #body="data">
              {{ data.data.name }}
            </template>
          </Column>
        </DataTable>
      </div>
      <div class="card">
        <div class="flex justify-content-between align-items-center mb-5">
          <h5>Қолданушылар статискасы</h5>
          <div>
            <Button
              icon="pi pi-ellipsis-v"
              class="p-button-text p-button-plain p-button-rounded"
              @click="$refs.menu2.toggle($event)"
            ></Button>
            <Menu ref="menu2" :popup="true" :model="items"></Menu>
          </div>
        </div>
        <ul v-if="userstable.length > 0" class="list-none p-0 m-0">
          <li
            class="flex flex-column md:flex-row md:align-items-center md:justify-content-between mb-4"
            v-for="usertable in userstable"
            :key="usertable.id"
          >
            <div>
              <span class="text-900 font-medium mr-2 mb-1 md:mb-0">{{
                usertable["full_name"]
              }}</span>
              <div class="mt-1 text-600">{{ usertable["email"] }}</div>
            </div>
            <div class="mt-2 md:mt-0 flex align-items-center">
              <div
                class="surface-300 border-round overflow-hidden w-10rem lg:w-6rem"
                style="height: 8px"
              >
                <div
                  class="bg-orange-500 h-full"
                  :style="{
                    width: (usertable['count'] * 100) / wordscount,
                  }"
                ></div>
              </div>
              <span
                v-if="this.is_percent"
                class="text-orange-500 ml-3 font-medium"
                >%{{ (usertable["count"] * 100) / wordscount }}</span
              >
              <span v-else class="text-orange-500 ml-3 font-medium">{{
                usertable["count"]
              }}</span>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <div class="col-12 xl:col-6">
      <div v-if="lineData.labels.length > 0" class="card">
        <h5>Сөздерге шолу</h5>
        <Chart type="line" :data="lineData" :options="lineOptions" />
      </div>
      <div class="card">
        <div class="flex align-items-center justify-content-between mb-4">
          <h5>Соңғы хабарландырулар</h5>
        </div>
        <span class="block text-600 font-medium mb-3">Бүгінгі</span>
        <ul v-if="AllLastNews.length > 0" class="p-0 mx-0 mt-0 mb-4 list-none">
          <li
            class="flex align-items-center py-2 border-bottom-1 surface-border"
            v-for="LastNews in AllLastNews"
            :key="LastNews.id"
          >
            <div v-if="LastNews.activate_type === 2">
              <div
                class="w-3rem h-3rem flex align-items-center justify-content-center bg-blue-100 border-circle mr-3 flex-shrink-0"
              >
                <i class="pi pi-download text-xl text-orange-500"></i>
              </div>
              <span class="text-900 line-height-3"
                >{{ LastNews.full_name }}({{ LastNews.email }}), қолданушы
                болуға ұсыныс тастады</span
              >
            </div>
            <div v-if="LastNews.activate_type === 1">
              <div
                class="w-3rem h-3rem flex align-items-center justify-content-center bg-blue-100 border-circle mr-3 flex-shrink-0"
              >
                <i class="pi pi-user-plus text-xl text-orange-500"></i>
              </div>
              <span class="text-900 line-height-3"
                >{{ LastNews.full_name }}({{ LastNews.email }}), жаңа сөз қосуға
                ұсыныс тастады</span
              >
            </div>
            <div v-if="LastNews.activate_type === 3">
              <div
                class="w-3rem h-3rem flex align-items-center justify-content-center bg-blue-100 border-circle mr-3 flex-shrink-0"
              >
                <i class="pi pi-download text-xl text-orange-500"></i>
              </div>
              <span class="text-900 line-height-3"
                >{{ LastNews.full_name }}({{ LastNews.email }}), жаңа синоним
                қосуға ұсыныс тастады</span
              >
            </div>
            <div v-if="LastNews.activate_type === 4">
              <div
                class="w-3rem h-3rem flex align-items-center justify-content-center bg-blue-100 border-circle mr-3 flex-shrink-0"
              >
                <i class="pi pi-download text-xl text-orange-500"></i>
              </div>
              <span class="text-900 line-height-3"
                >{{ LastNews.full_name }}({{ LastNews.email }}), жаңа перифраза
                қосуға ұсыныс тастады</span
              >
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <Dialog
    v-model:visible="is_dialog_opened"
    modal
    header="Қолданушыны басқару"
    :style="{ width: '50vw' }"
  >
    <p>Aты-жөні: {{ manage_user.full_name }}</p>
    <p>email: {{ manage_user.email }}</p>
    <template #footer>
      <Button
        label="Қолданушыны өзгерту"
        icon="pi pi-user-edit"
        @click="
          (showUpdateUser = true),
            (new_user_email = manage_user.email),
            (new_user_name = manage_user.full_name)
        "
        text
      />
      <Button
        label="Қолданушыны базадан өшіру"
        icon="pi pi-trash"
        @click="manage('delete')"
        text
      />
      <Button
        label="Қолданушыны көтеру"
        icon="pi pi-check"
        @click="manage('up')"
        autofocus
      />
    </template>
  </Dialog>
  <Dialog
    v-model:visible="showUpdateUser"
    modal
    header="Қолданушыны басқару"
    :style="{ width: '50vw' }"
  >
    <InputText type="text" v-model="new_user_email" />
    <InputText type="text" v-model="new_user_name" />
    <template #footer>
      <Button
        label="Қолданушыны өзгерту"
        icon="pi pi-user-edit"
        @click="manage('update')"
        text
      />
    </template>
  </Dialog>
</template>

<script>
import EventBus from "@/AppEventBus";
import ProductService from "../service/ProductService";
import { AhmetService } from "@/service/AhmetService.js";
import store from "../store";
export default {
  data() {
    return {
      products: null,
      usersinfo: null,
      offercount: 0,
      todayoffercount: 0,
      wordscount: 0,
      wordscountactivated: 0,
      usersAmount: 0,
      adminsAmount: 0,
      amountsynphrases: 0,
      activatedsynphrases: 0,
      dates: [],
      manage_user: null,
      wordDates: [],
      searchUser: "",
      userstable: [],
      AllLastNews: [],
      is_dialog_opened: false,
      showUpdateUser: false,
      is_percent: true,
      new_user_email: "",
      new_user_name: "",
      lineData: {
        labels: [],
        datasets: [
          {
            label: "Жалпы сөздер",
            data: [],
            fill: false,
            backgroundColor: "#2f4860",
            borderColor: "#2f4860",
            tension: 0.4,
          },
          {
            label: "Қабылданған сөздер",
            data: [],
            fill: false,
            backgroundColor: "#00bb7e",
            borderColor: "#00bb7e",
            tension: 0.4,
          },
        ],
      },
      items: [
        {
          label: "Пайызбен көрсету",
          icon: "pi pi-fw pi-percentage",
          command: () => {
            this.onItemSelected(true);
          },
        },
        {
          label: "Санмен көрсету",
          icon: "pi pi-fw pi-calculator",
          command: () => {
            this.onItemSelected(false);
          },
        },
      ],
      lineOptions: null,
    };
  },
  productService: null,
  themeChangeListener: null,
  mounted() {
    this.init();
    this.productService
      .getProductsSmall()
      .then((data) => (this.products = data));

    this.themeChangeListener = (event) => {
      if (event.dark) this.applyDarkTheme();
      else this.applyLightTheme();
    };
    EventBus.on("change-theme", this.themeChangeListener);

    if (this.isDarkTheme()) {
      this.applyDarkTheme();
    } else {
      this.applyLightTheme();
    }
  },
  beforeUnmount() {
    EventBus.off("change-theme", this.themeChangeListener);
  },
  created() {
    this.productService = new ProductService();
  },
  watch: {
    searchUser(newVal) {
      this.lookforuser(newVal);
    },
  },
  methods: {
    onItemSelected(boolean) {
      console.log("BOOLEAN:", boolean);
      this.is_percent = boolean;
    },
    openDialog(user) {
      this.manage_user = user.data;
      this.is_dialog_opened = true;
    },
    formatCurrency(value) {
      return value.toLocaleString("en-US", {
        style: "currency",
        currency: "USD",
      });
    },
    isDarkTheme() {
      return this.$appState.darkTheme === true;
    },
    async init() {
      const labels = [];
      for (let i = 6; i >= 0; i--) {
        const date = new Date();
        date.setDate(date.getDate() - i);
        const isoDate = date.toISOString().split("T")[0]; // Convert the date to ISO 8601 format
        this.dates.push(isoDate);
        labels.push(
          `${isoDate.split("-")[2]}.${isoDate.split("-")[1]}.${
            isoDate.split("-")[0]
          }`
        );
      }
      this.lineData.labels = labels;
      console.log("this.lineData.labels:", this.lineData.labels);
      const accesstoken = store.getters.getAccessToken;
      var response = await AhmetService.getOffersAmount(accesstoken);
      this.offercount = response["count"]["count"];
      this.todayoffercount = response["today_offers"]["count"];
      response = await AhmetService.getWordsAmount(accesstoken);
      console.log("response", response);
      this.wordscount = response["words_count"]["count"];
      this.wordscountactivated = response["words_count_activated"]["count"];
      response = await AhmetService.getUsersAmount(accesstoken);
      this.usersAmount = response["users"];
      this.adminsAmount = response["admins"];
      response = await AhmetService.getSynPhrasesAmount(accesstoken);
      this.amountsynphrases = response["amount"];
      this.activatedsynphrases = response["total_row_count"];
      await this.getTableInfo(accesstoken);
      this.wordDates = (
        await AhmetService.wordDates(accesstoken, this.dates)
      ).data;
      this.wordDates = this.wordDates.map((obj) => obj.count);
      console.log("this.wordDates:", this.wordDates);
      console.log(this.wordDates[0]);
      this.lineData.datasets[0].data = this.wordDates;
      this.lineData.datasets[1].data = this.wordDates;
      console.log("this.lineData.datasets", this.lineData.datasets[0].data);
      response = (await AhmetService.userResults(accesstoken)).data;
      this.userstable = response;
      console.log("userResults:", response);
      console.log("this.userstable[0]:", this.userstable[0]);
      console.log(
        "this.userstable[0]['full_name']:",
        this.userstable[0]["full_name"]
      );
      response = await AhmetService.lastNews(accesstoken);
      this.AllLastNews = response;
    },
    async lookforuser(newVal) {
      console.log("newVal:", newVal);
      const accesstoken = store.getters.getAccessToken;
      const response = await AhmetService.userInfo(accesstoken, newVal);
      this.usersinfo = response;
      console.log("lookforuser:", response);
    },
    async getTableInfo(accesstoken) {
      this.usersinfo = await AhmetService.userInfo(accesstoken);
    },
    async manage(todo) {
      if (!store.getters.isUserAdmin) {
        this.$toast.add({
          severity: "info",
          summary: "Сәтсіз",
          detail: "Сізде құқық жеткіліксіз",
          life: 3000,
        });
        return;
      }
      console.log("TODO:", todo);
      const accesstoken = store.getters.getAccessToken;
      var message =
        todo == "delete"
          ? "Сәтті базадан өшірілді"
          : "Қолданушының рұқсаты көтерілді";
      var label = todo == "delete" ? "Өшірілді" : "Көтерілді";
      var errormessage =
        todo == "delete"
          ? "Қолданушы базадан өшірілмеді"
          : "Қолданушы рұқсаты көтерілмеді";
      try {
        if (todo == "update") {
          todo = "Қолданушы сәтті өзгертілді";
          errormessage = "Қолданушы параметрлері өзгертілмеді";
          label = "Өзгертілді";
          console.log("CHANGE USER");
          await AhmetService.update_user(
            accesstoken,
            this.manage_user.email,
            this.manage_user.full_name,
            this.manage_user.id
          );
        } else {
          await AhmetService.manage_user(
            accesstoken,
            todo,
            this.manage_user.id
          );
        }
        this.$toast.add({
          severity: "success",
          summary: label,
          detail: message,
          life: 3000,
        });
      } catch (e) {
        this.$toast.add({
          severity: "error",
          summary: "Ақау",
          detail: errormessage,
          life: 3000,
        });
      } finally {
        this.getTableInfo(accesstoken);
        this.is_dialog_opened = false;
        this.showUpdateUser = false;
        this.manage_user = null;
      }
    },
    applyLightTheme() {
      this.lineOptions = {
        plugins: {
          legend: {
            labels: {
              color: "#495057",
            },
          },
        },
        scales: {
          x: {
            ticks: {
              color: "#495057",
            },
            grid: {
              color: "#ebedef",
            },
          },
          y: {
            ticks: {
              color: "#495057",
            },
            grid: {
              color: "#ebedef",
            },
          },
        },
      };
    },
    applyDarkTheme() {
      this.lineOptions = {
        plugins: {
          legend: {
            labels: {
              color: "#ebedef",
            },
          },
        },
        scales: {
          x: {
            ticks: {
              color: "#ebedef",
            },
            grid: {
              color: "rgba(160, 167, 181, .3)",
            },
          },
          y: {
            ticks: {
              color: "#ebedef",
            },
            grid: {
              color: "rgba(160, 167, 181, .3)",
            },
          },
        },
      };
    },
  },
};
</script>
<style scoped>
.row-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
