jQuery.noConflict()

jQuery(function() {
  jQuery('input[name=class]:radio').click(function() {
  
    // Hide other divs
    jQuery('input[name=class]:not(:checked)').each(function() {
      var e = jQuery(this).attr('data_div')
      jQuery(e).hide()
    })
    
    // Show selected divs
    var selected = jQuery('input[name=class]:checked').attr('data_div')
    jQuery(selected).show()
    
    // Show number of riders if applicable
    if(selected.match('team[AB]')) {
      jQuery('#number.field').show()
    } else {
      jQuery('#number.field').hide()
    }

    calculate_price()    
  })

  jQuery('input[name=number]:radio').click(function() {
    var number = parseInt(jQuery('input[name=number]:checked').val())
    for(i=2; i<=6; i++) {
      if(i <= number) {
        jQuery('#teamA_rider_'+i).show()
        jQuery('#teamB_rider_'+i).show()
      } else {
        jQuery('#teamA_rider_'+i).hide()
        jQuery('#teamB_rider_'+i).hide()
      }
    }

    calculate_price()    
  })
  
})

function calculate_price() {
  var qty
  var rider_class = jQuery('input[name=class]:checked').val()
  
  switch(rider_class) {
    case "Solo":
      qty = 1
      break
      
    case "Tandem":
      qty = 2
      break
      
    case "Team A":
    case "Team B":
      qty = parseInt(jQuery('input[name=number]:checked').val())
      break
  }
  
  jQuery('#qty').html(qty)
  jQuery('#total').html(qty*20)
}
