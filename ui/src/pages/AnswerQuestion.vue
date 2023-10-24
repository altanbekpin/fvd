<template>
  <div class="card bounder">
    <h4>
      {{$t("qas.title")}}
    </h4>
    <Toast />
    <hr height="20px" />
    <div class="row">
      <div>
        <span style="font-size: 14px">
          {{ $t('qas.description') }}
        </span>
      </div>
    </div>
    <div class="row">
      <div class="mt-3 w-full">
        <span class="p-input-icon-left w-full p-inputtext p-1 shadow">
          <i class="pi pi-search" />
          <AutoComplete forceSelection @item-select="selectQuestion" completeOnFocus="true" inputClass="w-full pi pi-search ml-5 border-none pl-0 noshadow" class="w-full" v-model="question" :suggestions="items" @complete="search">
          </AutoComplete>
        </span>
      </div>
    </div>
    
    <div v-if="answers.length>0" class="row">
      <div class="table">
      <h5 class="pt-3 row">{{$t('qas.answer')}}:</h5>

      <p class="row pl-2" v-for="answer in answers" :key="answer">
         {{ answer.answer}}</p>
      <div v-if="questions">
      <h5 class="pt-3 row">{{$t('qas.other')}}:</h5>

      <DataView :value="questions" paginator :rows="4">
        <template #list="slotProps">
          <div class="col-12">
            <h5><a href="#" @click.prevent="selectQuestion(slotProps.data.question)">{{slotProps.data.question}}</a></h5>
            <p class="truncate-text">{{ slotProps.data.answers[0].answer }}</p>
          </div>
        </template>
        
      </DataView>
    </div>
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
      currentRequest: null,
      previous: null,
    };
  },
  methods: {
    // Функция для вычисления расстояния Левенштейна между двумя строками
    levenshteinDistance(a, b) {
      if (a.length === 0) return b.length;
      if (b.length === 0) return a.length;

      const matrix = [];

      // Заполняем матрицу
      for (let i = 0; i <= b.length; i++) {
        matrix[i] = [i];
      }

      for (let j = 0; j <= a.length; j++) {
        matrix[0][j] = j;
      }

      for (let i = 1; i <= b.length; i++) {
        for (let j = 1; j <= a.length; j++) {
          const cost = a.charAt(j - 1) === b.charAt(i - 1) ? 0 : 1;
          matrix[i][j] = Math.min(
            matrix[i - 1][j] + 1,
            matrix[i][j - 1] + 1,
            matrix[i - 1][j - 1] + cost
          );
        }
      }

      return matrix[b.length][a.length];
    },
    async ask() {
      const response = await AhmetService.ask(this.question);
      console.log(response);
      this.answer = response.data;
    },
    async search(event) {

      let temp = this.items
      if (event.query === '') {
        let data = [];
          temp.forEach(element => {
          data.push(element + "");
        });        
        this.items =data;
      }

      else if (event.query.length>2) {
        if (this.currentRequest) {
          this.currentRequest.cancel();
        }
        this.answer = [];
        this.currentRequest = AhmetService.getQuestions(this.question, this.$route.params.id); 
        try {
          const response = await this.currentRequest.request;
          let data = [];
          
          response.data.data.forEach(element => {
            data.push(element.question);
          });
          if (data.length>0) {
            this.items = data;
            this.questions = response.data.data;
          } else {
            this.questions.sort((a,b)=>
              this.levenshteinDistance(a.question, this.question) - this.levenshteinDistance(b.question, this.question)
            );
            data = [];
            this.questions.forEach(element => {
              data.push(element.question+ "");
            });        
            this.items =data;
          }

        }
        catch (error) {
          console.log(error)
        }
    }
    },
    selectQuestion(question) {
      
      if (question.value == undefined) {
        this.question = question;
      }
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
.truncate-text {
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  display: -webkit-box;
  overflow: hidden;
}

</style>
