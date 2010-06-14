$(function() {
  $('input[name="team[category]"]:radio').change(function() {
    var qty;
    if(this.id.match(/solo/)) { qty = 1 }
    else if(this.id.match(/tandem/)) { qty = 2 }
    else { qty = 6 }

    $("#rider_information .field").hide().slice(0, qty).show();
    $("#rider_information .field").slice(qty).find("input, select").val("");
  }).filter(":checked").change();
})
