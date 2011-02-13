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

  
  // UI STUFF

	$('.button.submit').button({
    icons: {
      secondary: 'ui-icon-triangle-1-e'
    },
    text: true
  });
  $('.button.reset').button({
    icons: {
      primary: 'ui-icon-arrowreturnthick-1-w'
    },
    text: true
  });
  
  $(".checkbox_set").buttonset();
  $("select, input:checkbox, input.radio:radio, input:file").uniform();
  
  

  
});
