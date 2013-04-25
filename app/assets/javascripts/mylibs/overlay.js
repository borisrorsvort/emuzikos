Overlay = {
  _show: function() {
    $('#overlay').addClass('visible');
    $('body').addClass('noscroll');
  },
  _hide: function() {
    $('#overlay').removeClass('visible');
    $('body').removeClass('noscroll');
  },
  isVisible: function() {
    return $('#overlay').hasClass('visible');
  },
  clearThat: function() {
    $('.overlay--body').html('');
    $('#overlay').removeClass('loaded');
  }
};
