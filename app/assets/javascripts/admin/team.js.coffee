#= require jquery-ui/widgets/autocomplete
#= require cocoon

$ ->
  $("[data-team-category-select]").each ->
    selector = $(this).data("team-category-select")
    $(this).change ->
      desiredLength = $("option:selected", this).data("max")
      actualLength = $(selector).length

      if desiredLength > actualLength
        for i in [1..(desiredLength - actualLength)]
          $("[data-association='rider']").click()

      if actualLength > desiredLength
        for i in [1..(actualLength - desiredLength)]
          index = actualLength - i
          $("#{selector} .remove_fields").get(i).click()

    $("body").on "cocoon:after-insert", (e, insertedItem, originalEvent) ->
      $("[data-autocomplete]", insertedItem).each ->
        $field = $(this)
        $input = $field.next()
        $fieldset = $field.closest("fieldset")
        source = $field.data("autocomplete")

        $field.autocomplete
          source: source
          focus: (event, ui) ->
            $field.val ui.item.label
            false
          select: (event, ui) ->
            item = ui.item
            $field.val item.label
            $fieldset.find("input[name$='[user_id]']").val item.user_id
            $fieldset.find("input[name$='[name]']").val item.name
            $fieldset.find("input[name$='[email]']").val item.email
            $fieldset.find("input[name$='[phone]']").val item.phone
            false
        $field.autocomplete("instance")._renderItem = (ul, item) ->
          $("<li>")
            .append("<div>#{item.label}</div>")
            .appendTo(ul)
