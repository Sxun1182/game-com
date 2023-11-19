document.addEventListener('DOMContentLoaded', function(){
  document.querySelectorAll('.show_comments').forEach(function(button){
    button.addEventListener('click', function(){
      this.previousElementSibling.style.display = 'block';
      this.style.display = 'none';
    });
  });
});