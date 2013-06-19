Layout = {
  init: function(bodyclass) {
    Layout.updateBodyClasses(bodyclass);
    Layout.displaToggleButtons(bodyclass);
    $(window).on("resize", function( event ) {
      Layout.displaToggleButtons();
    });
  },
  updateBodyClasses: function(bodyclass) {
    $el = $('body');
    var classes = $el.attr("class").split(" ").filter(function(item) {
      return item.indexOf("layout") === -1 ? item : "";
    }).filter(function(item) {
      return item.indexOf("show-") === -1 ? item : "";
    });
    $el.attr("class", classes.join(" "));
    if ($('body').hasClass(bodyclass) === false) {
      console.log('Qdded clqsse');
      $('body').addClass(bodyclass);
    }
  },
  leftPanelVisible: function() {
    return $('.menu-panel-left').is(':visible');
  },
  rightPanelVisible: function() {
    return $('.menu-panel-right').is(':visible');
  },
  displaToggleButtons: function() {
    $('[data-trigger=close]').hide();
    if (Layout.leftPanelVisible() === true) {
      console.log('Left panel visible');
      $('[href="#left"]').hide();
    } else {
      console.log('Left panel not visible');
      $('[href="#left"]:hidden').show();
    }
    if (Layout.rightPanelVisible() === true) {
      console.log('Right panel visible');
      $('[href="#right"]').hide();
    } else {
      console.log('Left panel not visible');
      $('[href="#right"]:hidden').show();
    }
  }
};
