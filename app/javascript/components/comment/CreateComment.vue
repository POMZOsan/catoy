<template>
  <div class="flex justify-center">
    <div class="flex flex-col">
      <div class="mt-6" id="comment-form">
        <textarea class="w-96 textarea" placeholder="コメントを書く"></textarea>
        <div class="flex justify-center mt-2">
          <button class="btn btn-primary">投稿</button>
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
  name: "CreateComment"
};
</script>