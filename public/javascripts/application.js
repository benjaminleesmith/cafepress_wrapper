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

Event.observe(window, 'load', function() {
  setTimeout('CPW.cycle_images();', CPW.cycle_speed);
});
