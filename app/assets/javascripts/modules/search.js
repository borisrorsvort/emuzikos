Search = {
  init: function() {
    Search.formSubmitCallbacks();
  },
  formSubmitCallbacks: function() {
    $('.search-form-users')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      $('.search-loader').show().spin();
    })
    .bind("ajax:success", function(evt, data, status, xhr){
      $('.search-loader').hide().spin(false);
      UserList.init();
      RemoteProfile.init();
      $('[data-trigger=close]').click();
      mixpanel.track('Submited search form');
    });
  }
};
