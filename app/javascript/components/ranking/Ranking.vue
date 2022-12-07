<template>
  <div>
    <div class="tabs">
      <a
        class="tab tab-lg tab-lifted pr-3"
        :class="{ 'tab-active': isActive }"
        @click="handleShowActiveCatRanking"
        >活発な性格</a
      >
      <a
        class="tab tab-lg tab-lifted pr-3"
        :class="{ 'tab-active': isGentle }"
        @click="handleShowGentleCatRanking"
        >おとなしい性格</a
      >
    </div>
    <ActiveCatRanking v-if="showActiveCatRanking" :toys="activeCatToys" />
    <GentleCatRanking v-if="showGentleCatRanking" :toys="gentleCatToys" />
  </div>
</template>
<script>
import ActiveCatRanking from "./ActiveCatRanking.vue";
import GentleCatRanking from "./GentleCatRanking.vue";

export default {
  name: "Ranking",
  components: {
    ActiveCatRanking,
    GentleCatRanking,
  },
  data() {
    return {
      activeCatToys: [],
      gentleCatToys: [],
      showActiveCatRanking: true,
      showGentleCatRanking: false,
      isActive: true,
      isGentle: false,
    };
  },
  created() {
    this.fetchActiveRanking();
    this.fetchGentleRanking();
  },
  methods: {
    fetchActiveRanking() {
      this.axios
        .get("/api/active_cat_ranking")
        .then((res) => (this.activeCatToys = res.data))
        .catch((err) => console.log(err.status));
    },
    fetchGentleRanking() {
      this.axios
        .get("/api/gentle_cat_ranking")
        .then((res) => (this.gentleCatToys = res.data))
        .catch((err) => console.log(err.status));
    },
    handleShowActiveCatRanking() {
      this.isActive = true;
      this.showActiveCatRanking = true;
      this.isGentle = false;
      this.showGentleCatRanking = false;
    },
    handleShowGentleCatRanking() {
      this.isGentle = true;
      this.showGentleCatRanking = true;
      this.isActive = false;
      this.showActiveCatRanking = false;
    },
  },
};
</script>
<style scoped>
.tabs {
  display: flex;
  flex-wrap: wrap;
  align-items: flex-end;
}
.tab {
  position: relative;
  display: inline-flex;
  cursor: pointer;
  -webkit-user-select: none;
  user-select: none;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  text-align: center;
  height: 2rem;
  font-size: 0.875rem;
  line-height: 1.25rem;
  line-height: 2;
  --tab-padding: 1rem;
}
.tab {
  --tw-text-opacity: 0.5;
}
.tab:hover {
  --tw-text-opacity: 1;
}
.tab {
  --tab-color: hsla(var(--bc) / var(--tw-text-opacity, 1));
  --tab-bg: hsla(var(--b1) / var(--tw-bg-opacity, 1));
  --tab-border-color: hsla(var(--b3) / var(--tw-bg-opacity, 1));
  color: var(--tab-color);
  padding-left: var(--tab-padding, 1rem);
  padding-right: var(--tab-padding, 1rem);
}
.tab.tab-active {
  border-color: hsl(var(--bc) / var(--tw-border-opacity));
  --tw-border-opacity: 1;
  --tw-text-opacity: 1;
}
.tab:focus {
  outline: 2px solid transparent;
  outline-offset: 2px;
}
.tab:focus-visible {
  outline: 2px solid currentColor;
  outline-offset: -3px;
}
.tab:focus-visible.tab-lifted {
  border-bottom-right-radius: var(--tab-radius, 0.5rem);
  border-bottom-left-radius: var(--tab-radius, 0.5rem);
}
.tab-lg {
    height: 3rem;
    font-size: 1.125rem;
    line-height: 1.75rem;
    line-height: 2;
    --tab-padding: 1.25rem;
}
.tab-lifted {
  border: var(--tab-border, 1px) solid transparent;
  border-width: 0 0 var(--tab-border, 1px) 0;
  border-top-left-radius: var(--tab-radius, 0.5rem);
  border-top-right-radius: var(--tab-radius, 0.5rem);
  border-bottom-color: var(--tab-border-color);
  padding-left: var(--tab-padding, 1rem);
  padding-right: var(--tab-padding, 1rem);
  padding-top: var(--tab-border, 1px);
}
.tab-lifted.tab-active {
  background-color: var(--tab-bg);
  border-width: var(--tab-border, 1px) var(--tab-border, 1px) 0
    var(--tab-border, 1px);
  border-left-color: var(--tab-border-color);
  border-right-color: var(--tab-border-color);
  border-top-color: var(--tab-border-color);
  padding-left: calc(var(--tab-padding, 1rem) - var(--tab-border, 1px));
  padding-right: calc(var(--tab-padding, 1rem) - var(--tab-border, 1px));
  padding-bottom: var(--tab-border, 1px);
  padding-top: 0;
}
.tab-lifted.tab-active:before,
.tab-lifted.tab-active:after {
  z-index: 1;
  content: "";
  display: block;
  position: absolute;
  width: var(--tab-radius, 0.5rem);
  height: var(--tab-radius, 0.5rem);
  bottom: 0;
  --tab-grad: calc(68% - var(--tab-border, 1px));
  --tab-corner-bg: radial-gradient(
    circle at var(--circle-pos),
    transparent var(--tab-grad),
    var(--tab-border-color) calc(var(--tab-grad) + 0.3px),
    var(--tab-border-color) calc(var(--tab-grad) + var(--tab-border, 1px)),
    var(--tab-bg) calc(var(--tab-grad) + var(--tab-border, 1px) + 0.3px)
  );
}
.tab-lifted.tab-active:before {
  left: calc(var(--tab-radius, 0.5rem) * -1);
  --circle-pos: top left;
  background-image: var(--tab-corner-bg);
}
/* RTL quick fix */
[dir="rtl"] .tab-lifted.tab-active:before {
  --circle-pos: top right;
}
.tab-lifted.tab-active:after {
  right: calc(var(--tab-radius, 0.5rem) * -1);
  --circle-pos: top right;
  background-image: var(--tab-corner-bg);
}
/* RTL quick fix */
[dir="rtl"] .tab-lifted.tab-active:after {
  --circle-pos: top left;
}
.tab-lifted.tab-active:first-child:before {
  background: none;
}
.tab-lifted.tab-active:last-child:after {
  background: none;
}
.tab-lifted.tab-active + .tab-lifted.tab-active:before {
  background: none;
}
@media screen and (max-width: 640px){
  .tab-lg {
    height: 1.5rem;
    --tab-padding: .75rem;
    font-size: .875rem;
    line-height: .75rem;
  }
}
</style>