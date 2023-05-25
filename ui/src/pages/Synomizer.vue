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
                            <div>Ауыстырылған сөздер саны = {{ synomized_counter }}</div>
                            <Button label="Өңдеу" style="margin-left: 80px;" @click="send_to_synomize"/>
                    </div>                    
                    <div class="card" style="width: 450px; margin-top: 10px; margin-bottom:10px; height: 130px">
                        <div v-html="synomized_words" style="width: 420px;overflow: auto; height: 112px;  padding-right: 10px;" @click="handleLineClick"></div>
                        <div class="border">
                            <OverlayPanel ref="op" style="border: none; padding: 0;">
                                <div class="border-inner">
                                <Listbox v-model="selectedSyn" :options="optionSynonyms" optionLabel="synonym" class="w-full" style="border: none; margin: 0;" />
                                </div>
                            </OverlayPanel>
                        </div>
                    </div>
                </div>
                </div>
                <div class="card temp"  style="width: 500px; height: 560px; position: relative;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <div style="position: relative;">
                             <InputText type="text" v-model="word" style="width: 230px;" @input="onChange($event, '')" />
                            <div v-if="synonyms.length > 1" ref="listbox">
                                <div style="position: absolute; top: 100%; width: 230px; z-index: 2;">
                                    <div class="listbox">
                                        <Listbox v-model="selectedWord" :options="all_words" optionLabel="words" class="w-full md:w-14rem" @change="onSelectionChange"/>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                        <Listbox v-model="family" :options="families" optionLabel="family"  class="w-full md:w-14rem"  style="margin-left: 26.5px; z-index: 1;" listStyle="max-height:100px" @change="handleSelection"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Синонимдері: 
                        </div>
                        <Listbox v-model="j" :options="synonyms" optionLabel="synonym" class="w-full md:w-14rem" listStyle="max-height:100px" style="z-index: 1;"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Перифраза: 
                        </div>
                        <Listbox v-model="j" :options="paraphrases" optionLabel="paraphrase" class="w-full md:w-14rem" style="margin-left: 10px;z-index: 1;" listStyle="max-height:100px"/>
                    </div>
                    <Button label="Жаңа синоним қосу" style="position: absolute; bottom: 0; right: 0; margin-right: 10px; margin-bottom: 10px;" @click=showDialog></Button>
                    </div>
                </div>
            </div>
            <div class="card temp-mobile" style="width: 500px; height: 560px; position: relative;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <div style="position: relative;">
                             <InputText type="text" v-model="word" style="width: 230px;" @input="onChange($event, '')" />
                            <div v-if="synonyms.length > 1" ref="listbox">
                                <div style="position: absolute; top: 100%; width: 230px; z-index: 2;">
                                    <div class="listbox">
                                        <Listbox v-model="selectedWord" :options="all_words" optionLabel="words" class="w-full md:w-14rem" @change="onSelectionChange"/>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                        <Listbox v-model="family" :options="families" optionLabel="family"  class="w-full md:w-14rem"  style="margin-left: 26.5px;" listStyle="max-height:100px" @change="handleSelection"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            синонимдері: 
                        </div>
                        <Listbox v-model="j" :options="synonyms" optionLabel="synonym" class="w-full md:w-14rem" listStyle="max-height:100px"/>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div>
                            Перифраза: 
                        </div>
                        <Listbox v-model="j" :options="paraphrases" optionLabel="paraphrase" class="w-full md:w-14rem" style="margin-left: 10px;" listStyle="max-height:100px"/>
                    </div>
                    <Button label="Жаңа сөз қосу" style="position: absolute; bottom: 0; right: 0; margin-right: 10px; margin-bottom: 10px;" @click=showDialog></Button>
                    </div>
                </div>
                <Dialog v-model:visible="visible" modal header="Жаңа синоним қосу" :style="{ width: '50vw' }">
  <div style="display: flex; flex-direction: column; align-items: flex-start;">
    <InputText type="text" v-model="inputValues" placeholder="Түбір сөзді жазыңыз" :style="{ width: '25vw' }" style="margin-bottom: 10px;"></InputText>
    <div style=" margin-bottom: 10px;">
      <Dropdown v-model="selectedFamily" :options="word_family" optionLabel="name" placeholder="Сөз табын таңдаңыз" class="w-full md:w-14rem" />
    </div>
    <InputText type="text" v-model="meaningInput" style="margin-bottom: 10px;" placeholder="Мағынасын жазыңыз" :style="{ width: '25vw'}"></InputText>
        <div style="max-width: 600px;">
            <Chips v-model="synonymInput" separator="," />
        </div>


    <div style="margin-top: auto; align-self: flex-end;">
        <Button label="Қосу" style="margin-right: 10px; position: absolute; bottom: 0; right: 0; margin-bottom: 10px;" @click="addSynonym"></Button>
    </div>
    
  </div>
</Dialog>


            </div>
</template>
<script setup>
import { ref} from 'vue';
import axios from 'axios'
const selectedWord = ref()
const inputValues = ref([])
const word = ref('');
const inputWords = ref('');
const meaning = ref('');
// const synomized_words = ref('')
const synomized_words = ref();
const handleClick = (event) => {
  // Call your desired function here
  console.log('Span clicked!');
  toggle(event)
};

// onMounted(() => {
//   const spanElement = document.querySelector('[ref="dyncont"]');
//   spanElement.addEventListener('click', handleClick);
// });
const op = ref();
const toggle = (event) => {
    op.value.toggle(event);
}


const visible = ref(false)
const families = ref([
    {family: 'етістік'},
    {family: 'зат есім'},
    {family: 'сын есім'},
    {family: 'сан есім'}
])

const selectedSyn = ref();
const optionSynonyms = ref([
    { synonym: 'синоним жоқ', words: ''}
]);
console.log(optionSynonyms.value)

const handleSelection = async(selectedItem)=>{
    console.log("Selected item:", selectedItem.value['family']);
    const event = {
        target: {
            value: word.value
        }
    } 
    await onChange(event, selectedItem.value['family'])
}
// const op = ref();
// const toggle = (event) => {
//     op.value.toggle(event);
// }

const handleLineClick = async (e)=> {
    let clickedElHref = e.target.getAttribute('href');
    let clickedElId = e.target.id
    if (clickedElId === 'temp_testing_div2') {
        handleClick(e)
      console.log("temp_testing_div2 clicked!", clickedElHref)
      await axios.post("http://127.0.0.1:5001/search/synonyms/only", {"value":clickedElHref}).then(response => { optionSynonyms.value = response.data; console.log(optionSynonyms.value)})
    } else {
      console.log('another element was clicked')
    }
  }
// Add event listener to the document
document.addEventListener('click', function(event) {
    console.log("tapped")
  var listBox = document.querySelector('.listbox'); // Select the ListBox element

  // Check if the click event occurred outside the ListBox
  if (listBox && !listBox.contains(event.target)) {
    listBox.style.display = 'none'; // Hide the ListBox
  }
});


const send_to_synomize = async()=>{
    await axios.post('http://127.0.0.1:5001/search/word/', {'value' : inputWords.value}).then(response =>{console.log(response); synomized_words.value=response.data[0]; synomized_counter.value = response.data[1]})
   
}
const onSelectionChange = ()=>{
    console.log("selectedWord.value.name: ", selectedWord.value.words)
    word.value = selectedWord.value.words
    const event = {
        target: {
            value: word.value
        }
    } 
    onChange(
            event, ''
        
    )
}
const selectedFamily = ref();
const word_family = ref([
    { name: 'зат есім', code: 1 },
    { name: 'сын есім', code: 2 },
    { name: 'сан есім', code: 3 },
    { name: 'етістік', code: 4 },
    { name: 'еліктеуіш', code: 5},
    { name: 'одағай', code: 6},
    { name: 'шылау', code: 7},
    { name: 'үстеу', code: 8}
]);
const synonymInput = ref('')
const meaningInput = ref('')
const synomized_counter = ref('0')
const words = ref('')
const family = ref()
const synonyms = ref([{synonym: 'Табылмады'}])
const paraphrases = ref([{paraphrase: 'Табылмады'}])
const word_id = ref('')
const all_words = ref()
// const highlightMatchingWords = (synomizedWords)=> {
//     const matchingWords = synomized.value; // Replace with your list of matching words
//     const words = synomizedWords.split(" ");
    
//     const highlightedWords = words.map((word) => {
//       if (matchingWords.includes(word)) {
//         return `<span style="color: green;">${word}</span>`;
//       }
//       return word;
//     });
    
//     return highlightedWords.join(" ");
//   }
const onChange = async(event, words_family)=>{
    var response = {};
    await axios.post('http://127.0.0.1:5001/word/synomize/', {'value': event.target.value, 'words_family' : words_family}).then(_ => console.log(response = _.data))
    console.log(event.target.value)
    console.log('response word in console: ',response)
    if(response != null){
        meaning.value = response[0]['meaning']
        word_id.value = response[0]['id']
        family.value = {family: response[0]['words_family']}
        words.value = response[0]['words']
        synonyms.value = response[1]    
        paraphrases.value = response[2]
        all_words.value = response[3]
        console.log('family.value: ', family.value)
    }else{
        console.log("NULL")
        meaning.value = ''
    }
}

const showDialog = ()=>{
    visible.value = !visible.value;
}
const addSynonym = ()=>{
    console.log('synonymInput.value: ', synonymInput.value)
    console.log('inputValues.value: ',inputValues.value)
    console.log('meaningInput.value: ', meaningInput.value)
    console.log('selectedFamily.value: ', selectedFamily.value)
    if(synonymInput.value != '' && inputValues.value != '' && meaningInput.value != '' && selectedFamily.value != ''){
        axios.post('http://127.0.0.1:5001/add/synonym/',{'synonyms': synonymInput.value, 'word' :inputValues.value, 'meaning' : meaningInput.value, 'family' : selectedFamily.value})
    }
    // if(synonymInput.value == ''){
    //     return;
    // }
    // axios.post('http://127.0.0.1:5001/add/synonym/', {'synonym': synonymInput.value, 'word_id':word_id.value})
}
</script>
<style setup>
.card-container {
  height: 300px; /* Set the desired height for the container */
   /* Enable vertical scrolling */
}
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
  .highlight {
    color: green;
  }
}
.border {
  border: 1px solid #ccc;
  border-radius: 4px;
}

.border-inner {
  border: none;
  margin: 0;
  padding: 0;
}

</style>