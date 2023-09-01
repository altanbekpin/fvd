<template lang="">
  <div class="card" style="min-width: 500px">
    <div style="font-size: 20px; margin-right: 450px; margin-left: 50px">
      Мектеп пәндерінің терминдер жинағы
    </div>
    <Toast />
    <hr height="20px" />
    <DataTable
      v-model:filters="filters"
      v-model:selection="selectedProduct"
      :value="customers"
      lazy
      paginator
      :rows="10"
      ref="dt"
      dataKey="id"
      filterDisplay="row"
      :totalRecords="totalRecords"
      :loading="loading"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
      :globalFilterFields="['termin', 'definition', 'subject', 'class']"
    >
      <template #header>
        <div class="flex justify-content-end">
          <Button
            class="headerbutton"
            v-if="isUserAdmin"
            type="button"
            icon="pi pi-plus"
            label="Жаңа термин қосу"
            outlined
            @click="showDialog()"
          />
          <Button
            class="headerbutton"
            v-if="isUserAdmin || isUserExpert"
            type="button"
            icon="pi pi-pencil"
            label="Термин өзгерту"
            outlined
            @click="showChangeDialog()"
          ></Button>
          <span class="p-input-icon-left input-span">
            <i class="pi pi-search" />
            <InputText v-model="filters['global'].value" placeholder="Іздеу" />
          </span>
        </div>
      </template>
      <template #empty> No customers found. </template>
      <template #loading> Loading customers data. Please wait. </template>
      <Column
        v-if="isUserAdmin || isUserExpert"
        selectionMode="multiple"
        headerStyle="width: 3rem"
      ></Column>
      <Column field="termin" header="Термин" style="min-width: 12rem">
        <template #body="{ data }">
          {{ data.termin }}
        </template>
      </Column>
      <Column
        header="Түсіндірмесі"
        filterField="definition"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <span>{{ data.definition }}</span>
        </template>
      </Column>
      <Column
        header="Пән"
        filterField="subject"
        :showFilterMenu="false"
        :filterMenuStyle="{ width: '14rem' }"
        style="min-width: 14rem"
      >
        <template #body="{ data }">
          <span>{{ data.subject }}</span>
        </template>
        <template #filter="{ filterModel, filterCallback }">
          <Dropdown
            @change="filterCallback()"
            v-model="filterModel.value"
            :options="subjects"
            optionLabel="subject"
            placeholder="Пән тандаңыз"
          >
          </Dropdown>
        </template>
      </Column>
      <Column
        field="class"
        header="Сынып"
        :showFilterMenu="false"
        :filterMenuStyle="{ width: '14rem' }"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <span>{{ data.class }}</span>
        </template>
        <template #filter="{ filterModel, filterCallback }">
          <Dropdown
            @change="filterCallback()"
            v-model="filterModel.value"
            :options="classes"
            placeholder="Сынып таңдаңыз"
          >
          </Dropdown>
        </template>
      </Column>
    </DataTable>
  </div>
  <Dialog
    v-model:visible="showAddTerminDialog"
    :style="{ width: '450px' }"
    header="Жаңадан термин қосу"
    :modal="true"
    class="p-fluid"
  >
    <div class="field">
      <label for="name">Термин</label>
      <InputText v-model="request.termin" autofocus />
    </div>
    <div class="field">
      <label for="description">Түсіндірмесі</label>
      <Textarea
        id="description"
        required="true"
        rows="3"
        cols="20"
        v-model="request.definition"
      />
    </div>
    <div class="field">
      <Dropdown
        v-model="request.subject"
        :options="subjects"
        optionLabel="subject"
        placeholder="Пән тандаңыз"
      />
    </div>
    <div class="field">
      <Dropdown
        v-model="request.school_class"
        :options="classes"
        placeholder="Сынып тандаңыз"
      />
    </div>

    <template #footer>
      <div style="display: flex">
        <Button
          label="Жаңа пән қосу"
          icon="pi pi-plus"
          text
          @click="activateSubjectDialog"
        ></Button>
        <div>
          <Button
            label="Бас тарту"
            icon="pi pi-times"
            text
            @click="hideDialog"
          />
          <Button
            label="Сақтау"
            icon="pi pi-check"
            text
            @click="saveTermin()"
          />
        </div>
      </div>
    </template>
  </Dialog>
  <Dialog
    v-model:visible="showAddSubjectDialog"
    :style="{ width: '450px' }"
    header="Жаңа пән қосу"
    :modal="true"
    class="p-fluid"
  >
    <div class="field">
      <label for="name">Пән</label>
      <InputText v-model="subjectToAdd" autofocus />
    </div>
    <template #footer>
      <Button label="Сақтау" icon="pi pi-check" text @click="saveSubject()" />
    </template>
  </Dialog>
  <Dialog
    v-model:visible="showChangeSubjectDialog"
    :style="{ width: '450px' }"
    header="Термин өзгерту"
    :modal="true"
    class="p-fluid"
  >
    <div class="field">
      <label for="name">Термин</label>
      <InputText v-model="requestToChange.termin" autofocus />
    </div>
    <div class="field">
      <label for="description">Түсіндірмесі</label>
      <Textarea
        id="description"
        required="true"
        rows="3"
        cols="20"
        v-model="requestToChange.definition"
      />
    </div>
    <div class="field">
      <Dropdown
        v-model="requestToChange.subject"
        :options="subjects"
        optionLabel="subject"
        placeholder="Пән тандаңыз"
      />
    </div>
    <div class="field">
      <Dropdown
        v-model="requestToChange.school_class"
        :options="classes"
        placeholder="Сынып тандаңыз"
      />
    </div>

    <template #footer>
      <div style="display: flex">
        <Button
          label="Жаңа пән қосу"
          icon="pi pi-plus"
          text
          @click="activateSubjectDialog"
        ></Button>
        <div>
          <Button
            label="Бас тарту"
            icon="pi pi-times"
            text
            @click="hideDialog"
          />
          <Button
            label="Өзгерту"
            icon="pi pi-check"
            text
            @click="changeTermin()"
          />
        </div>
      </div>
    </template>
  </Dialog>
</template>
<script>
import { AhmetService } from "@/service/AhmetService";
import { useStore } from "vuex";

export default {
  data() {
    return {
      selectedProduct: null,
      showChangeSubjectDialog: false,
      requestToChange: {
        definition: null,
        termin: null,
        subject: null,
        school_class: null,
        id: null,
      },
      lazyParams: {},
      customers: null,
      filters: {
        global: { value: "" },
        termin: { value: "" },
        definition: { value: "" },
        subject: { value: "" },
        class: { value: "" },
      },
      classes: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"],
      loading: true,
      isUserAdmin: false,
      showAddTerminDialog: false,
      showAddSubjectDialog: false,
      subjectToAdd: null,
      request: {
        definition: null,
        termin: null,
        subject: null,
        school_class: null,
      },
      subjects: [],
      store: null,
    };
  },
  async mounted() {
    this.store = useStore();
    this.isUserAdmin = this.store.getters.isUserAdmin;
    this.lazyParams = {
      first: 0,
      rows: this.$refs.dt.rows,
      word: "",
      sortOrder: null,
      filters: this.filters,
    };
    this.subjects = (await AhmetService.getSubjects())["data"];
    // console.log("subjects:", this.subjects);
    this.loadLazyData();
  },
  watch: {
    "filters.global.value": function (newValue) {
      // Call your function here
      this.lazyParams.word = newValue;
      this.loadLazyData();
    },
  },
  methods: {
    async changeTermin() {
      const access_token = this.store.getters.getAccessToken;
      this.requestToChange.id = this.selectedProduct[0].id;
      try {
        await AhmetService.changeTermin(this.requestToChange, access_token);
        this.$toast.add({
          severity: "success",
          summary: "Қабылданды",
          detail: "Термин сәтті өзгертілді",
          life: 3000,
        });
      } catch (e) {
        this.$toast.add({
          severity: "error",
          summary: "Сәтсіз",
          detail: "Қайта тырысып көріңіз",
          life: 3000,
        });
      } finally {
        this.hideChangeDialog();
        this.requestToChange = {
          definition: null,
          termin: null,
          subject: null,
          school_class: null,
        };
        this.selectedProduct = null;
        this.loadLazyData();
      }
    },
    hideChangeDialog() {
      this.showChangeSubjectDialog = false;
    },
    showChangeDialog() {
      if (
        !this.selectedProduct ||
        (this.selectedProduct && this.selectedProduct.length > 1)
      ) {
        this.$toast.add({
          severity: "info",
          summary: "Info",
          detail: "Өзгертуге 1 термин таңдаңыз",
          life: 3000,
        });
        return;
      }
      this.requestToChange.id = this.selectedProduct[0].id;
      this.requestToChange.definition = this.selectedProduct[0].definition;
      this.requestToChange.school_class = this.selectedProduct[0].class;
      this.requestToChange.subject = this.selectedProduct[0].subject;
      this.requestToChange.termin = this.selectedProduct[0].termin;
      this.showChangeSubjectDialog = true;
    },
    async loadLazyData() {
      this.loading = true;
      const count = await AhmetService.countSchoolTermins();
      // console.log("count:", count);
      this.totalRecords = count["data"]["count"];
      // console.log("this.totalRecords:", this.totalRecords);
      const object = await AhmetService.getSchoolTermins({
        data: this.lazyParams,
      });
      this.customers = object.data;
      // console.log("this.customers:", this.customers);
      this.loading = false;
    },
    onPage(event) {
      this.lazyParams = event;
      this.loadLazyData();
    },
    onSort(event) {
      this.lazyParams = event;
      this.loadLazyData();
    },
    onFilter() {
      this.lazyParams.filters = this.filters;
      // console.log("EVENT:", event);
      this.loadLazyData();
    },
    async showDialog() {
      this.showAddTerminDialog = true;
      this.subjects = (await AhmetService.getSubjects())["data"];
      // console.log("this.subjects:", this.subjects);
    },
    hideDialog() {
      this.showAddTerminDialog = false;
    },
    async saveTermin() {
      // console.log("store:", this.store);
      // console.log("store.state:", this.store.state);
      const access_token = this.store.getters.getAccessToken;
      // console.log("###############");
      try {
        // console.log("saveTermin:", access_token);
        await AhmetService.saveTermin(this.request, access_token);
        this.$toast.add({
          severity: "success",
          summary: "Қабылданды",
          detail: "Жаңа термин сәтті қосылды",
          life: 3000,
        });
      } catch (error) {
        console.error("error:", error);
        this.$toast.add({
          severity: "error",
          summary: "Ақау",
          detail: "Жаңа термин қосуға рұқсатыңыз жоқ немесе қате сұраныс",
          life: 3000,
        });
      } finally {
        this.hideDialog();
        this.request = {
          definition: null,
          termin: null,
          subject: null,
          school_class: null,
        };
      }
    },

    activateSubjectDialog() {
      this.showAddSubjectDialog = true;
      this.hideDialog();
    },
    async saveSubject() {
      try {
        const access_token = this.store.getters.getAccessToken;
        await AhmetService.saveSubject(this.subjectToAdd, access_token);
        this.$toast.add({
          severity: "success",
          summary: "Қабылданды",
          detail: "Жаңа пән сәтті қосылды",
          life: 3000,
        });
      } catch (error) {
        // console.log("ERROR:", error);
        this.$toast.add({
          severity: "error",
          summary: "Ақау",
          detail: "Жаңа пән қосуға рұқсатыңыз жоқ немесе қате сұраныс",
          life: 3000,
        });
      }
    },
  },
};
</script>

<style scoped>
.input-span {
  margin-left: auto;
}
.headerbutton {
  margin-right: 5%;
}
@media (max-width: 768px) {
  .headerbutton {
    /* height: 20px;
  width: 100px; */
    /* font: 10px; */
    font-size: 9px;
    height: 40px;
  }
}
</style>
