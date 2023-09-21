<template>
  <div class="layout-menu-container">
    <AppSubmenu
      :items="model"
      class="layout-menu"
      :root="true"
      @menuitem-click="onMenuItemClick"
      @keydown="onKeyDown"
    />
  </div>
</template>
<script>
import AppSubmenu from "./AppSubmenu";
export default {
  props: {
    model: Array,
  },
  methods: {
    navigateToHome() {
      // Use Vue Router to navigate to the "/" route
      this.$router.push("/intagrationmodel");
    },
    onMenuItemClick(event) {
      this.$emit("menuitem-click", event);
    },
    onKeyDown(event) {
      const nodeElement = event.target;
      if (event.code === "Enter" || event.code === "Space") {
        nodeElement.click();
        event.preventDefault();
      }
    },
    bannerImage() {
      return this.$appState.darkTheme
        ? "images/banner-primeblocks-dark.png"
        : "images/banner-primeblocks.png";
    },
  },
  computed: {
    darkTheme() {
      return this.$appState.darkTheme;
    },
  },
  components: {
    AppSubmenu: AppSubmenu,
  },
  mounted() {
    // Find the element by its aria-label attribute
    const element = document.querySelector('[aria-label="Интегралдық модел"]');

    // Check if the element exists
    if (element) {
      // Attach a click event listener
      element.addEventListener("click", this.navigateToHome);
    }
  },
};
</script>
