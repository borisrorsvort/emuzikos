(function($) {
  $.fn.visible = function(partial) {
    var $t            = $(this),
        $w            = $(window),
        viewTop       = $w.scrollTop(),
        viewBottom    = viewTop + $w.height(),
        _top          = $t.offset().top,
        _bottom       = _top + $t.height(),
        compareTop    = partial === true ? _bottom : _top,
        compareBottom = partial === true ? _top : _bottom;
    return ((compareBottom <= viewBottom) && (compareTop >= viewTop));
  };
})(jQuery);

UserList = {
  init: function() {
    if ($(".mini-profile").length > 0) {
      UserList.animateProfiles();
      UserList.initInfiniteLoad();
      UserList.resizeMiniThumb($('.mini-profile'));
    }
  },
  resizeMiniThumb: function(elements) {
    $.each(elements, function(index, val) {
      var image = $(this).find('img');
      var height = $(this).find('.mini-profile--inner').height();
      image.imagesLoaded({
        callback: function ($images, $proper, $broken) {
          $images.parent().css('height', height);
          $images.resizeToParent();
          var animation_class = $images.attr('data-animated-class');
          $images.addClass(animation_class).delay(600).addClass('animated');
        }
      });
    });
  },
  initInfiniteLoad: function() {
    $('.mini-profiles').infinitescroll({
      navSelector  : '.pagination',    // selector for the paged navigation
      nextSelector : '.pagination .next a',  // selector for the NEXT link (to page 2)
      itemSelector : '.mini-profile',     // selector for all items you'll retrieve
      bufferPx: 800,
      animate: false,
      prefill: true
    },function(arrayOfNewElems){
      RemoteProfile.init();
      UserList.resizeMiniThumb(arrayOfNewElems);
    });
  },
  animateProfiles: function() {
    $(window).scroll(function(event) {
      $(".mini-profile").each(function(i, el) {
        var that = $(el);
        if (that.visible(true)) {
          that.addClass("come-in");
        }
      });
    });
    var win = $(window);
    var allMods = $(".mini-profile");
    // Already visible modules
    allMods.each(function(i, el) {
      var that = $(el);
      if (that.visible(true)) {
        that.addClass("already-visible");
      }
    });

    win.scroll(function(event) {
      allMods.each(function(i, el) {
        var that = $(el);
        if (that.visible(true)) {
          that.addClass("come-in");
        }
      });

    });
  }
};

RemoteProfile = {
  init: function() {
    $('.mini-profile.media').unbind().on('click', function(event) {
      event.preventDefault();
      var url = $(this).attr('data-profile-url');
      RemoteProfile._load($(this), url);
      return false;
    });
  },
  _load: function(selector, url) {
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      beforeSend: function(xhr, settings) {
        Expander.clearMarkup();
        selector.spin();
        selector.addClass('faded');
      },
      success: function(data, textStatus, xhr) {
        Expander.init(selector, data);
        RemoteProfile.initBinding();
        Expander.scrollToOffset();
        selector.spin(false);
        selector.removeClass('faded');
      },
      error: function(xhr, textStatus, errorThrown) {
        //called when there is an error
      }
    });
  },
  initBinding: function() {
    $('[data-trigger=overlay-close]').on('click', function(event) {
      Expander.clearMarkup();
    });
    $('.user-profile--header--avatar img').resizeToParent();
  }
};

Expander = {
  init: function(selector, data) {
    Expander.createMarkup(selector);
    $('.profile-expander').html(data);
    $(".profile-expander h1").fitText(1, { minFontSize: '20px', maxFontSize: '28px' });
  },
  createMarkup: function(selector){
    selector.after('<li class="profile-expander"></div>');
  },
  clearMarkup: function() {
    $('.profile-expander').remove();
  },
  scrollToOffset: function() {
    var offset = $('.profile-expander').position().top;
    $('.content').animate({scrollTop: offset-30}, 'fast'); // Scroll top
  }
};
