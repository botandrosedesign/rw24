$(function() {
  $("a.number").click(function() {
    var value = $("#team_number").val() + $(this).attr("data-value");
    $("#team_number").val(value);
    return false;
  });

  $("a#cl").click(function() {
    var value = $("#team_number").val();
    value = value.substr(0, value.length - 1);
    $("#team_number").val(value);
    return false;
  });

  $("a#ok").click(function() {
    $("form#number_form").submit();
    return false;
  });
});
