$(function() {
  $('input[name="registration[team_attributes][category]"]:radio').change(function() {
    var qty;
    if(this.id.match(/solo$/)) { qty = 1 }
    else if(this.id.match(/tandem$/)) { qty = 2 }
    else { qty = 6 }

    $("#rider_information .field").hide().slice(0, qty).show();
  });
})
