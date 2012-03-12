//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_directory ./libs
//= require_directory ./mylibs
//= require gritter
//= require plugins
//= require_self


/* rest of file omitted */

if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
  var viewportmeta = document.querySelectorAll('meta[name="viewport"]')[0];
  if (viewportmeta) {
    viewportmeta.content = 'width=device-width, minimum-scale=1.0, maximum-scale=1.0';
    document.body.addEventListener('gesturestart', function() {
      viewportmeta.content = 'width=device-width, minimum-scale=0.25, maximum-scale=1.6';
    }, false);
  }
}

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    };
  }
}

// addLoadEvent(function() {
//   if (document.getElementById && document.getElementsByTagName) {
//   var aImgs = document.getElementById("content").getElementsByTagName("img");
//   imgSizer.collate(aImgs);
//   }
// });

$(document).ready(function() {

  // TIPSY

  $('.tooltip').tipsy({trigger: 'hover', gravity: 's'});

  $('input.form_guide').tipsy({trigger: 'focus', gravity: 'w'});


  // UI STUFF

  $("a[rel='external']").click( function() {
    window.open( $(this).attr('href') );
    return false;
  });

	$('.button').button({
    text: true
  });
  $('.button.add').button({
    icons: {
      primary: 'ui-icon-plus'
    },
    text: true
  });
  $('.button.add_to_contact_list').button({
    icons: {
      primary: 'ui-icon-star'
    },
    text: true
  });
  $('.button.contact').button({
    icons: {
      primary: 'ui-icon-mail-closed'
    },
    text: true
  });
  $('.button.contact_from_index').button({
    icons: {
      secondary: 'ui-icon-comment'
    },
    text: false
  });
  $('.button.delete').button({
    icons: {
      primary: 'ui-icon-trash'
    },
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

  $("select").chosen({ allow_single_deselect: true, width: "100%" });

  $(".checkbox_set").buttonset();

  // CSS ARROWS

  $('#main_nav li a.current').after('<div class="main_nav_current_arrow"></div>');
  $('#sub_sections li a.current').after('<div class="top_sub_nav_arrow"></div>');
  $('#footer .inner_footer th').after('<div class="footer_headers_current_arrow"></div>');

  // MASONRY
  $(".testimonials").masonry({ singleMode: true,resizeable: true, animate: true,itemSelector: '.testimonial' });

  // BOXY MODAL CONFIG

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

  $('#search_form .button').click(function() {
    $('.progress_bar_wrapper').removeClass('hidden');
    $('.users_list').css('opacity', 0.5);
    $(this).closest('form').submit();
    $(this).attr("disabled", true);
  });

  $('.habtm').click_checkbox();
});
