//= require active_admin/base
//= require array-input
//= require tinymce
//= require tinymce/themes/silver/theme

$(document).ready(function() {
  tinyMCE.init({
    selector: '.tinymce-input',
    menubar: false
  });
});
