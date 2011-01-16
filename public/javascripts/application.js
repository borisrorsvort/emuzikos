$(document).ready(function() {

  // TIPSY
  $('.form_guide').focus(function () {
   $(this).tipsy({trigger: 'focus', gravity: 'w'});
  });

  // FORMS UTILS
  var search_form = $('form.search')
  search_form.find("input[type=submit]").hide();
  search_form.change(function() {
    $(this).submit();
  });

});
