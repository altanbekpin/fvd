<template>
  <div class="card bounder">
    <h4>
      Сұрақ-жауап жүйесі
    </h4>
    <Toast />
    <hr height="20px" />
    <div class="row">
      <div>
        <span style="font-size: 14px">
          Қойылған сұраққа жауап Грамматика бойынша жаңа білім жүйесінен құралған онтологиялық модель негізінде орындалады
        </span>
      </div>
    </div>
    <div class="row">
      <div class="mt-3 w-full">
        <span class="p-input-icon-left w-full p-inputtext p-1 shadow">
          <i class="pi pi-search" />
          <AutoComplete  @item-select="selectQuestion" completeOnFocus="true" inputClass="w-full pi pi-search ml-5 border-none pl-0 noshadow" class="w-full" v-model="question" :suggestions="items" @complete="search">
          </AutoComplete>
        </span>
      </div>
    </div>
    
    <div v-if="answers.length>0" class="row">
      <div class="table">
        <h5 class="pt-3 row">Нәтижелер:</h5>
      <p class="row pl-2" v-for="answer in answers" :key="answer">
         {{ answer.answer}}</p>
      
    </div>
    </div>
  </div>
</template>

<script>
import { AhmetService } from "../service/AhmetService";

export default {
  data() {
    return {
      question: "",
      answers: [],
      questions: null,
      selectedItem: null,
      items: [],
    };
  },
  methods: {
    async ask() {
      const response = await AhmetService.ask(this.question);
      console.log(response);
      this.answer = response.data;
    },
    search(event) {
      let temp = this.items
      if (event.query === '') {
        console.log(temp);
        let data = [];
          temp.forEach(element => {
          data.push(element + "");
        });        
        this.items =data;
      }
      else if (event.query.length>2) {

        this.answer = [];
        AhmetService.getQuestions(event.query, this.$route.params.id).then(response =>{
        let data = [];
        response.data.data.forEach(element => {
          data.push(element.question);
        });
        this.items = data;
        this.questions = response.data.data;
      });
    }
    },
    selectQuestion() {
      let index = -1;
      index = this.items.indexOf(this.question);
      if (index >= 0) {
        this.answers = this.questions[index].answers;
      }
    }
  },
};
</script>
<style scoped>
.noshadow {
  border: none;
}
::v-deep(.noshadow:enabled:focus) {
  outline: 0 none;
  outline-offset: 0;
  box-shadow: 0 0 0 1px #93cbf9;
  border-color: #64B5F6;
  
}

</style>
