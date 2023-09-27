<template>
  <div :class="containerClass" @click="onWrapperClick">
    <AppTopBar @menu-toggle="onMenuToggle" />
    <div class="layout-sidebar" @click="onSidebarClick">
      <AppMenu :model="menu" @menuitem-click="onMenuItemClick" />
    </div>

    <div class="layout-main-container">
      <div class="layout-main">
        <router-view />
      </div>
      <AppFooter />
    </div>

    <AppConfig :layoutMode="layoutMode" @layout-change="onLayoutChange" />
    <transition name="layout-mask">
      <div
        class="layout-mask p-component-overlay"
        v-if="mobileMenuActive"
      ></div>
    </transition>
  </div>
</template>

<script>
import AppTopBar from "./AppTopbar.vue";
import AppMenu from "./AppMenu.vue";
import AppConfig from "./AppConfig.vue";
import AppFooter from "./AppFooter.vue";
import { useStore } from "vuex";

export default {
  emits: ["change-theme"],
  data() {
    return {
      layoutMode: "static",
      staticMenuInactive: false,
      overlayMenuActive: false,
      mobileMenuActive: false,
    };
  },
  watch: {
    $route() {
      this.menuActive = false;
      this.$toast.removeAllGroups();
    },
  },
  methods: {
    onWrapperClick() {
      if (!this.menuClick) {
        this.overlayMenuActive = false;
        this.mobileMenuActive = false;
      }

      this.menuClick = false;
    },
    onMenuToggle() {
      this.menuClick = true;

      if (this.isDesktop()) {
        if (this.layoutMode === "overlay") {
          if (this.mobileMenuActive === true) {
            this.overlayMenuActive = true;
          }

          this.overlayMenuActive = !this.overlayMenuActive;
          this.mobileMenuActive = false;
        } else if (this.layoutMode === "static") {
          this.staticMenuInactive = !this.staticMenuInactive;
        }
      } else {
        this.mobileMenuActive = !this.mobileMenuActive;
      }

      event.preventDefault();
    },
    onSidebarClick() {
      this.menuClick = true;
    },
    onMenuItemClick(event) {
      if (event.item && !event.item.items) {
        this.overlayMenuActive = false;
        this.mobileMenuActive = false;
      }
    },
    onLayoutChange(layoutMode) {
      this.layoutMode = layoutMode;
    },
    addClass(element, className) {
      if (element.classList) element.classList.add(className);
      else element.className += " " + className;
    },
    removeClass(element, className) {
      if (element.classList) element.classList.remove(className);
      else
        element.className = element.className.replace(
          new RegExp(
            "(^|\\b)" + className.split(" ").join("|") + "(\\b|$)",
            "gi"
          ),
          " "
        );
    },
    isDesktop() {
      return window.innerWidth >= 992;
    },
    isSidebarVisible() {
      if (this.isDesktop()) {
        if (this.layoutMode === "static") return !this.staticMenuInactive;
        else if (this.layoutMode === "overlay") return this.overlayMenuActive;
      }

      return true;
    },
  },
  computed: {
    isAdmin() {
      const temp = useStore().getters.isUserAdmin;
      return temp;
    },
    isUserExpert() {
      const temp = useStore().getters.isUserExpert;
      return temp;
    },
    menu() {
      return [
        {
          label: "Синонимайзер",
          icon: "pi pi-fw pi-home",
          items: [
            { label: "Синонимайзер", icon: "pi pi-cloud", to: "/synomizer" },
          ],
        },
        {
          label: "Админ",
          icon: "pi pi-fw pi-home",
          items: [
            { label: "Ұсыныстар", icon: "pi pi-user-plus", to: "/admin" },
            { label: "Панель", icon: "pi pi-th-large", to: "/adminpanel" },
            { label: "Теггер", icon: "pi pi-at", to: "/tagger" },
          ],
          visible: this.isAdmin || this.isUserExpert,
        },
        {
          label: "Анықтамалық",
          items: [
            { label: "Қазіргі қазақ тілінің грамматикасы", icon: "pi pi-fw pi-file", to: "/intelect/1" },
            {
              label: "Сұрақ-жауап жүйесі",
              icon: "pi pi-fw pi-star",
              to: "/answer/question/2",
            },
            {
              label: "Терминдері мен анықтамалары",
              icon: "pi pi-fw pi-list",
              to: "/terminology/2",
            },
            // {
            //   label: "Сөз синтезі",
            //   icon: "pi pi-forward",
            //   to: "/syntez",
            // },
            //{
            // label: "Корпус менеджер",
            // icon: "pi pi-folder-open",
            // to: "/corpusemanager",
            // visible: this.isAdmin || this.isUserExpert,
            // visible: true,
            // },
          ],
        },
        {
          label: "Сөздік",
          items: [
            {
              label: "Мектеп оқулықтары терминологиясы",
              icon: "pi pi-align-left",
              to: "/schoolterminology",
            },
            {
              label: "Бастауыш сынып оқулықтары терминологиясы",
              icon: "pi pi-align-left",
              to: "/childrenterminology",
            },
          ],
        },
        {
          label: "Интегралдық модел",
          items: [
            {
              label: "Корпус менеджер",
              icon: "pi pi-folder-open",
              to: "/corpusemanager",
              visible: this.isAdmin || this.isUserExpert,
              //visible: true,
            },
          ],
        },
        {
          label: "Мәтінді ойнату",
          items: [
            {
              label: "Сөз синтезі",
              icon: "pi pi-forward",
              to: "/syntez",
            },
          ],
        },
        {
          label: "Ахметтану",
          items: [
            {
              label: "Ғалым тұлғасы",
              icon: "pi pi-fw pi-align-justify",
              to: "/",
            },
            { label: "Мұрасы", icon: "pi pi-fw pi-briefcase", to: "/legacy" },
            { label: "Тіл-құрал", icon: "pi pi-fw pi-file", to: "/intelect/2" },
            {
              label: "Интеллектуалды жүйе",
              icon: "pi pi-fw pi-star",
              to: "/answer/question/1",
            },
            {
              label: "Терминдері мен анықтамалары",
              icon: "pi pi-fw pi-list",
              to: "/terminology/1",
            },
          ],
        },
        {
          label: "Ономастика",
        },
      ];
    },
    containerClass() {
      return [
        "layout-wrapper",
        {
          "layout-overlay": this.layoutMode === "overlay",
          "layout-static": this.layoutMode === "static",
          "layout-static-sidebar-inactive":
            this.staticMenuInactive && this.layoutMode === "static",
          "layout-overlay-sidebar-active":
            this.overlayMenuActive && this.layoutMode === "overlay",
          "layout-mobile-sidebar-active": this.mobileMenuActive,
          "p-input-filled": this.$primevue.config.inputStyle === "filled",
          "p-ripple-disabled": this.$primevue.config.ripple === false,
        },
      ];
    },
    logo() {
      return this.$appState.darkTheme
        ? "images/logo-white.svg"
        : "images/logo.svg";
    },
  },
  beforeUpdate() {
    if (this.mobileMenuActive)
      this.addClass(document.body, "body-overflow-hidden");
    else this.removeClass(document.body, "body-overflow-hidden");
  },
  components: {
    AppTopBar: AppTopBar,
    AppMenu: AppMenu,
    AppConfig: AppConfig,
    AppFooter: AppFooter,
  },
};
</script>

<style lang="scss">
@import "./App.scss";
</style>
