//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_directory ./libs
//= require gritter
//= require plugins
//= require_self
//= require_directory ./mylibs
//= require turbolinks
//= require jquery.spin

/* rest of file omitted */

// Fix links inside mobile safari
(function(document,navigator,standalone) {
    // prevents links from apps from oppening in mobile safari
    // this javascript must be the first script in your <head>
  if ((standalone in navigator) && navigator[standalone]) {
    var curnode, location=document.location, stop=/^(a|html)$/i;
    document.addEventListener('click', function(e) {
      curnode=e.target;
      while (!(stop).test(curnode.nodeName)) {
          curnode=curnode.parentNode;
      }
      // Condidions to do this only on links to your own app
      // if you want all links, use if('href' in curnode) instead.
      if('href' in curnode && ( curnode.href.indexOf('http') || ~curnode.href.indexOf(location.host) ) ) {
          e.preventDefault();
          location.href = curnode.href;
      }
    },false);
  }
})(document,window.navigator,'standalone');

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

function clear_form_elements(ele) {

  $(ele).find('input').each(function() {
      switch(this.type) {
          case 'password':
          case 'select-multiple':
          case 'select-one':
          case 'text':
          case 'textarea':
              $(this).val('');
              break;
          case 'checkbox':
          case 'radio':
              this.checked = false;
      }
  });

}

function  displaySpinner() {
  var spinner = '<div class="jspinner"></div>';
  $('.container-fluid[role=main]').prepend(spinner);
  $('.jspinner').spin();
}

function hideSpinner() {
  $('.jspinner').fadeOut();
}


function initApplication() {
  // TIPSY

  $(".collapse").collapse();
  $('[rel=tooltip]').tooltip();
  // $('data-toggle=dropdown').dropdown();

  if ($(".boxy_forms .control-group.error").size() > 1) {
    $(".normal_login").collapse('show');
  }
  $("select").not(".no-chosen").chosen({ allow_single_deselect: true, width: "100%" });
  $(".search_field select").chosen({ allow_single_deselect: true, width: "100%" });

  // CSS ARROWS

  $('#main_nav li a.current').after('<div class="main_nav_current_arrow"></div>');
  $('#sub_sections li a.current').after('<div class="top_sub_nav_arrow"></div>');
  $('#footer .inner_footer th').after('<div class="footer_headers_current_arrow"></div>');

  // MASONRY
  $(".testimonials").masonry({ singleMode: true,resizeable: true, animate: true,itemSelector: '.testimonial' });

  $('#user_search .btn').click(function() {
    $('.progress_bar_wrapper').removeClass('hidden');
    $('.users_list').css('opacity', 0.5);
    $(this).closest('form').submit();
    $(this).attr("disabled", true);
  });

  Socialite.load();
}


document.addEventListener("page:change", initApplication);
document.addEventListener("page:fetch", displaySpinner);
document.addEventListener("page:change", hideSpinner);

$(document).ready(initApplication);
