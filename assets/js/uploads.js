document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.file-input').forEach(el => {
    el.addEventListener('change', e => {
      let filename = e.target.value.split('\\').pop();
      let fileNameTag = e.target.parentNode.querySelector('.file-name');
      if (filename) {
        fileNameTag.classList.remove('is-hidden');
        fileNameTag.innerHTML = filename;
      } else {
        fileNameTag.classList.add('is-hidden');
      }
    });
  });

  document.querySelectorAll('.remove-image-link').forEach(el => {
    el.addEventListener('click', e => {
      let parent = e.target.parentNode;
      let removeImageInput = parent.querySelector('.remove-image-input');
      removeImageInput.value = true;

      let recipeImage = parent.querySelector('.recipe-image');
      e.target.classList.add('is-hidden');
      recipeImage.classList.add('is-hidden');
    });
  });
});
