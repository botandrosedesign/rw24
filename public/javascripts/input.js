$(function() {
  $("a.number").click(function() {
    var value = $("#lap_team_number").val() + $(this).attr("data-value");
    $("#lap_team_number").val(value);
    return false;
  });

  $("a#cl").click(function() {
    var value = $("#lap_team_number").val();
    value = value.substr(0, value.length - 1);
    $("#lap_team_number").val(value);
    return false;
  });

  $("a#ok").click(function() {
    $("form").submit();
    return false;
  });
});
