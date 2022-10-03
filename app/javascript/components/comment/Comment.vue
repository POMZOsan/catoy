<template>
  <div>
    <CreateComment @create-comment="createComment" />
    <div class="flex justify-center">
      <div class="overflow-x-auto w-2/5">
        <table class="table w-full" >
          <tbody id="js-comments-table">
            <!-- row1 -->
            <tr :id="'comment-'+comment.id" v-for="comment in comments" :key="comment.id" >
              <td class="w-10">
                <div class="flex items-center">
                  <div class="avatar">
                    <div class="mask mask-squircle w-12 h-12">
                      <img :src="comment.user.avatar_url" />
                    </div>
                  </div>
                </div>
              </td>
              <td class="pl-0">
                <div class="flex flex-col">
                  <div class="font-bold">{{comment.user.name}}</div>
                  {{comment.content}}
                </div>
              </td>
              <td class="w-5">
                <div class="flex items-center">
                  <template v-if="comment.user.id === currentUserId">
                    <button @click="deleteComment(comment.id)">
                      <i class="fas fa-trash-alt ml-2" />
                    </button>
                  </template>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import CreateComment from "./CreateComment.vue"

export default {
  name: "Comment",
  components: {
    CreateComment
  },
  props: ["reviewId", "currentUserId"],
  data() {
    return {
      comments: []
    }
  },
  created() {
    this.fetchComments()
  },
  methods: {
    fetchComments() {
      this.axios.get(`/api/comments/?review_id=${this.reviewId}`)
      .then(res => this.comments = res.data)
      .catch(err => console.log(err.status))
    },
    createComment(comment) {
      this.axios.post("/api/comments/", { comment, review_id: this.reviewId })
      .then(res => this.comments.unshift(res.data))
    },
    deleteComment(id) {
      this.axios.delete(`/api/comments/${id}`)
      .then(res => this.comments = this.comments.filter(comment => comment.id !== res.data.id))
    }
  }
};
</script>
