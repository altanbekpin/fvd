<template>
  <div>
    <div>
      <Textarea rows="15" cols="55" v-model="inputWords" style="width: 100%" />
      <div class="row texts" style="margin-top: 30px">
        <div>Символдар саны = {{ inputWords.length }}</div>
        <div>Ауыстырылған сөздер саны = {{ synomized_counter }}</div>
        <Button
          label="Өңдеу"
          style="margin-left: 80px"
          @click="send_to_synomize"
        />
      </div>
      <div
        class="card"
        style="
          width: 100%;
          margin-top: 10px;
          margin-bottom: 10px;
          overflow: hidden;
          height: 130px;
          max-height: 130px;
          padding-bottom: 40px;
        "
      >
        <div
          style="
            width: 100%;
            overflow-y: auto;
            padding-right: 10px;
            max-height: 100px;
            height: 100px;
          "
        >
          <div class="word-container">
            <span v-for="(word, index) in synomized_words" :key="index">
              <span
                v-if="isHtml(word)"
                v-html="word"
                @click="handleLineClick"
              ></span>
              <span v-else>{{ word }}</span>
            </span>
          </div>

          <OverlayPanel
            ref="op"
            style="border: none; padding: 0"
            v-if="synomized_counter != 0"
            :appendTo="'span#span-2.temp_testing_div2'"
          >
            <div class="border-inner">
              <Listbox
                v-model="selectedSyn"
                :options="optionSynonyms"
                optionLabel="synonym"
                class="w-full"
                style="
                  border: none;
                  margin: 0;
                  max-height: 80px;
                  overflow-y: auto;
                "
                @change="onSynonymTap"
              />
            </div>
          </OverlayPanel>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import { AHMET_API, getHeader } from "../../config";

export default {
  data() {
    return {
      overlayService: null,
      inputWords: "",
      synomized_counter: 0,
      synomized_words: [],
      optionSynonyms: [{ synonym: "синоним жоқ", words: "" }],
      selectedSyn: null,
      overlayTarget: null,
      clickedElHref: "",
    };
  },

  methods: {
    async send_to_synomize() {
      await axios
        .post(
          `${AHMET_API}/search/word/`,
          {
            value: this.inputWords,
          },
          { headers: getHeader() }
        )
        .then((response) => {
          console.log(response);
          this.synomized_words = response.data[0];
          this.synomized_counter = response.data[1];
        });
    },
    async handleLineClick(e) {
      this.clickedElHref = e.target.getAttribute("href");
      const clickedElClass = e.target.getAttribute("class");
      const clickkedRef = e.target.getAttribute("second_part");
      const family = e.target.getAttribute("family");
      const target = e.target;

      if (target.tagName === "SPAN") {
        this.overlayTarget = target;
      }
      if (clickedElClass === "temp_testing_div2") {
        const dataValue = e.target.getAttribute("id");
        console.log("dataValue: ", dataValue);
        console.log("overlayTarget:", this.overlayTarget);
        this.handleClick(e);
        console.log("temp_testing_div2 clicked!", this.clickedElHref);
        console.log("clickkedRef:", clickkedRef);
        console.log("family:", family);
        this.optionSynonyms = [
          {
            synonym: this.clickedElHref,
            words: this.clickedElHref,
          },
        ];
        await axios
          .post(
            `${AHMET_API}/search/synonyms/only`,
            {
              value: this.clickedElHref,
              second_part: clickkedRef,
              family: family,
            },
            { headers: getHeader() }
          )
          .then((response) => {
            this.optionSynonyms = response.data;
          });
        // this.optionSynonyms = this.clearArray(this.optionSynonyms);
        console.log("this.optionSynonyms:", this.optionSynonyms);
      } else {
        console.log("another element was clicked");
      }
    },
    handleClick(event) {
      console.log("Span clicked!");
      this.toggle(event);
    },
    toggle(event) {
      console.log("toggle: ", event.target);
      this.$refs.op.toggle(event);
    },
    onSynonymTap() {
      console.log(this.optionSynonyms);
      console.log("selectedSyn: ", this.selectedSyn);
      const dataValue = this.overlayTarget.getAttribute("data");
      console.log("dataValue: ", dataValue);
      console.log("selectedSyn: ", this.selectedSyn.synonym);
      this.overlayTarget.innerText = this.selectedSyn.synonym;
      this.closeOverlayPanel();
    },
    closeOverlayPanel() {
      this.$refs.op.hide();
    },

    // showOverlayPanel() {
    //   const overlayContainer = this.$refs.overlayContainer;

    //   if (!this.overlayVisible) {
    //     const overlayPanelComponent = new Vue(OverlayPanel);
    //     overlayPanelComponent.$mount();
    //     overlayContainer.appendChild(overlayPanelComponent.$el);
    //   } else {
    //     overlayContainer.innerHTML = "";
    //   }

    //   this.overlayVisible = !this.overlayVisible;
    // },
  },
  computed: {
    isHtml() {
      return function (word) {
        const parser = new DOMParser();
        const parsedHtml = parser.parseFromString(word, "text/html");
        return parsedHtml.body.childNodes.length !== 0;
      };
    },
  },
};
// :appendTo="overlayTarget"
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
.dropDown {
  border-radius: 100px;
}
.bounder {
  /* //align-items: center; */
  height: 700px;
}
</style>
