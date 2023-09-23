<template>
  <div class="card" v-if="products" style="min-width: 55rem">
    <div v-if="store.getters.getRoles.includes('admin')">
      <Toolbar
        class="mb-4"
        style="border-color: white; background-color: white; min-width: 50rem"
      >
        <template #start>
          <Button
            label="Жаңа ұғым қосу"
            icon="pi pi-plus"
            severity="success"
            class="mr-2"
            @click="openNew"
          />
          <Button
            label="Өшіру"
            icon="pi pi-trash"
            severity="danger"
            class="mr-2"
            @click="confirmDeleteSelected('delete')"
            :disabled="!selectedProducts || !selectedProducts.length"
          />
          <Button
            label="Өзгерту"
            icon="pi pi-trash"
            severity="danger"
            @click="openChangeDialog"
            :disabled="!selectedProducts || !selectedProducts.length"
          />
        </template>
      </Toolbar>
    </div>
    <DataTable
      :value="products"
      lazy
      v-model:selection="selectedProducts"
      :filters="filters"
      :rows="10"
      ref="dt"
      :loading="loading"
      dataKey="id"
      :totalRecords="totalRecords"
      filterDisplay="row"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
      :globalFilterFields="['first_column', 'second_column', 'third_column']"
      showGridlines
      paginator
      tableStyle="min-width: 50rem"
    >
      <template #header>
        <!-- <div>{{ typeof store.roles  }}</div> -->
        <div class="flex justify-content-between">
          <Button
            type="button"
            icon="pi pi-filter-slash"
            label="Тазалау"
            outlined
            @click="clearFilter()"
          />
          <span class="p-input-icon-left">
            <i class="pi pi-search" />
            <InputText
              v-model="filters['global'].value"
              placeholder="Іздеу"
              @keyup="onFilter()"
              style="border-radius: 15px"
            />
          </span>
        </div>
      </template>
      <template #empty> Ешнәрсе табылмады. </template>
      <template #loading> Күте тұрыңыз. </template>
      <div v-if="store.getters.getRoles.includes('admin')">
        <Column
          selectionMode="multiple"
          style="width: 3rem"
          :exportable="false"
        ></Column>
      </div>
      <Column field="name" header="Ұғым"></Column>
      <Column field="description" header="Анықтама"></Column>
      <Column field="examples" header="Мысал"></Column>
    </DataTable>
  </div>
  <div class="rounded-dialog">
    <Dialog
      v-model:visible="productDialog"
      :style="{ width: '450px' }"
      header="Жаңадан қосу"
      :modal="true"
      class="p-fluid"
    >
      <div class="field">
        <label for="name">Ұғым</label>
        <InputText
          id="name"
          required="true"
          v-model="request.name.value"
          autofocus
          :class="{ 'p-invalid': submitted }"
        />
        <small class="p-error" v-if="submitted.valueOf()"
          >Толтыру маңызды.</small
        >
      </div>
      <div class="field">
        <label for="description">Анықтама</label>
        <Textarea
          id="description"
          required="true"
          rows="3"
          cols="20"
          v-model="request.description.value"
        />
      </div>
      <div class="field">
        <label for="description">Мысал</label>
        <Textarea
          id="description"
          required="true"
          rows="3"
          cols="20"
          v-model="request.example.value"
        />
      </div>

      <template #footer>
        <Button label="Бас тарту" icon="pi pi-times" text @click="hideDialog" />
        <Button
          label="Сақтау"
          icon="pi pi-check"
          text
          @click="editProduct('create')"
        />
      </template>
    </Dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { FilterMatchMode } from "primevue/api";
import store from "../store.js";
import { useToast } from "primevue/usetoast";
import axios from "axios";
import { AHMET_API, getHeader } from "../config";
import { useRoute } from "vue-router";

//import { reactive } from 'vue';
const route = useRoute();
const toast = useToast();
watch(
  () => route.fullPath,
  (newRoute, oldRoute) => {
    // Handle the route change here
    console.log("Route changed from", oldRoute, "to", newRoute);
    init();
    // currentRoute.value = newRoute;
    // You can perform any other actions you need here
  }
);
onMounted(() => {
  init();
});
const init = () => {
  loading.value = true;
  // console.log("roles:");
  // console.log(store.getters.getRoles);
  lazyParams.value = {
    first: 0,
    rows: 10,
    sortField: null,
    sortOrder: null,
    filters: filters.value,
  };

  loadLazyData();
};
const productDialog = ref(false);
const openNew = () => {
  productDialog.value = true;
};
const request = {
  name: ref(""),
  example: ref(""),
  description: ref(""),
  method: ref(""),
  id: ref(""),
};
const selectedProducts = ref();
const editProduct = async (method) => {
  if (request.method.value === "") {
    request.method.value = method;
  }
  if (request.name.value === "") {
    submitted.value = true;
  } else {
    try {
      await axios.post(`${AHMET_API}/editPost/`, request, {
        headers: {
          Authorization: `Bearer ${store.state.user.access_token}`,
          "Access-Control-Allow-Credentials": "true",
          "Content-Type": "application/json",
          Accept: "*/*",
        },
      });
      toast.add({
        severity: "success",
        summary: "Сәтті",
        detail: "Жаңа термин сәтті еңгізілді",
        life: 3000,
      });
    } catch (error) {
      toast.add({
        severity: "error",
        summary: "Ақау",
        detail: "Қайта істеп көріңіз",
        life: 3000,
      });
    } finally {
      loadLazyData();
    }
    submitted.value = false;
    productDialog.value = false;
    request.name.value = "";
    request.description.value = "";
    request.example.value = "";
    selectedProducts.value = null;
  }
};
const confirmDeleteSelected = async (method) => {
  // console.log(method);
  try {
    const id = selectedProducts.value.map((obj) => obj["id"]);
    const request = {
      method: { _value: method },
      id: id,
    };
    await axios.post(`${AHMET_API}/editPost/`, request, {
      headers: {
        Authorization: `Bearer ${store.state.user.access_token}`,
        "Access-Control-Allow-Credentials": "true",
        "Content-Type": "application/json",
        Accept: "*/*",
      },
    });
    toast.add({
      severity: "success",
      summary: "Сәтті",
      detail: "Термин сәтті өшірілді",
      life: 3000,
    });
  } catch (error) {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Қайта істеп көріңіз",
      life: 3000,
    });
  } finally {
    loadLazyData();
    selectedProducts.value = null;
  }

  // console.log(request);
};
const dt = ref();
const loading = ref(false);
const totalRecords = ref(0);
const openChangeDialog = () => {
  if (selectedProducts.value.length > 1) {
    toast.add({
      severity: "error",
      summary: "Тым көп",
      detail: "Тек бір термин өзгертуге болады",
      life: 3000,
    });
    return;
  }
  request.id.value = selectedProducts.value[0]["id"];
  request.name.value = selectedProducts.value[0]["name"];
  request.description.value = selectedProducts.value[0]["description"];
  request.example.value = selectedProducts.value[0]["examples"];
  request.method.value = "update";
  productDialog.value = true;
};
const lazyParams = ref({});
const filters = ref({
  global: { value: "", matchMode: "contains" },
});
const submitted = ref(false);
const loadLazyData = async () => {
  lazyParams.value["param"] = route.params.id;
  var temp = await axios.post(
    `${AHMET_API}/classification/`,
    lazyParams.value,
    { headers: getHeader() }
  );
  products.value = temp.data;
  loading.value = false;
  totalRecords.value = 9999;
};
const onPage = (event) => {
  lazyParams.value = event;
  loadLazyData();
};
const onSort = (event) => {
  lazyParams.value = event;
  loadLazyData();
};
const hideDialog = () => {
  productDialog.value = false;
};
const onFilter = () => {
  lazyParams.value.filters = filters.value;
  lazyParams.value.page = 0;
  loadLazyData();
};

const products = ref();
const initFilters = () => {
  filters.value = {
    global: { value: null, matchMode: FilterMatchMode.CONTAINS },
  };
};
initFilters();
const clearFilter = () => {
  initFilters();
};
</script>
<style setup>
.rounded-dialog {
  border-radius: 10px;
}
</style>
