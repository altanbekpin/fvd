<template>
  <div
    class="card"
    style="
      display: flex;
      flex-direction: column;
      width: 100%;
      height: 40rem;
      align-self: center;
      align-items: center;
    "
  >
    <span style="font-size: 170%; font-weight: 500">Сұрақ-жауап жүйесі</span>
    <span
      class="text-blue-600"
      style="width: 70%; margin-top: 1%; font-weight: 700; font-size: 110%"
      >Қойылған сұраққа жауап Грамматика бойынша жаңа білім жүйесінен құралған
      онтологиялық модель негізінде орындалады</span
    >
    <div
      style="
        display: flex;
        flex-direction: row;
        height: 100%;
        width: 100%;
        align-items: center;
        align-self: center;
        margin-bottom: 0;
      "
    >
      <div
        style="display: flex; flex-direction: column; height: 45%; width: 50%"
      >
        <div
          class="card"
          style="
            height: 100%;
            width: 100%;
            padding: 0;
            margin-bottom: 0%;
            /* margin-top: 19%; */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-bottom: grey;
          "
        >
          <!-- Header for the first card -->
          <div
            class="card"
            style="
              background-color: #3498db;
              color: #fff;
              padding: 1rem;
              border-end-start-radius: 0;
              border-end-end-radius: 0;
              align-items: start;
              margin-bottom: 0;
            "
          >
            <span style="font-weight: bold; font-size: 100%">Сұрақ</span>
          </div>
          <Textarea
            v-model="question"
            class="custom-textarea"
            filled
            style="border: none; height: 80%; width: 100%; resize: none"
          />
        </div>
      </div>
      <div
        class="card"
        style="
          height: 45%;
          width: 50%;
          padding: 0;
          margin-left: 5%;
          margin-bottom: 0;
          box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          border-bottom: grey;
        "
      >
        <!-- Header for the second card -->
        <div
          class="card"
          style="
            background-color: #e74c3c;
            color: #fff;
            padding: 1rem;
            border-end-start-radius: 0;
            border-end-end-radius: 0;
            align-items: start;
            margin-bottom: 0;
          "
        >
          <span style="font-weight: bold; font-size: 100%">Жауап</span>
        </div>
        <Textarea
          v-model="answer"
          class="custom-textarea"
          filled
          style="
            border: none;
            height: 80%;
            width: 100%;
            resize: none;
            color: blue;
            font-weight: 700;
          "
          disabled
        />
      </div>
    </div>

    <Button
      label="Сұрау"
      icon="pi pi-send"
      style="height: 10%; width: 10%; min-width: 7rem; font-size: 90%"
      @click="ask"
    ></Button>
  </div>
</template>

<script>
import { AhmetService } from "../service/AhmetService";

export default {
  data() {
    return {
      question: "",
      answer: "",
    };
  },
  methods: {
    async ask() {
      const response = await AhmetService.ask(this.question);
      console.log(response);
      this.answer = response.data;
    },
  },
};
</script>
<style></style>
