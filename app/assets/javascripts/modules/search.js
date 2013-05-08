Search = {
  init: function() {
    Search.formSubmitCallbacks();
    if ($('.users-list').length) {
      $('.search-form-users').attr('data-remote', true);
    }
  },
  formSubmitCallbacks: function() {
    $('.search-form-users')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      $('.search-loader').show().spin();
      $('[data-trigger=close]').click();
    })
    .bind("ajax:success", function(evt, data, status, xhr){
      $('.search-loader').hide().spin(false);
      UserList.init();
      RemoteProfile.init();
      mixpanel.track('Submited search form');
    });
  }
};
