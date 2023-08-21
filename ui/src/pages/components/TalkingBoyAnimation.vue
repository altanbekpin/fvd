<template>
  <div class="lottie-container" ref="lottieContainer"></div>
</template>

<script>
import lottie from "lottie-web";
import animationData from "../../assets/talking_boy.json"

export default {
  name: "TalkingBoyAnimation",
  async mounted() {


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
  
};
</script>

<style>
.lottie-container {
  height: 600px;
}
</style>
