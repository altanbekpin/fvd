<template>
  <li>
    <!-- <font-awesome-icon icon="folder" /> -->
    <div
      class="folder item"
      :class="{ bold: isFolder }"
      @click="toggle"
      @dblclick="changeType"
    >
      {{ model.name }}
      <span v-if="isFolder">[{{ isOpen ? "-" : "+" }}]</span>
    </div>
    <ul v-show="isOpen" v-if="isFolder" style="list-style: none">
      <!--
        A component can recursively render itself using its
        "name" option (inferred from filename if using SFC)
      -->
      <folder-item
        class="item"
        v-for="model in model.children"
        :key="model.name"
        :model="model"
      >
      </folder-item>
      <!--
      <li class="add" @click="addChild">+</li>
      -->
    </ul>
  </li>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  name: "FolderItem",
  props: {
    model: Object,
  },
  data() {
    return {
      isOpen: false,
    };
  },
  mounted() {
    // this.toggle();
  },
  computed: {
    isFolder() {
      //return true
      return this.model.children && this.model.children.length;
    },
    ...mapState(["root_folder"]),
  },
  methods: {
    ...mapActions([
      "setRootFolder", // map `this.setRootFolder()` to `this.$store.dispatch('SET_ROOT_FOLDER')`
    ]),

    toggle() {
      this.isOpen = !this.isOpen;
      console.log("clicked folder:", this.model.path);
      console.log("toggel was clicked");
      this.setRootFolder(this.model.path);
    },

    changeType() {
      /*
      if (!this.isFolder) {
        this.model.children = []
        this.addChild()
        this.isOpen = true
      }
      */
    },

    addChild() {
      //this.model.children.push({ name: 'new folder' })
    },
  },
};
</script>

<style>
.folder {
  display: inline-block;
  padding-left: 0.5rem;
}
.item {
  cursor: pointer;
  line-height: 1.5;
}
.bold {
  font-weight: bold;
}
</style>
