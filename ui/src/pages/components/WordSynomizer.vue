<template>
  <div>
    <div>
      <div style="font-size: 12px; width: 500px">
        Мәтін синонимайзері қазақ тілінде енгізілген мәтіндегі сөздерді
        синонимдермен алмастыруға көмектеседі. Мәтіндегі сөз синонимдермен
        ауыстырылса жасыл түспен белгіленіп көрсетіледі. Синонимайзер арқылы
        өнделген мәтінге семантикасына қарай өзгеріс енгізу мүмкіндігі бар, ол
        үшін белгіленген сөздің үстінен басып, көрсетілген синонимдер ішінен
        мағынасына сай сөзді таңдап, түзете аласыз
      </div>
      <div
        class="card main-card"
        style="width: 500px; height: 500px; margin-top: 20px"
      >
        <Textarea rows="15" cols="55" v-model="inputWords" />
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
            width: 450px;
            margin-top: 10px;
            margin-bottom: 10px;
            height: 130px;
          "
        >
          <div
            style="
              width: 420px;
              overflow: auto;
              height: 112px;
              padding-right: 10px;
            "
            @click="handleLineClick"
          >
            <div v-html="synomized_words"></div>
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
  </div>
</template>
<script>
import axios from "axios";

export default {
  data() {
    return {
      overlayService: null,
      inputWords: "",
      synomized_counter: 0,
      synomized_words: null,
      optionSynonyms: [{ synonym: "синоним жоқ", words: "" }],
      selectedSyn: null,
      overlayTarget: null,
    };
  },
  methods: {
    async send_to_synomize() {
      await axios
        .post("http://127.0.0.1:5001/search/word/", { value: this.inputWords })
        .then((response) => {
          console.log(response);
          this.synomized_words = response.data[0];
          this.synomized_counter = response.data[1];
        });
    },
    async handleLineClick(e) {
      const clickedElHref = e.target.getAttribute("href");
      const clickedElClass = e.target.getAttribute("class");
      const clickkedRef = e.target.getAttribute("second_part");
      const target = e.target;

      if (target.tagName === "SPAN") {
        this.overlayTarget = target;
      }
      if (clickedElClass === "temp_testing_div2") {
        const dataValue = e.target.getAttribute("id");
        console.log("dataValue: ", dataValue);
        console.log("overlayTarget:", this.overlayTarget);
        this.handleClick(e);
        console.log("temp_testing_div2 clicked!", clickedElHref);
        await axios
          .post("http://127.0.0.1:5001/search/synonyms/only", {
            value: clickedElHref,
            second_part: clickkedRef,
          })
          .then((response) => {
            this.optionSynonyms = response.data;
          });
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
    toggle2(event) {
      this.$refs.overlayPanel.toggle(event);
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
