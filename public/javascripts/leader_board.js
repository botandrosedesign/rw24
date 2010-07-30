(function(){
  jQuery.fn.tap = function(fn /* [callback_arg], [callback_arg], [...] */) {
    var args = jQuery.makeArray(arguments);
    args.unshift();

    fn.apply(this, args);
    return this;
  };
}());

var $selected;

$(function() {
  $("#show a").click(function() {
    $(this).siblings().removeClass("current");
    $(this).addClass("current");
    $selected = $(this);

    var category = $(this).attr("data-category");
    var count;
    if(category) {
      $("#teams tr").hide();
      $("#teams tr." + category).show()
        .tap(function() { count = this.length; })
        .removeClass("even").filter("tr:odd").addClass("even");
    } else {
      $("#teams tr").show()
        .tap(function() { count = this.length; })
        .removeClass("even").filter("tr:odd").addClass("even");
    }
    $("#teams_count").html(count + " Teams");

    return false;
  });

  $selected = $("#show a:first-child");
  $selected.click();

  window.setInterval("refreshLeaderBoard()", 30 * 1000);
});

function refreshLeaderBoard() {
  $("#teams").load("/leader-board.js", function() {
    $selected.click();
  });
}
