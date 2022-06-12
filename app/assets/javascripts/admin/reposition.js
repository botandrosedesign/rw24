//= require jquery-ui/widgets/sortable

$(function() {
  $("[data-reposition]").each(function() {
    $(this).sortable({
      tolerance: "pointer",
      update: (event, ui) => {
        let url = $(this).data("reposition")
        if(url == "true") { url = window.location.href }
        const ids = $(this).children().toArray().map(e => e.getAttribute("data-id"))
        $.post(url, { _method: "PUT", ids: ids })
      },
    })
  })
})

