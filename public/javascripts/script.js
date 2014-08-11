$(document).ready(function() {

  function hsv2rgb(h, s, v) {
  }

  function percentToColor(percent) {
    var h = Math.floor((100 - percent) * 120/ 100);
    var s = 1, v = 1;

    var rgb, i, data = [];
    h = h / 60;
    i = Math.floor(h);
    data = [v*(1-s), v*(1-s*(h-i)), v*(1-s*(1-(h-i)))];
    switch(i) {
      case 0:
        rgb = [v, data[2], data[0]]; break;
      case 1:
        rgb = [data[1], v, data[0]]; break;
      case 2:
        rgb = [data[0], v, data[2]]; break;
      case 3:
        rgb = [data[0], data[1], v]; break;
      case 4:
        rgb = [data[2], data[0], v]; break;
      default:
        rgb = [v, data[0], data[1]]; break;
    }

    return '#' + rgb.map(function(x){
      return ("0" + Math.round(x*255).toString(16)).slice(-2);
    }).join('');
  }


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

  function addWordsDiffBindings() {
    var sel = '.word-diff-table';
    $(sel).hide();
    $('.word-diff-container').click(function() {
      $(this).find(sel).toggle(300);
    });
  }

  function addPercentageColors() {
    $('.percentage').each(function() {
      var el = $(this);
      var percent = el.attr('percentage');
      var color = percentToColor(100 - percent);
      el.css('color', color);
    });
  }

  function addCategoryToggler() {
    $('.toggler').each(function() {
      var el = $(this);
      var target = el.siblings('#' + el.attr('toggler'));
      el.click(function() { target.toggle(300); });
      target.hide();
    });
  }

  function addReportToggler() {
    $('.comparison_toggle').each(function() {
      var el = $(this);
      var target = $('#' + el.attr('c_id'));
      el.click(function() { target.toggle(300); });
      el.addClass('clickable');
      target.hide();
    });
  }

  addWordsDiffBindings();
  addTokenTooltips();
  addPercentageColors();
  addCategoryToggler();
  addReportToggler();
});
