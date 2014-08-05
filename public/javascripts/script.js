$(document).ready(function() {
  function addTokenTooltips() {
    $('.token.tooltip').tooltipsy({
      content: function($el) { return $el.attr('tooltip'); },
      delay: 0
    });

    $('.token.head-error').each(function() {
      var el = $(this);
      el.hover(function() {
        $('#' + el.attr('hr')).toggleClass('success-bg');
        $('#' + el.attr('hw')).toggleClass('error-bg');
      });
    });
  }


  addTokenTooltips();
});
