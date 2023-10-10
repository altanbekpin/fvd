<template>
  <div class="card flex justify-content-center" style="min-width: 500px">
    <TreeTable :value="nodes" @node-expand="onNodeExpand">
      <template #header>
        <div class="row">
          <div class="text-left">Атауы</div>
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
            v-if="(slotProps.node.is_file && isAdmin()) || isExpert()"
            class="flex flex-wrap gap-2"
          >
            <Button
              type="button"
              icon="pi pi-download"
              @click="getFile(slotProps.node.key)"
              rounded
            />
            <div v-if="isAdmin() || isExpert()">
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
            v-else-if="isAdmin() || isExpert()"
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
          <FileUpload
            :name="FileName"
            :url="url"
            :formData="form_Data"
            @upload="handleFileUpload"
          ></FileUpload>
        </form>
      </div>
      <template #footer>
        <Button label="Жабу" icon="pi pi-times" @click="visible = false" text />
        <Button
          label="Сақтау"
          icon="pi pi-check"
          @click="(visible = false), handleFileUpload({ adam: true })"
        />
      </template>
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
        <!-- <Button @click="showTagsDialog">Тег қосу</Button> -->
        <Button @click="showLegacyDialog">Тегтерін көру</Button>
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
    <Dialog v-model:visible="showFile" modal>
      <object
        :data="path_to_download"
        type="application/pdf"
        width="1300px"
        height="600px"
      ></object>
    </Dialog>
    <Dialog
      v-model:visible="showLegacies"
      :style="{ width: '40vw', maxHeight: '80vh' }"
      header="Тегтері"
      :modal="true"
      class="p-0"
    >
      <div class="scrollable-content">
        <div v-for="data in repo" :key="data.id" class="card">
          <div class="row" style="justify-content: space-between">
            <div class="row">
              <i class="pi pi-file"></i>
              <div class="ml-2">
                {{ data.name }}
              </div>
            </div>
            <Button
              type="button"
              icon="pi pi-trash"
              @click="removeTag(data)"
              rounded
            />
            <!-- @click="searchBook(data.key)" -->
          </div>
        </div>
      </div>
      <template #footer>
        <Button
          label="Жабу"
          icon="pi pi-times"
          @click="showLegacies = false"
          text
        />
        <Button
          label="Қосу"
          icon="pi pi-plus"
          @click="showTagsDialog"
          autofocus
        />
      </template>
    </Dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { AhmetService } from "@/service/AhmetService";

import store from "../store.js";
import { AHMET_API, getHeader } from "../config.js";
import axios from "axios";
import { useToast } from "primevue/usetoast";
const repo = ref(null);
const toast = useToast();
const selectedTag = ref({ name: "", id: "" });
const nodes = ref(null);
const loading = ref(false);
const visible = ref(false);
const showLegacies = ref(false);
const showDialog = ref(false);
const isDialogForTagsVisible = ref(false);
const FileName = ref("");
const path_to_save = ref("");
const form_Data = ref(new FormData());
const fileID = ref("");
const parent_id = ref("");
const changeDialog = ref(false);
const url = computed(() => AHMET_API + "/upload");
const removeTag = async (data) => {
  const access_token = store.getters.getAccessToken;
  console.log("access_token:", access_token);
  await AhmetService.deleteTagLag(data, access_token);
  console.log("data:", data);
  await showLegacyDialog();
};
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
const isAdmin = () => {
  console.log(store.state.user.roles);
  // isAdmin() || isExpert()
  return store.state.user.roles.includes("admin");
};
const isExpert = () => {
  return store.state.user.roles.includes("expert");
};
const addTag = async () => {
  try {
    await axios.post(
      `${AHMET_API}/add/tag`,
      {
        file_id: fileID.value,
        definition_id: selectedTag.value.id,
      },
      {
        // headers: getHeader(useStore().getters.getAccessToken),
        headers: getHeader(store.getters.getAccessToken),
      }
    );

    toast.add({
      severity: "success",
      summary: "Қосылды",
      detail: "Жаңа тег сәтті қосылды",
      life: 3000,
    });
  } catch (e) {
    toast.add({
      severity: "error",
      summary: "Ақау",
      detail: "Тег қосылмады",
      life: 3000,
    });
  } finally {
    isDialogForTagsVisible.value = false;
  }
};
// const hasAllowedExtension = (filename) => {
//   return
//   const allowedExtensions = ["pdf", "json", "txt"]; // Add more extensions as needed
//   const extension = filename.split(".").pop().toLowerCase();
//   return allowedExtensions.includes(extension);
// };
const showLegacyDialog = async () => {
  const data = await AhmetService.getLegaciesByID(fileID.value);
  repo.value = data.data;
  showLegacies.value = true;
};
const handleFileUpload = (event) => {
  if (event.adam) {
    const formData = new FormData();
    formData.append("filename", FileName.value);
    formData.append("path_to_save", path_to_save.value);
    formData.append("parent_id", parent_id.value);
    fetch(`${AHMET_API}/upload`, {
      method: "POST",
      headers: { Authorization: `Bearer ${store.state.user.access_token}` },
      body: formData,
    })
      .then(() => {
        // console.log("response: ", response);
        toast.add({
          severity: "success",
          summary: "Қосылды",
          detail: "Жаңа файл сәтті қосылды",
          life: 3000,
        });
      })
      .catch((error) => {
        // console.log('There"s a issue:', error);
        toast.add({
          severity: "error",
          summary: "Ақау",
          detail: error,
          life: 3000,
        });
      })
      .finally(() => init());
    FileName.value = "";
    return;
  }
  const file = event.files[0];
  const formData = new FormData();
  formData.append(FileName.value, file);
  formData.append("path_to_save", path_to_save.value);
  formData.append("parent_id", parent_id.value);
  // console.log("acess token", store.state.user.access_token);
  // console.log("handleFileUpload");
  fetch(`${AHMET_API}/upload`, {
    method: "POST",
    headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  })
    .then(() => {
      // console.log("response: ", response);
      toast.add({
        severity: "success",
        summary: "Қосылды",
        detail: "Жаңа файл сәтті қосылды",
        life: 3000,
      });
    })
    .catch((error) => {
      // console.log('There"s a issue:', error);
      toast.add({
        severity: "error",
        summary: "Ақау",
        detail: error,
        life: 3000,
      });
    })
    .finally(() => init());
  FileName.value = "";
};
onMounted(() => {
  loading.value = true;
  init();
  // console.log(nodes.value);
});
const init = () => {
  AhmetService.getTreeTableNodes().then((data) => {
    // console.log(data);
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
};
const onNodeExpand = (node) => {
  loading.value = true;
  AhmetService.getTreeTableNodes(node.key).then((data) => {
    console.log(data);
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
const path_to_download = ref("");
const showFile = ref(false);
const getFile = (fileID) => {
  path_to_download.value = `${AHMET_API}/legacy/download/` + fileID;
  showFile.value = true;
};
const deleteFile = () => {
  const formData = new FormData();
  // console.log(fileID.value);
  formData.append("fileID", fileID.value);
  fetch(`${AHMET_API}/delete/file`, {
    method: "POST",
    headers: { Authorization: `Bearer ${store.state.user.access_token}` },
    body: formData,
  });
  toast.add({
    severity: "success",
    summary: "Өшірілді",
    detail: "Файл сәтті өшірілд",
    life: 3000,
  });
  init();
  setFalse();
};
const changeFileName = () => {
  const formData = new FormData();
  // console.log(fileID.value);
  formData.append("fileID", fileID.value);
  formData.append("FileName", FileName.value);
  fetch(`${AHMET_API}/change/file/name`, {
    method: "POST",
    headers: { Authorization: `Bearer ${store.state.user.access_token}` },
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
  // console.log(path_to_save.value);
  // console.log(slotProps);
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
