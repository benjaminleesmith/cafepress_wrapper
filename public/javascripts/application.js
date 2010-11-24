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
