<template>
  <div class="container mx-auto">
    <div class="flex flex-col items-center justify-center">
      <div
        class="
          flex flex-col
          bg-white
          shadow-md
          px-10
          py-8
          m-4
          rounded-3xl
          w-2/4
        "
      >
        <div class="font-medium self-center text-xl sm:text-3xl text-gray-800">
          レビュー編集
        </div>
        <div class="mt-5">
          <div name="review" class="form-control">
            <div id="error-messages" v-if="errors">
              <ul>
                <li class="text-red-600" v-for="error in errors" :key="error.id">{{ error[0] }}</li>
              </ul>
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">タイトル</span>
              </label>
              <input
                type="text"
                name="title"
                class="input input-bordered w-full max-w-xs"
                v-model="review.title"
              />
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">レビュー内容</span>
              </label>
              <textarea
                name="content"
                class="textarea textarea-bordered h-30"
                rows="5"
                v-model="review.content"
              ></textarea>
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">星評価</span>
              </label>
              <star-rating
                v-model="review.rate"
                :increment="1"
                :max-rating="5"
                :rounded-corners="true"
                :star-size="30"
                name="rate"
              ></star-rating>
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">レビュー画像</span>
              </label>
              <input
                type="file"
                ref="preview"
                id="image"
                name="image"
                accept="image/*"
                @change="setImage"
              />
              <!-- @reviewのimage -->
              <img :src="review.image_url" v-if="showImage" class="w-52"/>
              <!-- 画像プレビュー -->
              <img :src="prevImage" v-if="prevImage" class="w-52" />
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">ショップ選択</span>
              </label>
              <select
                class="select select-bordered"
                v-model="review.product_type"
                @change="openModal"
              >
                <option value="" disabled>選択してください</option>
                <option value="Cainz">カインズ</option>
                <option value="Rakuten">楽天</option>
              </select>
            </div>
            <div class="flex flex-col mb-5">
              <label class="label">
                <span class="label-text">選択したおもちゃ</span>
              </label>
              <p class="font-bold">{{ selectedToy.name }}</p>
              <img :src="selectedToy.image" class="w-20 rounded-xl" />
            </div>
            <div class="flex justify-center items-center mb-5">
              <button type="submit" class="btn" @click="updatePost()">
                編集
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 商品選択用モーダル表示 -->
    <transition name="fade">
      <CainzModal
        v-if="showCainzModal"
        :cainzs="cainzs"
        @set-product="setProduct"
        @close-modal="closeCainzModal"
      />
    </transition>
    <transition name="fade">
      <RakutenModal
        v-if="showRakutenModal"
        :rakutens="rakutens"
        @set-product="setProduct"
        @close-modal="closeRakutenModal"
      />
    </transition>
  </div>
</template>
<script>
import StarRating from "vue-star-rating";
import CainzModal from "./CainzModal.vue";
import RakutenModal from "./RakutenModal.vue";

export default {
  name: "EditReview",
  components: {
    StarRating,
    CainzModal,
    RakutenModal,
  },
  props: ["reviewId"],
  data() {
    return {
      review: {
        title: "",
        content: "",
        rate: 0,
        image: null,
        product_type: "",
        product_id: ""
      },
      cainzs: [],
      rakutens: [],
      showCainzModal: false,
      showRakutenModal: false,
      showImage: true,
      selectedToy: {},
      prevImage: null,
      config: {
        headers: {}
      },
      errors: {}
    };
  },
  created() {
    this.fetchReview(),
    this.fetchCainzData(),
    this.fetchRakutenData()
  },
  methods: {
    openModal() {
      if (this.review.product_type == "Cainz") {
        this.showCainzModal = true;
      } else if (this.review.product_type == "Rakuten") {
        this.showRakutenModal = true;
      }
    },
    closeCainzModal() {
      this.showCainzModal = false;
    },
    closeRakutenModal() {
      this.showRakutenModal = false;
    },
    fetchReview() {
      this.axios.get(`/api/reviews/${this.reviewId}/edit`)
      .then(res => {
        this.review = res.data;
        this.whichProduct();
    })
      .catch(err => console.log(err.status));
    },
    fetchCainzData() {
      this.axios
        .get("/api/cainz")
        .then((res) => (this.cainzs = res.data))
        .catch((err) => console.log(err.status));
    },
    fetchRakutenData() {
      this.axios
        .get("/api/rakuten")
        .then((res) => (this.rakutens = res.data))
        .catch((err) => console.log(err.status));
    },
    whichProduct() {
      if (this.review.product_type == "Cainz") {
        this.selectedToy = this.cainzs.find(
          (cainz) => cainz.id == this.review.product_id
        );
      } else if (this.review.product_type == "Rakuten") {
        this.selectedToy = this.rakutens.find(
          (rakuten) => rakuten.id == this.review.product_id
        );
      }
    },
    setProduct(id) {
      this.review.product_id = id;
      this.whichProduct();
    },
    setImage(e) {
      if (this.prevImage) {
        URL.revokeObjectURL(this.prevImage);
        this.prevImage = null;
      }
      e.preventDefault();
      if(e.target.files) {
        this.showImage = false;
        this.review.image = e.target.files[0];
        this.prevImage = URL.createObjectURL(this.$refs.preview.files[0]);
      }
    },
    updatePost() {
      if (this.review.image) {
        this.config.headers = { "content-type": "multipart/form-data" };
      } else {
        this.config.headers = { "content-type": "application/json" };
      }
      this.axios
        .patch(`/api/reviews/${this.reviewId}`, this.review, this.config)
        .then((res) => {
          window.location = res.data.location
          })
        .catch((err) => { 
          if (err.response.data && err.response.data.errors) {
            this.errors = err.response.data.errors
          }
          });
    }
  },
};
</script>
<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>