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
//= require select2
//= require_self
//= require_directory ./mylibs
//= require_directory ./modules
//= require jquery.spin
//= require wiselinks

App = {
  init: function() {
    App.generalStuff();
    Images.adjustProfileThumbs();
    UserList.init();
    RemoteProfile.init();
    App.removeNotificationBinding();
    console.log('================ App initialized =================');
  },

  initWizeLink: function() {
    window.wiselinks = new Wiselinks($('.content'), {'html4': true});
  },

  generalStuff: function() {
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

    // init select2 select input
    $("select").not(".no-chosen").select2({width: '100%'});
    $(".search_field select").select2({width: '100%'});
    $(".search_field select").select2({width: '100%', maximumSelectionSize: 3});

    // Fluid video
    $(".uservideo").fitVids();

    // Fit text
    $("h1.fitText").fitText(1, { minFontSize: '20px', maxFontSize: '28px' });

    $('.message-delete-form').off('click').on('click', function(event) {
      $(this).parents('.message-wrapper').addClass('animated fadeOutDownBig').delay(2000).hide();
    });
  },
  currentPage: function(url) {
    $('.menu-panel-right a').off('click').on('click', function() {
      $('.menu-panel-right a').removeClass('current');
      $(this).addClass('current');
    });
  },
  removeAllNotifications: function() {
    $.gritter.removeAll();
  },
  removeNotificationBinding: function() {
    $('body').off('click').on('click', function() {
      $.gritter.removeAll();
    });
  },
  initLocationAutocomplete: function() {
    if ($('#zip_autocomplete').length > 0) {
      placeholder = $('#zip_autocomplete').attr('data-placeholder');
      LocationAutocomplete.init(placeholder);
    }
  }
};

$(document).ready(function() {
  App.init();
  App.initWizeLink(); // Not in page:done to avoid double binding
  App.currentPage();
});
$(document)
  .off('page:loading').on('page:loading', function(event, $target, render, url) {
    $('.spinner-wrapper').show().find('.spinner').spin();
  })
  .off('page:done').on('page:done', function(event, $target, status, url, data) {
    App.init();
    App.currentPage();
    UserList.init();
    App.removeAllNotifications();
    $($target).animate({scrollTop: 0}, 'fast'); // Scroll top
    $('.spinner-wrapper').hide();
  });


