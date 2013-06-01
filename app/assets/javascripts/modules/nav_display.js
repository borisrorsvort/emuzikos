Layout = {
  init: function(bodyclass) {
    Layout.updateBodyClasses(bodyclass);
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
    if (Layout.leftPanelVisible() === true) {
      $('[href="#left"]:hidden').show();
    } else {
      $('[href="#left"]:visible').hide();
    }
    if (Layout.rightPanelVisible() === true) {
      $('[href="#right"]:hidden').show();
    } else {
      $('[href="#right"]:visible').hide();
    }
  }
};
