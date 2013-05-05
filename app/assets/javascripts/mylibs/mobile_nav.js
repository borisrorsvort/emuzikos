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
        $('body').removeClass('show-left show-right');
        $('.logo').show();
      });
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
        right.toggle();
        left.toggle();
        right.siblings('[data-trigger=close]').toggle();
      }
      if (body.hasClass('show-right')) {
        right.toggle();
        left.toggle();
        left.siblings('[data-trigger=close]').toggle();
      }
      $('.logo').hide();
    }
  };

  $(function () {
      OBC.susyOffCanvasToggle.init($('.toggle'));
  });

  return OBC;

}(OBC || {}, jQuery));
