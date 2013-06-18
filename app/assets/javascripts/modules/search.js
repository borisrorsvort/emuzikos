// Search = {
//   init: function() {

//   },
//   formSubmitCallbacks: function() {
//     console.log('Bind Search');
//     $('.search-form-users')
//     .bind("ajax:beforeSend", function(evt, xhr, settings){
//       $('.search-loader').show().spin();
//       $('[data-trigger=close]').click();
//     })
//     .bind("ajax:success", function(evt, data, status, xhr){
//       $('.search-loader').hide().spin(false);
//       UserList.init();
//       RemoteProfile.init();
//       mixpanel.track('Submited search form');
//     });
//   }
// };
