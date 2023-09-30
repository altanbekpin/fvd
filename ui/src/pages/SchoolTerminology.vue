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
            v-if="isUserAdmin || isUserExpert"
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

          <Button
            type="button"
            icon="pi pi-book"
            label="Оқулықтар"
            outlined
            @click="showBooks()"
            style="margin-right: 4%"
          />
          <span class="p-input-icon-left input-span">
            <i class="pi pi-search" />
            <InputText v-model="filters['global'].value" placeholder="Іздеу" />
          </span>
        </div>
      </template>
      <template #empty> Ешнарсе табылмады. </template>
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
      <Column headerStyle="width: 3rem">
        <template #body="{ data }">
          <Button
            icon="pi pi-comments"
            aria-label="Submit"
            style="width: 35px; height: 35px"
            @click="showAddComment(data.id)"
          />
        </template>
      </Column>
    </DataTable>
  </div>
  <!-- add a new termin dialog -->
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
          label="Пән қосу"
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
  <!-- add a new subject dialog -->
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
  <!-- change a termin dialog -->
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
          label="Пән қосу"
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
  <!-- Add a comment -->
  <Dialog
    v-model:visible="showAddCommentDialog"
    :style="{ width: '450px' }"
    header="Комментарий жазу"
    :modal="true"
    class="p-fluid"
  >
    <span class="p-float-label" style="margin-top: 20px">
      <InputText id="username" v-model="username" />
      <label for="username">Аты-жөніңіз</label>
    </span>

    <form
      @submit="onSubmit"
      class="flex flex-column gap-2"
      style="margin-top: 20px"
    >
      <span class="p-float-label">
        <Textarea
          id="value"
          v-model="comment"
          :class="{ 'p-invalid': errorMessage }"
          rows="4"
          cols="30"
          aria-describedby="text-error"
        />
        <label for="value">Комментарий</label>
      </span>
      <small id="text-error" class="p-error">{{
        errorMessage || "&nbsp;"
      }}</small>
      <div style="display: flex; flex-direction: row">
        <Button
          v-if="isUserAdmin || isUserExpert"
          icon="pi pi-eye"
          aria-label="Submit"
          style="margin-right: 10px"
          @click="showComment"
        />
        <Button type="submit" label="Жіберу" @click="sendComment" />
      </div>
      <Toast />
    </form>
  </Dialog>
  <!-- get comments dialog -->
  <Dialog
    v-model:visible="showCommentDialog"
    :style="{ width: '450px' }"
    header="Комментарий көру"
    :modal="true"
    class="p-fluid"
  >
    <div v-for="comment in comments" :key="comment.id">
      <span>{{ comment.username }}:</span>
      <Message severity="info" icon="pi pi-send">{{ comment.comment }}</Message>
    </div>
    <template #footer>
      <Button
        label="Өшіру"
        severity="danger"
        icon="pi pi-trash"
        text
        @click="deleteComments"
      ></Button>
    </template>
  </Dialog>
  <!-- show all books dialog -->
  <Dialog
    v-model:visible="showBooksDialog"
    :style="{ width: '500px' }"
    header="Оқулықтар"
    :modal="true"
    class="p-fluid"
  >
    <DataTable
      :value="bookSubjects"
      lazy
      :loading="loadingbook"
      v-model:filters="filtersbook"
      @page="onPageBook($event)"
      ref="dt2"
      dataKey="id2"
      paginator
      :totalRecords="totalRecordsBook"
      :rows="5"
    >
      <Column field="subject" header="Пән" style="width: 25%"></Column>
      <Column
        field="class"
        header="Сынып"
        :showFilterMenu="false"
        :filterMenuStyle="{ width: '14rem' }"
        style="min-width: 25%"
      >
        <template #filter="{ filterModel, filterCallback }">
          <Dropdown
            @change="filterCallback()"
            v-model="filterModel.value"
            :options="classes"
            placeholder="Сынып таңдаңыз"
          >
          </Dropdown> </template
      ></Column>
      <Column field="class" header="Кітап">
        <template #body="{ data }">
          <a :href="`http://localhost:5001/book/download/${data.id}`">{{
            data.name
          }}</a>
        </template>
      </Column>
      <Column>
        <template #body="{ data }">
          <Button
            v-if="isUserAdmin || isUserExpert"
            style="width: 35px; height: 35px"
            icon="pi pi-pencil"
            aria-label="Submit"
            @click="showEditBook(data)"
          />
        </template>
      </Column>
    </DataTable>
    <Button
      v-if="isUserAdmin || isUserExpert"
      label="Жаңа оқулық қосу"
      icon="pi pi-plus"
      @click="showAddBook"
    />
  </Dialog>
  <!-- add a new book dialog -->
  <Dialog
    v-model:visible="showAddBookDialog"
    :style="{ width: '500px' }"
    header="Жаңа оқулық қосу"
    :modal="true"
    class="p-fluid"
  >
    <Dropdown
      v-model="selectedSubjectForAddBook"
      :options="subjects"
      optionLabel="subject"
      placeholder="Пән тандаңыз"
      style="margin-bottom: 20px"
    />
    <Dropdown
      v-model="selectedClassForAddBook"
      :options="classes"
      placeholder="Сынып тандаңыз"
    />

    <span class="p-float-label" style="margin-top: 20px; margin-bottom: 20px">
      <InputText id="filename" v-model="FileName" />
      <label for="filename">Кітаптың аты</label>
    </span>
    <FileUpload
      :name="FileName"
      :url="url"
      :formData="form_Data"
      @upload="handleFileUpload"
    ></FileUpload>
  </Dialog>
  <!-- edit a book dialog -->
  <Dialog
    v-model:visible="showEditBookDialog"
    modal
    header="Оқулықты өзгерту"
    :style="{ width: '40dvh' }"
  >
    <Dropdown
      v-model="subjectToEdit"
      :options="subjects"
      optionLabel="subject"
      placeholder="Пән тандаңыз"
      style="margin-bottom: 20px"
    />
    <Dropdown
      v-model="classToEdit"
      :options="classes"
      placeholder="Сынып тандаңыз"
      style="margin-bottom: 20px"
    />
    <InputText
      v-model="bookNameToEdit"
      type="text"
      placeholder="Кітаптың аты"
    />
    <template #footer>
      <Button
        label="Жабу"
        icon="pi pi-times"
        @click="showEditBookDialog = false"
        text
      />
      <Button label="Жіберу" icon="pi pi-check" @click="sendToEdit" autofocus />
    </template>
  </Dialog>
</template>
<script>
import { AhmetService } from "@/service/AhmetService";
import { AHMET_API } from "@/config";
import { useStore } from "vuex";

export default {
  data() {
    return {
      totalRecordsBook: 100,
      bookNameToEdit: null,
      url: `${AHMET_API}/upload/school/book`,
      showEditBookDialog: false,
      // books: [{ class: 3, subject: "Adasskdmakls" }],
      loadingbook: false,
      filtersbook: null,
      FileName: "",
      form_Data: new FormData(),
      showAddBookDialog: false,
      selectedProduct: null,
      showChangeSubjectDialog: false,
      showAddCommentDialog: false,
      showBooksDialog: false,
      showCommentDialog: false,
      comments: [],
      requestToChange: {
        definition: null,
        termin: null,
        subject: null,
        school_class: null,
        id: null,
      },
      subjectToEdit: null,
      classToEdit: null,
      comment: null,
      username: null,
      lazyParamsBook: {},
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
      bookSubjects: null,
      subjects: [],
      store: null,
      termin_id: null,
      selectedClassForAddBook: null,
      selectedSubjectForAddBook: null,
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
    showEditBook(data) {
      this.subjectToEdit = data.subject;
      this.classToEdit = data.class;
      this.showEditBookDialog = true;
    },
    sendToEdit() {
      console.log("this.subjectToEdit:", this.subjectToEdit);
      console.log("this.classToEdit:", this.classToEdit);
    },
    handleFileUpload(event) {
      const formData = new FormData();
      console.log("url:", this.url);
      console.log("FileName:", this.FileName);
      console.log("subject_id:", this.selectedSubjectForAddBook.id);
      console.log("selectedClassForAddBook:", this.selectedClassForAddBook);
      const file = event.files[0];
      formData.append(this.FileName, file);
      formData.append("class", this.selectedClassForAddBook);
      formData.append("subject_id", this.selectedSubjectForAddBook.id);
      console.log("form_data:", this.form_Data);
      fetch(`${AHMET_API}/upload/school/book`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${this.store.getters.getAccessToken}`,
        },
        body: formData,
      })
        .then(() => {
          // console.log("response: ", response);
          this.$toast.add({
            severity: "success",
            summary: "Қосылды",
            detail: "Жаңа файл сәтті қосылды",
            life: 3000,
          });
        })
        .catch((error) => {
          // console.log('There"s a issue:', error);
          this.$toast.add({
            severity: "error",
            summary: "Ақау",
            detail: error,
            life: 3000,
          });
        });
      // .finally(() => init());
      this.FileName = "";
    },
    showAddBook() {
      this.showAddBookDialog = true;
    },
    async deleteComments() {
      const access_token = this.store.getters.getAccessToken;
      await AhmetService.deleteComments(
        { termin_id: this.termin_id },
        access_token
      );
      this.showCommentDialog = false;
    },
    showComment() {
      this.showCommentDialog = true;
      this.getComments();
    },
    async getComments() {
      const access_token = this.store.getters.getAccessToken;
      this.comments = (
        await AhmetService.getComments(this.termin_id, access_token)
      ).data;
    },
    async sendComment() {
      this.showAddCommentDialog = false;
      try {
        await AhmetService.sendComment({
          comment: this.comment,
          username: this.username,
          termin_id: this.termin_id,
        });
        this.$toast.add({
          severity: "success",
          summary: "Жіберілді",
          detail: "сәтті жіберілді",
          life: 3000,
        });
      } catch (e) {
        this.$toast.add({
          severity: "error",
          summary: "Жіберілмеді",
          detail: "Қайта жіберіп көріңіз",
          life: 3000,
        });
      }
    },
    showAddComment(termin_id) {
      this.termin_id = termin_id;
      this.showAddCommentDialog = true;
    },
    async showBooks() {
      this.totalRecordsBook = (
        await AhmetService.countSchoolBooks()
      ).data.count;
      this.showBooksDialog = true;
      this.loadBooks();
    },
    async loadBooks() {
      if (this.$refs.dt2) {
        this.lazyParamsBook = {
          first: this.$refs.dt2.first,
          rows: this.$refs.dt2.rows,
          sortField: null,
          sortOrder: null,
          filters: this.filters,
        };
      }

      console.log("this.lazyParamsBook:", this.lazyParamsBook);
      this.lazyLoadBooks();
    },
    async lazyLoadBooks() {
      const response = await AhmetService.loadBooks();
      this.bookSubjects = response.data;
    },
    onPageBook(event) {
      this.lazyParamsBook = event;
      console.log("this.lazyParamsBook:", this.lazyParamsBook);
      // this.loadLazyData();
    },
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
      console.log("this.customers:", this.customers);
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
