$(function() {
  $("#select_all").click(function() {
    $(this).parents("form").find("input:checkbox").attr("checked", true)
    return false
  });

  $("#select_not_emailed").click(function() {
    $(this).parents("form").find("input:checkbox").attr("checked", false)
    $(this).parents("form").find(".not_emailed").parent().parent().find("input:checkbox").attr("checked", true)
    return false
  });

  $("#select_none").click(function() {
    $(this).parents("form").find("input:checkbox").attr("checked", false)
    return false
  });
});
