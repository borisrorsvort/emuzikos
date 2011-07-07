$(document).ready(function() {

  // TIPSY

  $('.tooltip').tipsy({trigger: 'hover', gravity: 's'});
  
  $('input.form_guide').tipsy({trigger: 'focus', gravity: 'w'});

  // FORMS UTILS
  // var search_form = $('form.search')
  // search_form.find("input[type=submit]").hide();
  // search_form.change(function() {
  //   $(this).submit();
  // });

  
  // UI STUFF
  
  $("a[rel='external']").click( function() {
    window.open( $(this).attr('href') );
    return false;
  });
  
	$('.button').button({
    text: true
  });
  
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
  
  $('.button.back').button({
    icons: {
      primary: 'ui-icon-triangle-1-w'
    },
    text: true
  });
  
  $( ".tabs" ).tabs();  
  
  $(".checkbox_set").buttonset();
  
  $("select, input:checkbox, input.radio:radio").uniform(); 
  
  // CSS ARROWS
  
  $('#main_nav li a.current').after('<div class="main_nav_current_arrow"></div>');
  $('#sub_sections li a.current').after('<div class="top_sub_nav_arrow"></div>');
  $('#footer .inner_footer th').after('<div class="footer_headers_current_arrow"></div>');
  
  // NOISY STUFF
  
  $('.homepage #content').noisy({
      'intensity' : 1, 
      'size' : 150, 
      'opacity' : 0.06, 
      'fallback' : '', 
      'monochrome' : true
  });
  
  // MASONRY
  $(".testimonials").masonry({ singleMode: true,resizeable: true, animate: true,itemSelector: '.testimonial' });
  
  // BOXY MODAL CONFIG
  //$("a[rel=boxy]").boxy({modal: true, closeable: true, center: true, title: "EMUZIKOS" , closetext: "[close]"});
  
  $('a[rel=boxy]').click(function(){
    var selector = $(this).attr('href');
    $(selector).modal({
      overlayCss: {backgroundColor:"#000"},
      autoResize: false,
      autoPosition: true,
      overlayClose: true,
      maxWidth: 380,
      maxHeight: '80%'
    });
  });
  
});
