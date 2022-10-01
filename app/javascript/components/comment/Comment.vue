<template>
  <div>
    <CreateComment />
    <div class="flex justify-center">
      <div class="overflow-x-auto w-2/5">
        <table class="table w-full">
          <tbody id="js-comments-table">
            <!-- row1 -->
            <tr id="comment-<%= comment.id %>">
              <td class="w-10">
                <div class="flex items-center">
                  <div class="avatar">
                    <div class="mask mask-squircle w-12 h-12">
                      <%= image_tag comment.user.decorate.avatar %>
                    </div>
                  </div>
                </div>
              </td>
              <td class="pl-0">
                <div class="flex flex-col">
                  <div class="font-bold"><%= comment.user.name %></div>
                  <div class="js-comment-content-<%= comment.id %>">
                    <%= simple_format(comment.content) %>
                  </div>
                </div>
              </td>
              <td class="w-5">
                <div class="flex items-center">
                  <i class="fas fa-trash-alt ml-2"></i>
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
  }
};
</script>
