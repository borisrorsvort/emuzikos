var OBC = (function (OBC, $) {

  'use strict';

  OBC.susyOffCanvasToggle = {
    init: function (triggers) {
        $(triggers).click(function (e) {
            e.preventDefault();
            OBC.susyOffCanvasToggle.toggleClasses(this);
            OBC.susyOffCanvasToggle.toggleText(triggers);
        });
        OBC.susyOffCanvasToggle.bindCloseButton();
        return triggers;
    },
    bindCloseButton: function() {
      $('[data-trigger=close]').click(function(event) {
        event.preventDefault();
        var left = $('[href="#left"]');
        var right = $('[href="#right"]');
        left.show();
        right.show();
        $('body').removeClass('show-left show-right');
        $('[data-trigger=close]').hide();
      });
    },
    toggleClasses: function (el) {
      var body = $('body');
      var dir = $(el).attr('href');
      if (dir === '#left') {
        body.toggleClass('show-left').removeClass('show-right');
      }
      if (dir === '#right') {
        body.toggleClass('show-right').removeClass('show-left');
      }
      $('html, body').animate({scrollTop:0}, 0); // Scroll top

      return body.attr('class');
    },
    toggleText: function (triggers) {
      var left = $(triggers).filter('[href="#left"]');
      var right = $(triggers).filter('[href="#right"]');
      var body = $('body');
      if (body.hasClass('show-left')) {
        left.hide();
        right.show();
        $('[data-trigger=close]').hide();
        left.siblings('[data-trigger=close]').show();
      }
      if (body.hasClass('show-right')) {
        right.hide();
        left.show();
        $('[data-trigger=close]').hide();
        right.siblings('[data-trigger=close]').show();
      }
    }
  };

  $(function () {
      OBC.susyOffCanvasToggle.init($('.toggle'));
  });

  return OBC;

}(OBC || {}, jQuery));
