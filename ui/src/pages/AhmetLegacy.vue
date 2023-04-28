<template>
    <div class="card flex justify-content-center">
        <TreeTable :value="nodes" @node-expand="onNodeExpand">
            <template #header>
        <div class="row">
            <div class="text-left">
            Атауы
        </div>
        <div style="margin-left: 900px;">
            <Button v-if="store.state.user.roles.includes('admin')" type="button" icon="pi pi-pencil"></Button>
        </div>
        </div>
    </template>
            <Column  headerStyle="width:3rem" :expander="true" >
            </Column>
            <Column :field="label" >
                <template #body="slotProps">
                    <i :class="slotProps.node.icon"/>
                    <span class="pl-2">{{slotProps.node.label}}</span>
                </template>
            </Column>
            <Column  headerStyle="width:4rem">
                <template #body="slotProps">
                    <Button v-if="slotProps.node.is_file" type="button" icon="pi pi-download" @click="getFile(slotProps.node.key)" rounded/>
                    <Button v-else-if="store.state.user.roles.includes('admin')" type="button" icon="pi pi-plus" @click="getFolder(slotProps.node)"></Button>
                </template>
            </Column>

            
        </TreeTable>
        <Dialog v-model:visible="visible" modal header="Файл қосу" :style="{ width: '60vw' }">
            <span class="p-input-icon-left">
                <i class="pi pi-pencil" />
                <InputText v-model="FileName" placeholder="Файлдың атын енгізіңіз" style="width: 250px; " />
               
            </span>
            <div style="margin-top: 10px;">
                    <form @submit.prevent="uploadFile">
                        <!-- <input type="file" @change="handleFileChange" style="margin-top: 10px;"> -->
                        <!-- <FileUpload mode="basic" name="demo[]" url="http://127.0.0.1:5001/upload" :maxFileSize="1000000000000" @upload="onUpload" style="margin-top: 10px;" /> -->
                        <FileUpload :name= FileName url="http://127.0.0.1:5001/upload" :formData=form_Data  @upload="handleFileUpload" ></FileUpload>
                        <!-- <Button type="submit" style="margin-top: 10px;">Жүктеу</Button> -->
                    </form>
                </div>
        </Dialog>
    </div>
</template>


<script setup>
import { ref, onMounted } from 'vue';
import { AhmetService } from '@/service/AhmetService';
import store from '../store.js';
const nodes = ref(null);
const loading = ref(false);
const visible = ref(false);
const FileName = ref('');
const path_to_save = ref('')
const form_Data = ref(new FormData());
const parent_id = ref('');
const handleFileUpload = (event) =>{
  console.log(event)
  const file = event.files[0];
  const formData = new FormData();
  formData.append(FileName.value, file);
  formData.append('path_to_save', path_to_save.value);
  formData.append('parent_id', parent_id.value)
  console.log("acess token",store.state.user.access_token)
  fetch('http://127.0.0.1:5001/upload', {
    method: 'POST',
    //headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  })
  .then(response => {
    console.log('response: ',response)
  })
  .catch(error => {
    console.log('There"s a issue:',error)
  });
}

onMounted(() => {
    loading.value =true
    AhmetService.getTreeTableNodes().then((data) => {
        console.log(data)
        loading.value = false
        let legacies = data.data;
        for (var i=0;legacies.length; i++) {
            legacies[i].key = String(legacies[i].key)
            if(legacies[i].is_file  === 0) {
                legacies[i].leaf = false
            }
            nodes.value = legacies
        }
    });
    console.log(nodes.value)
});
// const handleFileUpload = (event) =>{
//       const file = event.files[0];
//       console.log('Uploaded file:', file);
//       // Do something with the file here
// };
const onNodeExpand = (node) => {
    loading.value = true
    AhmetService.getTreeTableNodes(node.key).then(data => {
        
        loading.value = false
        let legacies = data.data;
        for (var i=0;legacies.length; i++) {
            legacies[i].key = String(legacies[i].key)
            if(legacies[i].is_file  === 0) {
                legacies[i].leaf = false
            }
            node.children = legacies
        }
    });
}
// const onUpload = () => {
//     console.log('asdasjnfkjafnksjdf')
// };
const getFile = (fileID) => {
  AhmetService.getFile(fileID)
};
const getFolder = (slotProps) => {
    visible.value = true
    path_to_save.value = slotProps.data
    parent_id.value = slotProps.key
    form_Data.value.append('path_to_save', path_to_save.value)
    console.log(path_to_save.value)
    console.log(slotProps)
}

</script>
<style setup>
.row{
  display: flex;
  align-items: center;
}
.row div{
  margin-right: 10px;
}
</style>