<template>
    <div class="card" v-if="products">
            <div v-if="store.getters.getRoles.includes('admin')">
                <Toolbar class="mb-4" style="border-color: white; background-color: white;" >
                <template #start>
                        <Button label="New" icon="pi pi-plus" severity="success" class="mr-2" @click="openNew" />
                        <Button label="Delete" icon="pi pi-trash" severity="danger" @click="confirmDeleteSelected" :disabled="!selectedProducts || !selectedProducts.length" />   
                    
                </template>
            </Toolbar>
            </div>
        
        <DataTable :value="products" lazy v-model:filters="filters"  :rows="10" ref="dt" :loading="loading" dataKey="id"
        :totalRecords="totalRecords"  filterDisplay="row"
        @page="onPage($event)" @sort="onSort($event)" @filter="onFilter($event)"
        :globalFilterFields="['first_column', 'second_column', 'third_column']" showGridlines paginator  tableStyle="min-width: 50rem">
            <template #header>
                <!-- <div>{{ typeof store.roles  }}</div> -->
                <div class="flex justify-content-between">
                    <Button type="button" icon="pi pi-filter-slash" label="Тазалау" outlined @click="clearFilter()" />
                    <span class="p-input-icon-left">
                        <i class="pi pi-search" />
                        <InputText v-model="filters['global'].value" placeholder="Іздеу" @keyup="onFilter()" style="border-radius: 15px;" />
                    </span>
                </div>
            </template>
            <template #empty> Ешнәрсе табылмады. </template>
            <template #loading> Күте тұрыңыз. </template>
            <Column field="name" header="Ұғым"></Column>
            <Column field="description" header="Анықтама"></Column>
            <Column field="examples" header="Мысал"></Column>
        </DataTable>
    </div>
    <div class="rounded-dialog">
        <Dialog v-model:visible="productDialog" :style="{width: '450px'}" header="Жаңадан қосу" :modal="true" class="p-fluid">
            
            <div class="field">
                <label for="name">Ұғым</label>
                <InputText id="name"  required="true" autofocus :class="{'p-invalid': submitted && !product.name}" />
                <!-- <small class="p-error" v-if="submitted && !product.name">Name is required.</small> -->
            </div>
            <div class="field">
                <label for="description">Анықтама</label>
                <Textarea id="description" required="true" rows="3" cols="20" />
            </div>
            <div class="field">
                <label for="description">Мысал</label>
                <Textarea id="description" required="true" rows="3" cols="20" />
            </div>
           
            <template #footer>
                <Button label="Cancel" icon="pi pi-times" text @click="hideDialog"/>
                <Button label="Save" icon="pi pi-check" text @click="saveProduct" />
            </template>
        </Dialog>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { FilterMatchMode } from 'primevue/api';
import store from '../store.js';
import axios from 'axios'
onMounted(() => {
    loading.value = true;
    console.log('roles:')
    console.log(store.getters.getRoles)

    lazyParams.value = {
        first: 0,
        rows: 10,
        sortField: null,
        sortOrder: null,
        filters: filters.value,
    };

    loadLazyData();
});
const productDialog = ref(false);
const openNew = () => {
    productDialog.value = true;
};

const dt = ref();
const loading = ref(false);
const totalRecords = ref(0);

const lazyParams = ref({});
const filters = ref({
    'global': {value: '', matchMode: 'contains'},
});
const loadLazyData = async() => {
    var temp = await axios.post('http://127.0.0.1:5001/classification/', lazyParams.value)
        products.value = temp.data
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
const onFilter = () => {
    lazyParams.value.filters = filters.value ;
    lazyParams.value.page = 0
    loadLazyData();
};


const products = ref();
const initFilters = () => {
    filters.value = {
        global: { value: null, matchMode: FilterMatchMode.CONTAINS }
    }
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