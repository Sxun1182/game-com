// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function() {
  var forms = document.querySelectorAll('form');
  forms.forEach(function(form) {
    var input = this.querySelector('input[type="text"]');
    var submitButton = this.querySelector('input[type="submit"]');
    submitButton.removeAttribute('disabled');
    form.onsubmit = function() {
      if (input.value === '') {
        alert('検索欄が空です。何かキーワードを入力してください。');
        return false;
      }
    };
  });
});