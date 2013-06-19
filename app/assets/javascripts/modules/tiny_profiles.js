tinyProfiles = {
  init: function() {
    profiles = $('.tiny-profile-member');

    if (profiles.length > 0) {
      $.each(profiles, function(index, val) {
        var image = $(this).find('img');
        image.imagesLoaded({
          callback: function ($images, $proper, $broken) {
            console.log('Mini Profile loaded');
            $images.addClass('resizable').resizeToParent();
          }
        });
        var animation_class = $(this).attr('data-animated-class');
        $(this).addClass(animation_class).delay(600).addClass('animated');
      });
    }
  }
};
