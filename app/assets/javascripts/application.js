//= require jquery
//= require jquery_ujs

//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/tab
//= require twitter/bootstrap/tooltip
//= require twitter/bootstrap/button

//= require_directory ./libs
//= require gritter
//= require plugins
//= require chosen-jquery
//= require_self
//= require_directory ./mylibs
//= require jquery.spin

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

function  displaySpinner() {
  var spinner = '<div class="jspinner-container"><div class="jspinner-innner"></div></div>';
  $('body').prepend(spinner);
  $('.jspinner-container').spin({
    lines: 6, // The number of lines to draw
    length: 3, // The length of each line
    width: 2, // The line thickness
    radius: 1, // The radius of the inner circle
    color: '#000', // #rgb or #rrggbb
    speed: 2, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false // Whether to render a shadow
  });
}

function hideSpinner() {
  $('.jspinner-container').fadeOut();
}



var OBC = (function (OBC, $) {

    'use strict';

    OBC.susyOffCanvasToggle = {
        init: function (triggers) {
            $(triggers).click(function (e) {
                e.preventDefault();
                OBC.susyOffCanvasToggle.toggleClasses(this);
                OBC.susyOffCanvasToggle.toggleText(triggers);
            });
            return triggers;
        },
        toggleClasses: function (el) {
            var body = $('body');
            var dir = $(el).attr('href');
            if (dir === '#left') {
              body.toggleClass('show-left').removeClass('show-right');
              $('html, body').animate({scrollTop:0}, 'fast'); // Scroll top
            }
            if (dir === '#right') {
                body.toggleClass('show-right').removeClass('show-left');
            }
            return body.attr('class');
        },
        toggleText: function (triggers) {
            var left = $(triggers).filter('[href="#left"]');
            var right = $(triggers).filter('[href="#right"]');
            var body = $('body');
            if (body.hasClass('show-left')) {
                left.find('i').toggleClass('icon-search').toggleClass('icon-cancel');
            } else {
                left.find('i').toggleClass('icon-search').toggleClass('icon-cancel');
            }
            if (body.hasClass('show-right')) {
                right.find('i').toggleClass('icon-user').toggleClass('icon-cancel');
            } else {
                right.find('i').toggleClass('icon-user').toggleClass('icon-cancel');
            }
        }
    };

    $(function () {
        OBC.susyOffCanvasToggle.init($('.toggle'));
    });

    return OBC;

}(OBC || {}, jQuery));

// Debounced resize

(function($,sr){

  // debouncing function from John Hann
  // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
  var debounce = function (func, threshold, execAsap) {
      var timeout;

      return function debounced () {
          var obj = this, args = arguments;
          function delayed () {
              if (!execAsap)
                  func.apply(obj, args);
              timeout = null;
          }

          if (timeout)
              clearTimeout(timeout);
          else if (execAsap)
              func.apply(obj, args);

          timeout = setTimeout(delayed, threshold || 100);
      };
  };
  // smartresize
  jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

})(jQuery,'smartresize');

// Images functions

Images = {
  adjustProfileThumbs: function(selector) {
    console.log('resized');
    $(selector).resizeToParent();
  }
};


function initApplication() {

  // Init Radio toggles
  var radio_wrapper = $('.btn-radio-toggles');
  radio_wrapper.find('.controls').attr('data-toggle', 'buttons-radio').addClass('btn-group');
  radio_wrapper.find('.radio').each(function(event) {
    $(this).addClass('btn');
    $(this).find('input').addClass('hide');
  });
  $('.radio').on('click', function() {
    $(this).children('input').attr('checked', 'checked');
    $(this).siblings().children('input').attr('checked', null);
  });

  radio_wrapper.button();

  $('.radio input:checked').parents().addClass('active');

  // init Tooltip
  $('[rel=tooltip]').tooltip();

  // Open collapsed form if errors
  if ($(".boxy_forms .control-group.error").size() > 1) {
    $(".normal_login").collapse('show');
  }

  // init chosen select input
  $("select").not(".no-chosen").chosen({ allow_single_deselect: true, width: "100%" });
  $(".search_field select").chosen({ allow_single_deselect: true, width: "100%" });

  // css arrows
  $('#main_nav li a.current').after('<div class="main_nav_current_arrow"></div>');
  $('#sub_sections li a.current').after('<div class="top_sub_nav_arrow"></div>');
  $('#footer .inner_footer th').after('<div class="footer_headers_current_arrow"></div>');

  // Fluid video
  $(".uservideo").fitVids();

  // Search UX
  $(document).on("click", '.search-form-users .btn', function(e) {
    e.preventDefault();
    $('.users_list').css('opacity', 0.5);
    displaySpinner();
    $(this).closest('form').unbind('submit').submit();
    $(this).attr("disabled", true);
  });

  // Fit text
  $("h1").fitText(1.2, { minFontSize: '20px', maxFontSize: '36px' });
  $("#search_form h3").fitText(1, { minFontSize: '14px', maxFontSize: '20px' });

  Socialite.load();

}

document.addEventListener("page:change", initApplication, hideSpinner);
document.addEventListener("page:fetch", displaySpinner);

$(document).ready(initApplication);
