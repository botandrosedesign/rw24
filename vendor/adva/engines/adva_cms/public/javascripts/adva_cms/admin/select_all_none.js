$(function() {
  $("#select_all").click(function() {
    $(this).parents("form").find("input:checkbox").attr("checked", true)
    return false
  });

  $("#select_none").click(function() {
    $(this).parents("form").find("input:checkbox").attr("checked", false)
    return false
  });
});
