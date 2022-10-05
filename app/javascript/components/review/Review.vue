<template>
  <div>
    <CreateReview v-if="showCreateReview"/>
    <EditReview v-if="showEditReview" :reviewId="reviewId"/>
  </div>
</template>
<script>
import EditReview from "./EditReview.vue";
import CreateReview from "./CreateReview.vue";

export default {
  name: "Review",
  components: {
    EditReview,
    CreateReview
  },
  props: ["reviewId"],
  data() {
    return {
      showCreateReview: false,
      showEditReview: false
    }
  },
  mounted() {
    let action_name = window.location.pathname.split("/").pop();
    if ( action_name == "new") {
      this.showCreateReview = true
    } else if ( action_name == "edit" ) {
      this.showEditReview = true
    }
  }
}
</script>