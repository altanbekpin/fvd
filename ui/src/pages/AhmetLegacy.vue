<template>
  <div class="card flex justify-content-center">
    <TreeTable :value="nodes" @node-expand="onNodeExpand">
      <template #header>
        <div class="row">
          <div class="text-left">Атауы</div>
          <!-- <div class="text-right" style="margin-left: 700px;">
                    <div class="p-input-icon-left">
                        <i class="pi pi-search"></i>
                        <InputText v-model=filters.global placeholder="Іздеу" @keyup="onFilter()" />
                    </div>
                </div> -->
        </div>
      </template>
      <Column headerStyle="width:3rem" :expander="true"> </Column>
      <Column :field="label">
        <template #body="slotProps">
          <i :class="slotProps.node.icon" />
          <span class="pl-2">{{ slotProps.node.label }}</span>
        </template>
      </Column>
      <Column headerStyle="width:10rem">
        <template #body="slotProps">
          <div
            v-if="
              slotProps.node.is_file && store.state.user.roles.includes('admin')
            "
            class="flex flex-wrap gap-2"
          >
            <!-- style="margin-right: 300px;" -->
            <!-- :style="{width: '10vw', marginRight: '10px'}"  -->
            <Button
              type="button"
              icon="pi pi-download"
              @click="getFile(slotProps.node.key)"
              rounded
            />
            <div v-if="store.state.user.roles.includes('admin')">
              <Button
                type="button"
                icon="pi pi-trash"
                @click="setTrue(slotProps.node.key)"
                style="margin-right: 5px"
                rounded
              />
              <Button
                type="button"
                icon="pi pi-pencil"
                @click="setChangeDialog(slotProps.node.key)"
                rounded
              />
            </div>
          </div>
          <div
            v-else-if="slotProps.node.is_file"
            :style="{ marginLeft: '6vw' }"
          >
            <Button
              type="button"
              icon="pi pi-download"
              @click="getFile(slotProps.node.key)"
              rounded
            />
          </div>
          <Button
            v-else-if="store.state.user.roles.includes('admin')"
            type="button"
            icon="pi pi-plus"
            @click="getFolder(slotProps.node)"
          ></Button>
        </template>
      </Column>
    </TreeTable>
    <Dialog
      v-model:visible="visible"
      modal
      header="Файл қосу"
      :style="{ width: '60vw' }"
    >
      <span class="p-input-icon-left">
        <i class="pi pi-pencil" />
        <InputText
          v-model="FileName"
          placeholder="Файлдың атын енгізіңіз"
          style="width: 250px"
        />
      </span>
      <div style="margin-top: 10px">
        <form @submit.prevent="uploadFile">
          <!-- <input type="file" @change="handleFileChange" style="margin-top: 10px;"> -->
          <!-- <FileUpload mode="basic" name="demo[]" url="http://kazlangres.enu.kz/v1/api/upload" :maxFileSize="1000000000000" @upload="onUpload" style="margin-top: 10px;" /> -->
          <FileUpload
            :name="FileName"
            :url="url"
            :formData="form_Data"
            @upload="handleFileUpload"
          ></FileUpload>
          <!-- <Button type="submit" style="margin-top: 10px;">Жүктеу</Button> -->
        </form>
      </div>
    </Dialog>

    <Dialog
      v-model:visible="showDialog"
      modal
      header="Өшіруге сенімдісіз бе?"
      :style="{ width: '30vw' }"
    >
      <div class="row">
        <Button style="margin-right: 20px" @click="setFalse"
          >Артқа қайту</Button
        >
        <Button @click="deleteFile()">Өшіру</Button>
      </div>
    </Dialog>
    <Dialog
      v-model:visible="changeDialog"
      modal
      header="Файлдың атын өзгерту?"
      :style="{ width: '30vw' }"
    >
      <InputText
        v-model="FileName"
        placeholder="Файлдың атын енгізіңіз"
        style="width: 220px; margin-bottom: 10px"
      ></InputText>
      <div class="row">
        <Button style="margin-right: 20px" @click="setChangeDialog"
          >Артқа қайту</Button
        >
        <Button style="margin-right: 20px" @click="changeFileName"
          >Өзгерту</Button
        >
        <Button @click="showTagsDialog">Тег қосу</Button>
      </div>
      <Dialog
        v-model:visible="isDialogForTagsVisible"
        modal
        header="Жаңа тег қосу?"
        :style="{ width: '30vw' }"
      >
        <Dropdown
          v-model="selectedTag"
          :options="tagsToAdd"
          optionLabel="name"
          placeholder="Таңдаңыз"
          class="w-full md:w-14rem"
        />
        <div>
          <Button @click="addTag" style="margin-top: 10px; margin-left: 10px"
            >Тегті қосу</Button
          >
        </div>
      </Dialog>
    </Dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { AhmetService } from "@/service/AhmetService";
import store from "../store.js";
import { AHMET_API } from "../config.js";
import axios from "axios";
// import axios from 'axios'
const selectedTag = ref({ name: "", id: "" });
const nodes = ref(null);
const loading = ref(false);
const visible = ref(false);
const showDialog = ref(false);
const isDialogForTagsVisible = ref(false);
const FileName = ref("");
const path_to_save = ref("");
const form_Data = ref(new FormData());
const fileID = ref("");
const parent_id = ref("");
const changeDialog = ref(false);
const url = computed(() => AHMET_API + "api/upload");
const tagsToAdd = [
  { name: "АҒАРТУШЫ", id: "1" },
  { name: "ҰЛТ ҰСТАЗЫ", id: "2" },
  { name: "ҚОҒАМ ҚАЙРАТКЕРІ", id: "3" },
  { name: "ТІЛТАНУШЫ", id: "4" },
  { name: "ТҮРКІТАНУШЫ", id: "5" },
  { name: "ТЕРМИНТАНУШЫ", id: "6" },
  { name: "ҚАЗАҚ ЖАЗУЫ МЕН ЕМЛЕСІНІҢ РЕФОРМАТОРЫ", id: "7" },
  { name: "ӘДЕБИЕТТАНУШЫ", id: "8" },
  { name: "ФОЛЬКЛОРТАНУШЫ", id: "9" },
  { name: "ӨНЕРТАНУШЫ", id: "10" },
  { name: "АҚЫН", id: "11" },
  { name: "ЖАЗУШЫ", id: "12" },
  { name: "ПУБЛИЦИСТ", id: "13" },
  { name: "АУДАРМАШЫ", id: "14" },
  { name: "ӘДІСКЕР", id: "15" },
  { name: "ПЕДАГОГ", id: "16" },
  { name: "ПСИХОЛОГ", id: "17" },
  { name: "ЗАҢГЕР", id: "18" },
  { name: "САЯСАТКЕР", id: "19" },
  { name: "ДЕМОГРАФ", id: "20" },
  { name: "ТАРИХШЫ", id: "21" },
];
const addTag = () => {
  axios.post(`${AHMET_API}/add/tag`, {
    file_id: fileID.value,
    definition_id: selectedTag.value.id,
  });
};

const handleFileUpload = (event) => {
  console.log(event);
  const file = event.files[0];
  const formData = new FormData();
  formData.append(FileName.value, file);
  formData.append("path_to_save", path_to_save.value);
  formData.append("parent_id", parent_id.value);
  console.log("acess token", store.state.user.access_token);
  fetch(`${AHMET_API}/upload`, {
    method: "POST",
    //headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  })
    .then((response) => {
      console.log("response: ", response);
    })
    .catch((error) => {
      console.log('There"s a issue:', error);
    });
  FileName.value = "";
};

onMounted(() => {
  loading.value = true;
  AhmetService.getTreeTableNodes().then((data) => {
    console.log(data);
    loading.value = false;
    let legacies = data.data;
    for (var i = 0; legacies.length; i++) {
      legacies[i].key = String(legacies[i].key);
      if (legacies[i].is_file === 0) {
        legacies[i].leaf = false;
      }
      nodes.value = legacies;
    }
  });
  console.log(nodes.value);
});
const onNodeExpand = (node) => {
  loading.value = true;
  AhmetService.getTreeTableNodes(node.key).then((data) => {
    loading.value = false;
    let legacies = data.data;
    for (var i = 0; legacies.length; i++) {
      legacies[i].key = String(legacies[i].key);
      if (legacies[i].is_file === 0) {
        legacies[i].leaf = false;
      }
      node.children = legacies;
    }
  });
};
// const onUpload = () => {
//     console.log('asdasjnfkjafnksjdf')
// };
const getFile = (fileID) => {
  console.log(fileID);
  AhmetService.getFile(fileID);
};
const deleteFile = () => {
  const formData = new FormData();
  console.log(fileID.value);
  formData.append("fileID", fileID.value);
  fetch(`${AHMET_API}/delete/file`, {
    method: "POST",
    //headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  });
  setFalse();
};
const changeFileName = () => {
  const formData = new FormData();
  console.log(fileID.value);
  formData.append("fileID", fileID.value);
  formData.append("FileName", FileName.value);
  fetch(`${AHMET_API}/change/file/name`, {
    method: "POST",
    //headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  });
  FileName.value = "";
  changeDialog.value = !changeDialog.value;
};
const getFolder = (slotProps) => {
  visible.value = true;
  path_to_save.value = slotProps.data;
  parent_id.value = slotProps.key;
  form_Data.value.append("path_to_save", path_to_save.value);
  console.log(path_to_save.value);
  console.log(slotProps);
};
const setTrue = (fileID_) => {
  fileID.value = fileID_;
  showDialog.value = true;
};
const setFalse = () => {
  showDialog.value = false;
};
const setChangeDialog = (fileID_) => {
  fileID.value = fileID_;
  changeDialog.value = !changeDialog.value;
};
const showTagsDialog = () => {
  isDialogForTagsVisible.value = true;
};
</script>
<style setup>
.row {
  display: flex;
  align-items: center;
}
.row div {
  margin-right: 10px;
}
</style>
