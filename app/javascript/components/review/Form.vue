<template>
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
          <input type="text" name="title" class="input input-bordered w-full max-w-xs" v-model="title"/>
        </div>
        <div class="flex flex-col mb-5">
          <label class="label">
            <span class="label-text">レビュー内容</span>
          </label>
          <textarea name="content" class="textarea textarea-bordered h-30" rows="5" v-model="content"></textarea>
        </div>
        <div class="flex flex-col mb-5">
          <label class="label">
            <span class="label-text">星評価</span>
          </label>
          <star-rating v-model="rate" :increment="1" :max-rating="5" rounded-corners="true" star-size="30"></star-rating>
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
          <select class="select select-bordered" v-model="product_type">
            <option disabled selected>選択してください</option>
            <option :value="Cainz" @change="openCainzModal">カインズ</option>
            <option :value="Rakuten" @change="openRakutenModal">楽天</option>
          </select>
          <!-- 商品選択用モーダル表示 -->
          <CainzModal v-if="showCainzModal" />
          <RakutenModal v-if="showRakutenModal" />
          <!-- カインズ</br>
          <div class="select select-bordered w-full">
            <%= f.collection_select :product_id, Cainz.order(:name), :id, :name, { prompt: "選択してください" } %>
          </div>
          楽天24</br>
          <div class="select select-bordered w-full">
            <%= f.collection_select :product_id, Rakuten.order(:name), :id, :name, { prompt: "選択してください" } %>
          </div> -->
        </div>
        <div class="flex justify-center items-center mb-5">
          <button type="submit" class="btn">投稿</button>
        </div>
      </div>
    </div>
  </div>
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
      showCainzModal: false,
      showRakutenModal: false
    }
  },
  created() {

    
  },
  methods: {
    openCainzModal() {
      this.showCainzModal = true
    },
    openRakutenModal() {
      this.showRakutenModal = true
    },

  }
}
</script>

