//= require jquery
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


function initApplication() {

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

  // Fluid video
  $(".uservideo").fitVids();

  // Fit text
  $("h1.fitText").fitText(1, { minFontSize: '20px', maxFontSize: '28px' });

  window.wiselinks = new Wiselinks($('body'), {'html4': true});

  Images.init();
}

// document.addEventListener("page:change", initApplication, hideSpinner);
// document.addEventListener("page:fetch", displaySpinner);

$(document).ready(initApplication);
