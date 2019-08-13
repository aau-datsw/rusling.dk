//= require active_admin/base
//= require array-input
//= require tinymce

$(document).ready(function() {
  tinyMCE.init({
    selector: '.tinymce-input',
    theme: 'silver',
    menubar: false
  });
});
