$(document).ready(function() {
  function addTokenTooltips() {
    $('.token.tooltip').tooltipsy({
      content: function($el) { return $el.attr('tooltip'); },
      delay: 0
    });
  }


  addTokenTooltips();
});
