<template>
  <div class="card bounder">
    <div class="row">
      <div style="font-size: 20px; margin-right: 450px; margin-left: 50px">
        Мәтін синомайзері
      </div>
    </div>
    <hr height="20px" />
    <div class="row">
      <WordSynomizer></WordSynomizer>
      <div
        class="card temp"
        style="width: 500px; height: 560px; position: relative"
      >
        <SynonymSearcher @custom-event="showDialog" />
      </div>
    </div>

    <div
      class="card temp-mobile"
      style="width: 500px; height: 560px; position: relative"
    >
      <SynonymSearcher @custom-event="showDialog" />
    </div>
    <Dialog
      v-model:visible="visible"
      modal
      header="Жаңа сөз қосу"
      :style="{ width: '50vw' }"
    >
      <div
        style="display: flex; flex-direction: column; align-items: flex-start"
      >
        <InputText
          type="text"
          v-model="inputValues"
          placeholder="Түбір сөзді жазыңыз"
          :style="{ width: '25vw' }"
          style="margin-bottom: 10px"
        ></InputText>
        <div style="margin-bottom: 10px">
          <Dropdown
            v-model="selectedFamily"
            :options="word_family"
            optionLabel="name"
            placeholder="Сөз табын таңдаңыз"
            class="w-full md:w-14rem"
          />
        </div>
        <InputText
          type="text"
          v-model="meaningInput"
          style="margin-bottom: 10px"
          placeholder="Мағынасын жазыңыз"
          :style="{ width: '25vw' }"
        ></InputText>
        <span style="color: grey; font-size: 13px">Синонимдер</span>
        <div style="max-width: 600px">
          <Chips v-model="synonymInput" separator="," />
        </div>
        <span style="color: grey; font-size: 13px">Перифразалар</span>
        <div style="max-width: 600px">
          <Chips v-model="paraphraseInput" separator="," />
        </div>
        <div style="margin-top: auto; align-self: flex-end">
          <Button
            label="Қосу"
            style="
              margin-right: 10px;
              position: absolute;
              bottom: 0;
              right: 0;
              margin-bottom: 10px;
            "
            @click="addWord"
          ></Button>
        </div>
      </div>
    </Dialog>
  </div>
</template>
<script setup>
import { ref } from "vue";
import axios from "axios";
import SynonymSearcher from "./components/SynonymSearcher.vue";
import WordSynomizer from "./components/WordSynomizer.vue";

// import WordSynomizer from "./components/WordSynomizer.vue";
const selectedWord = ref();
const inputValues = ref([]);
const word = ref("");
const inputWords = ref("");
const meaning = ref("");
const showSynAdd = ref(false);
// const synomized_words = ref('')
const synomized_words = ref();
// const handleClick = (event) => {
//   // Call your desired function here
//   console.log("Span clicked!");
//   // }
//   toggle(event);
// };
// eslint-disable-next-line no-unused-vars
const onSearchTap = async () => {
  console.log("onSearchTap");
  const selectedItem = ref({ family: "" });
  selectedItem.value["family"];
  const synWasFound = await handleSelection(selectedItem);
  if (synWasFound) {
    console.log("showSynAdd.value: ", showSynAdd.value);
    showSynAdd.value = false;
  }
  inputValues.value = word.value;
  showSynAdd.value = true;
  console.log("showSynAdd.value: ", showSynAdd.value);
  return;
};
// eslint-disable-next-line no-unused-vars
const onSynonymTap = async () => {
  console.log(optionSynonyms.value);
  console.log("selectedSyn.value: ", selectedSyn.value);
  const dataValue = targetRef.value.getAttribute("data");
  console.log("dataValue: ", dataValue);
  console.log("selectedSyn.value: ", selectedSyn.value.synonym);
  targetRef.value.innerText = selectedSyn.value.synonym;
  // closeOverlayPanel();
};
// const op = ref();
// const ref_event = ref();
// const toggle = (event) => {
//   ref_event.value = event.target;
//   console.log("toggle: ", ref_event.value);
//   op.value.toggle(event);
// };
// const targetHref = 'сайлау';
const visible = ref(false);
// eslint-disable-next-line no-unused-vars
const families = ref([
  { family: "етістік" },
  { family: "зат есім" },
  { family: "сын есім" },
  { family: "сан есім" },
]);

const selectedSyn = ref();
const optionSynonyms = ref([{ synonym: "синоним жоқ", words: "" }]);
console.log(optionSynonyms.value);

// const closeOverlayPanel = () => {
//   op.value.hide();
// };

const handleSelection = async (selectedItem) => {
  console.log("Selected item:", selectedItem.value["family"]);
  const event = {
    target: {
      value: word.value,
    },
  };
  return await onChange(event, selectedItem.value["family"]);
};
const targetRef = ref(null);
// eslint-disable-next-line no-unused-vars
// const handleLineClick = async (e) => {
//   let clickedElHref = e.target.getAttribute("href");
//   let clickedElId = e.target.id;
//   let clickkedRef = e.target.getAttribute("second_part");
//   const target = e.target;
//   if (target.tagName === "SPAN") {
//     targetRef.value = target;
//   }
//   if (clickedElId === "temp_testing_div2") {
//     handleClick(e);
//     console.log("temp_testing_div2 clicked!", clickedElHref);
//     await axios
//       .post("http://localhost:5001/search/synonyms/only", {
//         value: clickedElHref,
//         second_part: clickkedRef,
//       })
//       .then((response) => {
//         optionSynonyms.value = response.data;
//       });
//   } else {
//     console.log("another element was clicked");
//   }
// };

document.addEventListener("click", function (event) {
  console.log("tapped");
  var listBox = document.querySelector(".listbox"); // Select the ListBox element

  // Check if the click event occurred outside the ListBox
  if (listBox && !listBox.contains(event.target)) {
    listBox.style.display = "none"; // Hide the ListBox
  }
});
// eslint-disable-next-line no-unused-vars
const send_to_synomize = async () => {
  await axios
    .post("http://localhost:5001/search/word/", { value: inputWords.value })
    .then((response) => {
      console.log(response);
      synomized_words.value = response.data[0];
      synomized_counter.value = response.data[1];
    });
};
// eslint-disable-next-line no-unused-vars
const onSelectionChange = () => {
  console.log("selectedWord.value.name: ", selectedWord.value.words);
  word.value = selectedWord.value.words;
  const event = {
    target: {
      value: word.value,
    },
  };
  onChange(event, "");
};
const selectedFamily = ref();
const word_family = ref([
  { name: "зат есім", code: 1 },
  { name: "сын есім", code: 2 },
  { name: "сан есім", code: 3 },
  { name: "етістік", code: 4 },
  { name: "еліктеуіш", code: 5 },
  { name: "одағай", code: 6 },
  { name: "шылау", code: 7 },
  { name: "үстеу", code: 8 },
]);
const synonymInput = ref("");
const paraphraseInput = ref("");
const meaningInput = ref("");
const synomized_counter = ref("0");
const words = ref("");
const family = ref();
const synonyms = ref([{ synonym: "Табылмады" }]);
const paraphrases = ref([{ paraphrase: "Табылмады" }]);
const word_id = ref("");
const all_words = ref();
const onChange = async (event, words_family) => {
  var response = {};
  try {
    await axios
      .post("http://localhost:5001/word/synomize/", {
        value: event.target.value,
        words_family: words_family,
      })
      .then((_) => console.log((response = _.data)));
  } catch (error) {
    response = null;
  }
  console.log(event.target.value);
  console.log("response word in console: ", response);
  if (response != null) {
    showSynAdd.value = false;
    meaning.value = response[0]["meaning"];
    word_id.value = response[0]["id"];
    family.value = { family: response[0]["words_family"] };
    words.value = response[0]["words"];
    synonyms.value = response[1];
    paraphrases.value = response[2];
    all_words.value = response[3];
    console.log("family.value: ", family.value);
    return true;
  } else {
    console.log("NULL");
    meaning.value = "";
    return false;
  }
};
// eslint-disable-next-line no-unused-vars
const showDialog = (data) => {
  inputValues.value = data;
  visible.value = !visible.value;
};
const addWord = () => {
  console.log("synonymInput.value: ", synonymInput.value);
  console.log("inputValues.value: ", inputValues.value);
  console.log("meaningInput.value: ", meaningInput.value);
  console.log("selectedFamily.value: ", selectedFamily.value);
  if (
    synonymInput.value != "" &&
    inputValues.value != "" &&
    meaningInput.value != "" &&
    (selectedFamily.value != "" || paraphraseInput.value != "")
  ) {
    axios.post("http://localhost:5001/add/word/", {
      synonyms: synonymInput.value,
      word: inputValues.value,
      meaning: meaningInput.value,
      family: selectedFamily.value,
      paraphrases: paraphraseInput.value,
    });
    synonymInput.value = "";
    inputValues.value = "";
    meaningInput.value = "";
    selectedFamily.value = "";
    paraphraseInput.value = "";
  }
};
</script>
<style setup>
.card-container {
  height: 300px; /* Set the desired height for the container */
  /* Enable vertical scrolling */
}
.row {
  display: flex;
  align-items: center;
}
.row div {
  margin-right: 10px;
}
.texts {
  font-size: 10px;
  margin-top: 10px;
}
.rowMain {
  display: flex;
  align-items: center;
}
.temp-mobile {
  display: none;
}
/* .card ::v-deep .swticher {
  background-color: #324068;
  border-color: #324068;
} */
/* .dropDown{
    align-items: center;
} */
.dropDown {
  border-radius: 100px;
}
.bounder {
  /* //align-items: center; */
  height: 700px;
}
/* Define the breakpoint where the menu will appear below the body */
@media screen and (max-width: 1400px) {
  /* Hide the menu when the screen width is greater than or equal to the breakpoint */
  .temp {
    display: none;
  }
  .bounder {
    height: 1300px;
  }
  .temp-mobile {
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
