<template>
  <div class="card" v-if="products != null">
    <DataView :value="products.data" paginator :rows="10">
      <template #list="{ data }">
        <div class="col-12">
          <div
            class="flex flex-column xl:flex-row xl:align-items-start p-4 gap-4"
          >
            <div class="row align-items-center">
              <div class="col-sm-8" v-if="data && data.activate_type === 1">
                <div class="mb-2">{{ getOffer(data) }}</div>
                <div class="mb-4">Сөз: {{ data.words }}</div>
                <div class="mb-4">Мағынасы: {{ data.meaning }}</div>
                <div class="mb-4">Сөз табы: {{ data.words_family }}</div>
              </div>
              <div
                class="col-sm-4"
                v-else-if="data && data.activate_type === 2"
              >
                <div class="mb-2">{{ getOffer(data) }}</div>
                <div class="mb-2">email: {{ data.email }}</div>
                <div class="mb-2">есімі: {{ data.full_name }}</div>
              </div>
            </div>
            <div class="ml-auto">
              <div class="container">
                <Tag
                  :value="getStatus(data)"
                  :severity="getSeverity(data.activated)"
                  class="mb-2"
                ></Tag>
                <Button
                  v-if="!data.activated"
                  label="Қабылдау"
                  @click="activate(data.offer_id, data.activate_type)"
                ></Button>
              </div>
            </div>
          </div>
        </div>
      </template>
    </DataView>
  </div>
</template>

<script>
import { AhmetService } from "@/service/AhmetService";
import store from "../store.js";
export default {
  data() {
    return {
      products: null,
    };
  },
  mounted() {
    this.init();
  },
  methods: {
    logItem(item) {
      console.log("Item:", item); // Log the item object
      return "";
    },

    async init() {
      this.products = await AhmetService.getOffers(
        store.getters.getAccessToken
      );
      console.log(this.products.data[0].activate_type);

      console.log(this.products.data);
    },
    getSeverity(activated) {
      if (activated) {
        return "success";
      }
      return "warning";
    },
    getStatus(data) {
      if (data.activated) {
        return "Қабылданды";
      }
      return "Күтілуде";
    },
    getOffer(data) {
      switch (data.activate_type) {
        case 1:
          return "Жаңа сөз қосуға ұсыныс";
        case 2:
          return "Қолданушы болып тіркелуге ұсыныс";
        default:
          return "Қате ұсыныс";
      }
    },
    async activate(id, activate_type) {
      try {
        await AhmetService.activate(
          id,
          store.getters.getAccessToken,
          activate_type
        );
        this.$toast.add({
          severity: "success",
          summary: "Сәтті",
          detail: "Сұраныс сәтті қабылданды",
          life: 3000,
        });
        this.init();
      } catch (e) {
        this.$toast.add({
          severity: "error",
          summary: "Ақау",
          detail: "Сұраныс қабылданбады",
          life: 3000,
        });
      }
    },
  },
};
</script>
<style scoped>
.tag-component {
  font-size: 14px; /* Default font size */
}
.row {
  display: flex;
  align-items: center;
}
.row div {
  margin-right: 10px;
}
.container {
  display: flex;
  flex-direction: column;
}
</style>
