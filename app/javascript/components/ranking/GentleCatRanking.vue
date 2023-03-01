<template>
  <div>
    <template v-if="toys.length">
      <div v-for="(toy, index) in toys" :key="toy.index">
        <div class="hero h-full bg-base-100 pt-8 px-10">
          <div class="hero-content flex-row w-full">
            <img :src="toy.image" class="max-w-sm rounded-lg shadow-2xl" />
            <div class="w-full ml-5">
              <h1 class="text-xl font-bold">第{{ rank(index) }}位</h1>
              <h1 class="text-2xl font-bold mt-8 mb-5 point" @click="sendReviewIds(toy.shop, toy.toy_id)">{{ toy.name }}</h1>
              <span class="flex flex-row mb-5">
                <star-rating
                  :rating="toy.rate"
                  :increment="1"
                  :max-rating="5"
                  :rounded-corners="true"
                  :star-size="30"
                  :read-only="true"
                  :show-rating="false"
                ></star-rating>
                <span class="ml-3">星{{ toy.rate }}つ</span>
                <span class="ml-10">総レビュー数{{ toy.count }}件</span>
              </span>
              <span class="items-center">
                <i class="fas fa-store mr-2"></i>{{ toy.shop }}
              </span>
              <div class="my-5">
                <a :href="toy.url" target="_blank" rel="noopener noreferrer" class="btn btn-primary">
                  商品サイトを見てみる
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template v-else>
      <div class="hero h-full bg-base-100 pt-8 px-10">
        <div class="hero-content flex-col w-full">
          <div class="font-bold pt-10">大人しい性格の猫ちゃんのレビューがありません...</div>
          <div class="font-bold mb-10">レビュー投稿にご協力をお願いします！！</div>
        </div>
      </div>
    </template>
  </div>
</template>
<script>
import StarRating from "vue-star-rating";

export default {
  name: "GentleCatRanking",
  components: {
    StarRating,
  },
  props: ["toys"],
  methods: {
    rank(index) {
      return index + 1;
    },
    sendReviewIds(shop, toy_id) {
      this.$emit("send-toy-id", shop, toy_id);
    }
  }
};
</script>
<style scoped>
.point {
  cursor: pointer;
}
.mt-8 {
  margin-top: 2rem;
}
.my-5 {
  margin-top: 1.25rem;
  margin-bottom: 1.25rem;
}
.w-full {
  width: 100%;
}
img {
  width: 24rem;
  height: 24rem;
}
.shadow-2xl {
  --tw-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  box-shadow: var(--tw-ring-offset-shadow, 0 0 #0000),
    var(--tw-ring-shadow, 0 0 #0000), var(--tw-shadow);
}
@media screen and (max-width: 640px){
  img {
    width: 12rem;
    height: 12rem;
  }
  .flex-row {
    flex-direction: column;
  }
  .mt-8 {
    margin-top: 0rem;
  }
  .text-xl {
    font-size: 0.875rem;
    line-height: 1.25rem;
  }
  .text-2xl {
    font-size: 1rem;
    line-height: 1.5rem;
  }
  .ml-3 {
    margin-left: 0px;
  }
  .ml-10 {
    margin-left: 0px;
  }
  .my-5 {
    margin-top: 0.75rem;
    margin-bottom: 1.25rem;
  }
  .mb-5 {
    margin-bottom: 0.75rem;
  }
}
</style>