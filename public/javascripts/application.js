/*
# Copyright 2010 Benjamin Lee Smith <benjamin.lee.smith@gmail.com>
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
