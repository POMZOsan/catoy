<template>
  <div>
    <div class="container mx-auto px-5 py-10">
      <div class="flex flex-col items-center justify-center">
        <div
          class="
            flex flex-col
            bg-white
            shadow-md
            px-10
            py-8
            rounded-3xl
            w-2/4
          "
        >
          <div class="font-medium self-center text-xl sm:text-3xl text-gray-800">
            レビュー作成
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
                  class="input input-bordered input-md w-full max-w-xs"
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
                <!-- 画像プレビュー -->
                <img :src="prevImage" v-if="prevImage" class="w-52"/>
              </div>
              <div class="flex flex-col mb-5">
                <label class="label">
                  <span class="label-text">ショップ選択</span>
                </label>
                <select
                  class="select select-bordered select-md"
                  name="select-shop"
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
                <button type="submit" class="btn" @click="createPost()">
                  投稿
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
  </div>
</template>
<script>
import StarRating from "vue-star-rating";
import CainzModal from "./CainzModal.vue";
import RakutenModal from "./RakutenModal.vue";

export default {
  name: "CreateReview",
  components: {
    StarRating,
    CainzModal,
    RakutenModal,
  },
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
      selectedToy: {},
      prevImage: null,
      config: {
        headers: {}
      },
      errors: {}
    };
  },
  created() {
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
    setProduct(id) {
      this.review.product_id = id;
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
    setImage(e) {
      if (this.prevImage) {
        URL.revokeObjectURL(this.prevImage);
        this.prevImage = null;
      }
      e.preventDefault();
      if(e.target.files) {
        this.review.image = e.target.files[0];
        this.prevImage = URL.createObjectURL(this.$refs.preview.files[0]);
      }
    },
    createPost() {
      if (this.review.image) {
        this.config.headers = { "content-type": "multipart/form-data" };
      } else {
        this.config.headers = { "content-type": "application/json" };
      }
      this.axios
        .post("/api/reviews", this.review, this.config)
        .then((res) => {
          window.location = res.data.location;
          })
        .catch((err) => {
          if (err.response.data && err.response.data.errors) {
            this.errors = err.response.data.errors;
          }
        })
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
.w-2\/4 {
  width: 50%;
  }
.w-52 {
  width: 13rem;
}
.w-20 {
  width: 5rem;
}
@media screen and (max-width: 640px){
  .w-2\/4 {
  width: 100%;
  }
  .input-md {
    height: 2rem;
    padding-left: 0.75rem;
    padding-right: 0.75rem;
    font-size: .875rem;
    line-height: 2rem;
  }
  .select-md {
    height: 2rem;
    padding-left: 0.75rem;
    padding-right: 2rem;
    font-size: .875rem;
    line-height: 2rem;
    min-height: 2rem;
  }
}
</style>
