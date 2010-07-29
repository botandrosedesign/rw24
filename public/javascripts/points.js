$(function() {
  $("#sidebar form").submit(function() {
    var now = new Date().valueOf();
    var start = Date.UTC(2010, 6, 27, 1, 0, 0);
    var since_start = now - start;
    var since_start_formatted = format_time_diff(since_start);
    var id = "point_" + now;
    $(this).find("#point_since_start").val(since_start_formatted);

    var queryString = $(this).serialize();
    $("#points").addPendingRow(id, $(this).serializeObject());
    this.reset();
    $(this).find("#point_team_position").focus();

    $.ajax({
      type: 'POST',
      url: this.action,
      data: queryString,
      retry: true,
      success: function(data, textStatus) {
        $("#"+id).replaceWith(data);
      },
      error: function(xhr, textStatus, errorThrown) {
        $("#"+id).removeClass("pending").addClass("failed")
          .find("td:last-child").html('\
            <a href="/points/new?id=' + id + '&' + queryString + '" class="ceebox new" title="New Score" rel="modal: true width:500 height:200"></a>\
            <a href="#" onclick="$(this).parent().parent().remove(); return false;" class="delete"></a>\
          ')
          .prev().html(xhr.responseText);
      }
    });
    return false;
  });

  $.fn.addPendingRow = function(id, data) {
    data.id = id;
    var html = $.templates.pointRow(data);
    this.prepend(html);
  };

  function format_time_diff(diff) {
    var oneMinute = 60 * 1000;
    var oneHour = oneMinute * 60;

    var hours = diff / oneHour;
    var minutes = diff % oneHour / oneMinute;
    var seconds = diff % oneMinute / 1000;

    return $.map([hours, minutes, seconds], function(n) {
      return $.sprintf("%02d", Math.floor(n));
    }).join(":");
  }

  $("#points td.delete form").live('click', function() {
    var id = $(this).parents("tr").attr("id");
    $.ajax({
      type: 'POST',
      url: this.action,
      data: $(this).serialize(),
      retry: true,
      success: function(data, textStatus) {
        $("#"+id).remove();
      },
      error: function(xhr, textStatus, errorThrown) {
        $("#"+id).addClass("failed")
          .find("td:last-child").html('<a href="#" onclick="$(this).parent().parent().remove(); return false;">Clear</a>')
          .prev().prev().html("Couldn't delete");
      }
    });
    return false;
  });

  $("#cee_box form").live('submit', function() {
    var id = "point_" + $(this).find("#point_id").val();
    var backup_id = $(this).find("#backup_id").val();

    if(!id.match(/point_\d+/)) {
      id = backup_id;
    }

    $.ajax({
      type: 'POST',
      url: this.action,
      data: $(this).serialize(),
      retry: true,
      success: function(data, textStatus) {
        $("#"+id).remove();
        var $el = $(data);
        $("#points").prepend($el);
        sortLoop($el);
      },
      error: function(xhr, textStatus, errorThrown) {
        $("#"+id).addClass("failed");
      }
    });
    $("#cee_closeBtn").click();
    return false;
  });

  $(".ceebox").ceebox();

  sortLoop = function($el) {
    var $next = $el.next();
    var a = $el.find(".sort").html();
    var b = $next.find(".sort").html();
    if(a < b) {
      $el.detach().insertAfter($next);
      sortLoop($el);
    }
  }

  fixed_number_or_empty = function(value) {
    value = parseInt(value);
    if(!value > 0) { return "---"; }
    return $.sprintf("%03d", value);
  }
});

