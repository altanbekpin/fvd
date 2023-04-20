<template>
    <div class="card" v-if="products">
        <!-- v-if="  " -->
            <div v-if="(store.roles || []).includes('admin')">
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
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { FilterMatchMode } from 'primevue/api';
import axios from 'axios'
import store from '@/store.js';

// console.log(store.roles)

onMounted(() => {
    loading.value = true;
    console.log('type of:')
    console.log(typeof store.roles)
    console.log('value: ')

    lazyParams.value = {
        first: 0,
        rows: 10,
        sortField: null,
        sortOrder: null,
        filters: filters.value,
    };

    loadLazyData();
});

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


<!-- <template>
    <div class="card">
        <DataTable :value="products" tableStyle="min-width: 50rem">
            <Column field="first_column" header="Ұғым"></Column>
            <Column field="second_column" header="Анықтама"></Column>
            <Column field="third_column" header="Мысал"></Column>
        </DataTable>
    </div>
</template>

<script>
import axios from 'axios'
import { ref } from 'vue';
const products = ref();
export default{
    data() {
        return  {
         response:[],
//          columns : [
//     { field: 'first_column', header: 'Ұғым' },
//     { field: 'second_column', header: 'Анықтама' },
//     { field: 'third_column', header: 'Мысал' },
// ]
    }
  },
  
    async mounted() {
        var temp
        temp = await axios.get('http://127.0.0.1:5001//classification/10')
        this.response = temp.data
        console.log('result of request: ')
        console.log(this.response)
        products.value=this.response
    },
    
}
</script> -->