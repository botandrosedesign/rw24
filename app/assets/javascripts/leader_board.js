$(function() {
  $("#show a").click(function(event) {
    event.preventDefault();
    $el = $(event.target)
    $el.addClass("current").siblings().removeClass("current");
    filterCategory($el.data("category"));
  }).eq(0).click();
});

function filterCategory(category) {
  if(category) {
    $("#teams tr").hide();
    var $rows = $("#teams tr." + category);
  } else {
    var $rows = $("#teams tr");
  }
  $rows.show().removeClass("even").filter("tr:odd").addClass("even");
  $("#teams_count").html($rows.length + " Teams");
}

$(function() {
  pickLeaders();
  pickWinners();
});

function pickLeaders() {
  function pickLeader(category) {
    return leadersByCategory(category)[0];
  }
  for(letter of ["A","B","S","M","F","T"]) {
    $("#"+letter.toLowerCase()+"_leader").html(pickLeader(letter));
  }
}

function pickWinners() {
  function pickWinningThree(category) {
    return leadersByCategory(category).slice(0, 3);
  }
  function formatWinners(winners) {
    return "<b>" + winners.join("</b><br/><b>") + "</b>";
  }
  for(letter of ["A","B","S","M","F","T"]) {
    $("#"+letter.toLowerCase()+"_winners").html(formatWinners(pickWinningThree(letter)));
  }
}

function leadersByCategory(category) {
  return $("#teams tr."+category).find("td:nth-child(3)").map(function() { return $(this).text(); }).toArray();
}
