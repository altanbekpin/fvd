<template>
        <div class="card bounder">
            <div class="row">
                <div style="font-size: 20px; margin-right: 450px; margin-left: 50px;">Мәтін синомайзері</div>
            </div>
            <hr height="20px">
            <div class="row">
                <div>
                    <div style="font-size: 12px; width: 500px;">
                        Мәтін синонимайзері қазақ тілінде енгізілген мәтіндегі сөздерді синонимдермен алмастыруға көмектеседі. Мәтіндегі сөз синонимдермен ауыстырылса жасыл түспен белгіленіп көрсетіледі. Синонимайзер арқылы өнделген мәтінге семантикасына қарай өзгеріс енгізу мүмкіндігі бар, ол үшін белгіленген сөздің үстінен басып, көрсетілген синонимдер ішінен мағынасына сай сөзді таңдап, түзете аласыз
                    </div>
                    <div class="card main-card" style="width: 500px; height: 500px; margin-top: 20px;">
                        <Textarea rows="15" cols="55" v-model="inputWords"/>
                        <div class="row texts" style="margin-top: 30px;">
                            <div>Символдар саны = {{ inputWords.length }}</div>
                            <div>Ауыстырылған сөздер саны = 0</div>
                            <Button label="Өңдеу" style="margin-left: 80px;"/>
                    </div>
                    <Textarea style="width: 446px; height: 112px; margin-top: 20px;" readonly="true"/>
                </div>

                </div>
                <div class="card temp" style="width: 500px; height: 560px;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <InputText type="text" v-model="word" style="width: 230px;"  @input="onChange"/>
                        <!-- <Listbox v-model="selectedCity" :options="cities" filter optionLabel="name" class="w-full md:w-14rem" /> -->
                        <Button label="Іздеу" style="margin-left: 20px;" ></Button>
                    </div>
                    <div v-if="word.valueOf() != '' && meaning.valueOf() != ''" style="padding-top: 20px;">
                    <div>
                        Сөз: {{ words.valueOf() }}
                    </div>
                    <div style="margin-bottom: 10px;">
                        Түсіндірмесі: {{ meaning }}
                    </div>
                    <div class="row">
                        <div>
                            Сөз табы:
                        </div>
                        <Listbox v-model="family" :options="families" optionLabel="family" class="w-full md:w-14rem" style="margin-left: 26.5px;"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Синонимдері: 
                        </div>
                        <Listbox v-model="j" :options="synonyms" optionLabel="synonym" class="w-full md:w-14rem" />
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Перифраза: 
                        </div>
                        <Listbox v-model="j" :options="paraphrases" optionLabel="paraphrase" class="w-full md:w-14rem" style="margin-left: 10px;"/>
                    </div>
                    </div>
                </div>
            </div>
            <div class="card temp-mobile" style="width: 500px; height: 560px;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <InputText type="text" v-model="word" style="width: 230px;" @input="onChange"/>
                        <!-- <Listbox v-model="selectedCity" :options="cities" filter optionLabel="name" class="w-full md:w-14rem" /> -->
                        <Button label="Іздеу" style="margin-left: 20px;" ></Button>
                    </div>
                    <div v-if="word.valueOf() != '' && meaning.valueOf() != '' " style="padding-top: 20px;">
                    <div>
                        Сөз: {{ words.valueOf() }}
                    </div>
                    <div style="margin-bottom: 10px;">
                        Түсіндірмесі: {{ meaning }}
                    </div>
                    <div class="row">
                        <div>
                            Сөз табы:
                        </div>
                        <Listbox v-model="family" :options="families" optionLabel="family" class="w-full md:w-14rem" style="margin-left: 26.5px;"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            синонимдері: 
                        </div>
                        <Listbox v-model="j" :options="synonyms" optionLabel="synonym" class="w-full md:w-14rem" />
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Перифраза: 
                        </div>
                        <Listbox v-model="j" :options="paraphrases" optionLabel="paraphrase" class="w-full md:w-14rem" style="margin-left: 10px;"/>
                    </div>
                    </div>
                </div>
            </div>
</template>
<script setup>
import { ref, } from 'vue';
import axios from 'axios'
const word = ref('');
const inputWords = ref('');
const meaning = ref('')
const families = ref([
    {family: 'етістік'},
    {family: 'зат есім'},
    {family: 'сын есім'},
    {family: 'сан есім'}
])
const words = ref('')
const family = ref({family: 'зат есім'})
const synonyms = ref([{synonym: 'Табылмады'}])
const paraphrases = ref([{paraphrase: 'Табылмады'}])
const onChange = async(event)=>{
    var response = {};
    await axios.post('http://127.0.0.1:5001/word/synomize/', {'value': event.target.value}).then(_ => console.log(response = _.data))
    console.log(event.target.value)
    if(response != null){
        meaning.value = response[0]['meaning']
        family.value = {family: response[0]['words_family']}
        words.value = response[0]['words']
        synonyms.value = response[1]
        paraphrases.value = response[2]
        console.log('paraphrases: ', paraphrases.value)
    }else{
        console.log("NULL")
        meaning.value = ''
    }
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
.texts{
    font-size: 10px;
    margin-top: 10px;
    
}
.rowMain{
    display: flex;
  align-items: center;
}
.temp-mobile{
    display: none;
}
/* .card ::v-deep .swticher {
  background-color: #324068;
  border-color: #324068;
} */
/* .dropDown{
    align-items: center;
} */
.dropDown{
    border-radius: 100px;
}
.bounder{
    /* //align-items: center; */
    height: 700px;
}
  /* Define the breakpoint where the menu will appear below the body */
  @media screen and (max-width: 1400px) {
  /* Hide the menu when the screen width is greater than or equal to the breakpoint */
  .temp {
    display: none;
  }
  .bounder{
    height: 1300px;
  }
  .temp-mobile{
    display: block;
  }
}
</style>