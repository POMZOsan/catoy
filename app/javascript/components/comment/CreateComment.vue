<template>
  <div class="flex justify-center">
    <div class="flex flex-col">
      <div class="mt-6" id="comment-form">
        <div id="error-messages" v-if="error">
          <p class="text-red-600">{{ error[0] }}</p>
        </div>
        <textarea class="w-96 textarea" placeholder="コメントを書く" id="comment-content" v-model="comment.content"></textarea>
        <div class="flex justify-center mt-2">
          <button class="btn" @click="createComment">投稿</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "CreateComment",
  props: ["error"],
  data() {
    return {
      comment: {
        content: ""
      }
    }
  },
  methods: {
    createComment() {
      this.$emit("create-comment", this.comment)
      this.comment.content = ""
    }
  }
}
</script>