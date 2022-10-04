<template>
<div class="container mx-auto">
  <div class="flex flex-col items-center justify-center">
    <div class="flex flex-col bg-white shadow-md px-10 py-8 m-4 rounded-3xl w-2/4">
      <div class="font-medium self-center text-xl sm:text-3xl text-gray-800">
        レビュー作成
      </div>
      <div class="mt-5">
        <div class="form-control">
          <div class="flex flex-col mb-5">
            <label class="label">
              <span class="label-text">タイトル</span>
            </label>
            <input type="text" name="title" class="input input-bordered w-full max-w-xs" v-model="review.title"/>
          </div>
          <div class="flex flex-col mb-5">
            <label class="label">
              <span class="label-text">レビュー内容</span>
            </label>
            <textarea name="content" class="textarea textarea-bordered h-30" rows="5" v-model="review.content"></textarea>
          </div>
          <div class="flex flex-col mb-5">
            <label class="label">
              <span class="label-text">星評価</span>
            </label>
            <star-rating v-model="review.rate" :increment="1" :max-rating="5" :rounded-corners="true" :star-size="30"></star-rating>
          </div>
          <div class="flex flex-col mb-5">
            <label class="label">
              <span class="label-text">レビュー画像</span>
            </label>
            <input type="file" id="image" name="image" accept="image/*" />
          </div>
          <div class="flex flex-col mb-5">
            <label class="label">
              <span class="label-text">ショップ選択</span>
            </label>
            <select class="select select-bordered" v-model="review.product_type" @change="openModal">
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
            <img :src="selectedToy.image" class="w-20 rounded-xl"/>
          </div>
          <div class="flex justify-center items-center mb-5">
            <button type="submit" class="btn">投稿</button>
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 商品選択用モーダル表示 -->
  <transition name="fade">
    <CainzModal v-if="showCainzModal" :cainzs="cainzs" @set-product="setProduct" @close-modal="closeCainzModal" />
  </transition>
  <transition name="fade">
    <RakutenModal v-if="showRakutenModal" :rakutens="rakutens" @set-product="setProduct" @close-modal="closeRakutenModal"/>
  </transition>
</div>
</template>
<script>
import StarRating from 'vue-star-rating'
import CainzModal from './CainzModal.vue'
import RakutenModal from './RakutenModal.vue'

export default {
  name: "Review",
  components: {
    StarRating,
    CainzModal,
    RakutenModal
  },
  data() {
    return {
      review: {
        title: "",
        content: "",
        rate: 0,
        product_type: "",
        product_id: "",
        image: null
      },
      cainzs: [],
      rakutens: [],
      showCainzModal: false,
      showRakutenModal: false,
      selectedToy: {}
    }
  },
  created() {
    this.fetchCainzData(),
    this.fetchRakutenData()
  },
  methods: {
    openModal() {
      if (this.review.product_type == "Cainz") {
        this.showCainzModal = true
      } else if (this.review.product_type == "Rakuten") {
        this.showRakutenModal = true
      }
    },
    closeCainzModal() {
      this.showCainzModal = false
    },
    closeRakutenModal() {
      this.showRakutenModal = false
    },
    fetchCainzData() {
      this.axios.get("/api/cainz")
      .then(res => this.cainzs = res.data)
      .catch(err => console.log(err.status))
    },
    fetchRakutenData() {
      this.axios.get("/api/rakuten")
      .then(res => this.rakutens = res.data)
      .catch(err => console.log(err.status))
    },
    setProduct(id) {
      this.review.product_id = id
      if (this.review.product_type == "Cainz") {
        this.selectedToy = this.cainzs.find(cainz => cainz.id == this.review.product_id)
      } else if (this.review.product_type == "Rakuten") {
        this.selectedToy = this.rakutens.find(rakuten => rakuten.id == this.review.product_id)
      }
    }
  }
}
</script>
<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
