<template>
  <div id="cainz-modal" class="modal" @click.self="closeCainzModal">
    <div class="modal-box relative">
      <button
        class="btn btn-sm btn-circle absolute right-2 top-2"
        @click="closeCainzModal"
      >
        x
      </button>
      <ul>
        <div
          :id="cainz.id"
          v-for="cainz in cainzs"
          :key="cainz.id"
          class="flex flex-col"
        >
          <li class="flex justify-center">
            {{ cainz.name }}
          </li>
          <li class="flex justify-center">
            <img :src="cainz.image" class="w-52"/>
            <button class="btn" @click="setProduct(cainz.id)">選択</button>
          </li>
        </div>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  name: "CainzModal",
  props: ["cainzs"],
  methods: {
    closeCainzModal() {
      this.$emit("close-modal");
    },
    setProduct(id) {
      this.$emit("set-product", id);
      this.closeCainzModal();
    },
  },
};
</script>
<style scoped>
.modal {
  z-index: 1;
  position: fixed;
  top: 0px;
  right: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  background-color: hsl(var(--nf, var(--n)) / var(--tw-bg-opacity));
  --tw-bg-opacity: 0.4;
  display: flex;
  justify-content: center;
  align-items: center;

  /* overflow-y: hidden; */
  /* overscroll-behavior: contain */
}
.modal-box {
  z-index: 2;
  max-height: calc(100vh - 5em);
  --tw-bg-opacity: 1;
  background-color: hsl(var(--b1) / var(--tw-bg-opacity));
  padding: 1rem;
  width: 91.666667%;
  max-width: 32rem;
  --tw-scale-x: .9;
  --tw-scale-y: .9;
  transition-property: color, background-color, border-color, fill, stroke, opacity, box-shadow, transform, filter, -webkit-text-decoration-color, -webkit-backdrop-filter;
  transition-property: color, background-color, border-color, text-decoration-color, fill, stroke, opacity, box-shadow, transform, filter, backdrop-filter;
  transition-property: color, background-color, border-color, text-decoration-color, fill, stroke, opacity, box-shadow, transform, filter, backdrop-filter, -webkit-text-decoration-color, -webkit-backdrop-filter;
  transform: translate(var(--tw-translate-x), var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
  border-top-left-radius: var(--rounded-box, 1rem);
  border-top-right-radius: var(--rounded-box, 1rem);
  border-bottom-left-radius: var(--rounded-box, 1rem);
  border-bottom-right-radius: var(--rounded-box, 1rem);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  overflow-y: auto;
  overscroll-behavior: contain
}
</style>