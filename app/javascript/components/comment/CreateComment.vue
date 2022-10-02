<template>
  <div class="flex justify-center">
    <div class="flex flex-col">
      <div class="mt-6" id="comment-form">
        <textarea class="w-96 textarea" placeholder="コメントを書く" id="comment-content" v-model="comment.content"></textarea>
        <div class="flex justify-center mt-2">
          <button class="btn btn-primary" @click="createComment">投稿</button>
        </div>
      </div>
      <div class="text-3xl font-black self-center mt-5 mb-3">
        Comments
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "CreateComment",
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
      this.comment = ""
    }
  }
}
</script>