<template>
  <div class="lottie-container" ref="lottieContainer"></div>
</template>

<script>
import lottie from "lottie-web";
import animationData1 from "@/assets/animation.json";
import animationData2 from "@/assets/animation2.json";
import animationData3 from "@/assets/animation_lktfimbc.json"; // Make sure this is the correct path

export default {
  async mounted() {
    // console.log("ANIMATIOOOOOON");
    const animationModules = [animationData1, animationData2, animationData3];

    const animationData = this.getRandomElementFromArray(animationModules);

    try {
      lottie.loadAnimation({
        container: this.$refs.lottieContainer,
        renderer: "svg",
        loop: true,
        autoplay: true,
        animationData,
      });
    } catch (error) {
      console.error("Error loading Lottie animation:", error);
    }
  },
  methods: {
    getRandomElementFromArray(array) {
      const randomIndex = Math.floor(Math.random() * array.length);
      return array[randomIndex];
    },
  },
};
</script>

<style>
.lottie-container {
  height: 600px;
}
</style>
