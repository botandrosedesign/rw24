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
  pickLeaders();

  window.setInterval("refreshLeaderBoard()", 30 * 1000);
});

function refreshLeaderBoard() {
  $("#teams").load("/leader-board.js", function() {
    $selected.click();
    pickLeaders();
  });
}

function pickLeaders() {
  var a_leader = $("#teams tr.A").first().find("td:nth-child(3)").text();
  var b_leader = $("#teams tr.B").first().find("td:nth-child(3)").text();
  var s_leader = $("#teams tr.S").first().find("td:nth-child(3)").text();
  var t_leader = $("#teams tr.T").first().find("td:nth-child(3)").text();
  
  $("#a_leader").html(a_leader);
  $("#b_leader").html(b_leader);
  $("#s_leader").html(s_leader);
  $("#t_leader").html(t_leader);
}
