//= require jquery
//= require jquery.ceebox

$(document).on("click", "a.ceebox", function(event) {
  event.preventDefault();
  $(this).ceebox();
  $(this).click();
});

