#= require jquery-ui/widgets/sortable

$ ->
  $("[data-reposition]").each ->
    $sortable = $(this).sortable
      tolerance: "pointer"
      update: (event, ui) ->
        url = if $(this).data("reposition") == "true"
          window.location.href
        else
          $(this).data("reposition")
        ids = $(this).children().map( -> @getAttribute("data-id")).get()
        data =
          _method: "PUT"
          ids: ids
        $.post url, data

