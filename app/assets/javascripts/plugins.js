$(function() {
  jQuery.fn.click_checkbox = function(){
    $(this).click(function() {
      $(this).siblings('.checker').first().find('input').click();
    });
  }
});