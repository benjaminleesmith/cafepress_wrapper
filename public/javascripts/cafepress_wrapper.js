/*
# Copyright 2010-2011 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
#
# This file is part of CafePress Wrapper.
# CafePress Wrapper is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CafePress Wrapper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CafePress Wrapper.  If not, see <http://www.gnu.org/licenses/>.
*/

if(!CPW) var CPW = {};
CPW.cycle_speed = 3000;
CPW.front_images_shown = true;

CPW.cycle_images = function() {
  if(CPW.front_images_shown) {
    CPW.fade_fronts();
    setTimeout('CPW.appear_backs();', 1000);
    CPW.front_images_shown = false;
  } else {
    CPW.fade_backs();
    setTimeout('CPW.appear_fronts();', 1000);
    CPW.front_images_shown = true;
  }
  setTimeout('CPW.cycle_images();', CPW.cycle_speed);
};

CPW.appear_backs = function() {
  $$('.back-image').forEach(function(element) {
    element.appear();
  });
};

CPW.appear_fronts = function() {
  $$('.front-image').forEach(function(element) {
    element.appear();
  });
};

CPW.fade_backs = function() {
  $$('.back-image').forEach(function(element) {
    element.fade();
  });
};

CPW.fade_fronts = function() {
  $$('.front-image').forEach(function(element) {
    element.fade();
  });
};

CPW.update_moving_div = function() {
  top_padding = 20;

  //little confusing... y values go up as the user scrolls down...
  min_y = $('active_product').cumulativeOffset().top - top_padding;
  max_y = $('content').cumulativeOffset().top + $('content').getHeight() - $('moving_div').getHeight();

  //if the user's browser is big enough to show the entire moving div at once
  //if (document.viewport.getHeight() > $('moving_div').getHeight()) {
    if(document.viewport.getScrollOffsets().top > min_y && document.viewport.getScrollOffsets().top < max_y) {
      $('moving_div').setStyle({ top: 4 + (document.viewport.getScrollOffsets().top - min_y) + 'px' });
      //new Effect.Move('moving_div', { x: 20, y: 4 + (document.viewport.getScrollOffsets().top - min_y), mode: 'absolute' });
    } else if (document.viewport.getScrollOffsets().top < min_y) {
      $('moving_div').setStyle({ top: '4px' });
    } else if (document.viewport.getScrollOffsets().top > max_y) {
      $('moving_div').setStyle({ top: (max_y-min_y)+'px'});
    }
  //} else {
  //
  //}
};

CPW.auto_update_moving_div = function() {
  update_moving_div();
  setTimeout('auto_update_moving_div()',1000);
};

CPW.bind_color_name_events = function() {
  $$('div#colors div.multiple_colors a').each(function(element) {
    element.observe('mouseover', function(event) {
      $('color_'+element.readAttribute('data-color_id')+'_description').show();
    });
    element.observe('mouseout', function(event) {
      $('color_'+element.readAttribute('data-color_id')+'_description').hide();
    });
  });
};

CPW.update_selected_color = function(color_id) {
  $('selected_color_id').value = color_id;
};

CPW.force_numeric_quantity = function(input_field) {
  var regExpr = new RegExp(/^\d*$/);
  if (!regExpr.test(input_field.value)) {
    // Case of error
    input_field.value = "";
  }
};

CPW.validate_quantity = function() {
  var regex = new RegExp(/^\d*$/);
  if(!regex.test($$('div#quantity input')[0].value)) {
    alert('Please enter a valid number for the quantity of shirts you want.')
    return false;
  }
  return true;
};

