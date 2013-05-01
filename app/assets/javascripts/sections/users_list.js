RemoteProfile = {
  _load: function(selector, url) {
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      beforeSend: function(xhr, settings) {
        Expander.clearMarkup();
        selector.spin();
      },
      success: function(data, textStatus, xhr) {
        Expander.init(selector, data);
        RemoteProfile.initBinding();
        Expander.scrollToOffset();
        selector.spin(false);
      },
      error: function(xhr, textStatus, errorThrown) {
        $.gritter.add({image:'/assets/error.png',title:'Error',text:'We could not load this profile'});
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
    $('html, body').animate({scrollTop: offset-30}, 'fast'); // Scroll top
  }
};
