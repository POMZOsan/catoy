document.addEventListener('DOMContentLoaded', ()=> {
  const element = document.getElementById('select-image')

  element.addEventListener('change', (e)=> {
    const target = e.target;
    const file = target.files[0];
    const reader = new FileReader();

    reader.onloadend = function () {
      const preview = document.getElementById('preview');
      if(preview) {
        preview.src = reader.result;
      }
    }
    if (file) {
      reader.readAsDataURL(file);
    }
  })
})
