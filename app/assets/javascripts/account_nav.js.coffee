$ ->
  if Cookie.get("uid")
    $("#logged_in").show()
  else
    $("#logged_out").show()

