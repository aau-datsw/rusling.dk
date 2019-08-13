$(function() {
  var removeFromArrayInput;
  removeFromArrayInput = function(el) {
    var input;
    input = $(el).siblings('input');
    if (input.attr('disabled') === 'disabled') {
      $(el).html('<i class="fa fa-times-circle"></i>').removeClass('can-undo');
      $(input).removeAttr('disabled');
      return $(input).removeClass('text--strike');
    } else {
      $(el).html('<i class="fa fa-undo"></i>').addClass('can-undo');
      $(input).attr('disabled', 'disabled');
      return $(input).addClass('text--strike');
    }
  };
  $('.js-add-to-array-input').click(function(e) {
    var clone, clone_id, input, original;
    e.preventDefault;
    if ($(this).hasClass('array-action--add')) {
      original = $(this).parent();
      clone = $(original).clone(true);
      clone_id = "clone_" + (Math.floor((Math.random() * 100000) + 1));
      input = $(clone).find('input');
      if ($(input).val() !== '') {
        $(original).find('input').removeClass('has-error');
        $(input).removeClass('has-error').attr('id', clone_id).val('');
        $(this).html('<i class="fa fa-times-circle"></i>').attr('class', 'array-action--remove js-remove-from-array-input');
        $(this).parent().parent().append($(clone));
        return $("#" + clone_id).focus();
      } else {
        return $(original).find('input').addClass('has-error').focus();
      }
    } else {
      return removeFromArrayInput($(this));
    }
  });
  return $('.js-remove-from-array-input').click(function(e) {
    e.preventDefault;
    return removeFromArrayInput($(this));
  });
});
