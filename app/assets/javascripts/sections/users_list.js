RemoteProfile = {
  init: function() {
    RemoteProfile._load(url);
  },
  _load: function(url) {
    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      beforeSend: function(xhr, settings) {
        Overlay.clearThat();
        Overlay._show();
        $('#overlay').spin();
      },
      success: function(data, textStatus, xhr) {
        $('#overlay .overlay--body').html(data);
        $('#overlay').addClass('loaded');
        $("#overlay h1").fitText(1, { minFontSize: '20px', maxFontSize: '28px' });
        RemoteProfile.initBinding();
        $('#overlay').spin(false);
      },
      error: function(xhr, textStatus, errorThrown) {
        //called when there is an error
      }
    });
  },
  initBinding: function() {
    $('[data-trigger=overlay-close]').on('click', function(event) {
      Overlay._hide();
    });
    var avatarSize = $('.user-profile--header--avatar img');
    $(avatarSize).resizeToParent();
  }
};
