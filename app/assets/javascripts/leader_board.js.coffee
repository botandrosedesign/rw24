$ ->
  filterCategory = (category) ->
    $rows = if category
      $("#teams tr").hide()
      $("#teams tr.#{category}")
    else
      $("#teams tr")

    $rows.show().removeClass("even").filter("tr:odd").addClass("even")
    $("#teams_count").html "#{$rows.length} Teams"

  $("#show a").click ->
    event.preventDefault()
    $el = $(event.target)
    $el.addClass("current").siblings().removeClass("current")
    filterCategory $el.data("category")
  .eq(0).click()

$ ->
  categoryLetters = ["A","B","S","M","F","T"]

  pickLeaders = ->
    pickLeader = (category) ->
      leadersByCategory(category)[0]

    for letter in categoryLetters
      $("##{letter.toLowerCase()}_leader").html pickLeader(letter)

  pickWinners = ->
    pickWinningThree = (category) ->
      leadersByCategory(category).slice(0, 3)

    formatWinners = (winners) ->
      winners.map((winner)-> "<b>#{winner}</b>").join("<br>")

    for letter in categoryLetters
      $("##{letter.toLowerCase()}_winners").html formatWinners(pickWinningThree(letter))

  leadersByCategory = (category) ->
    $("#teams tr.#{category}").find("td:nth-child(3)").map(-> $(this).text()).toArray()

  pickLeaders()
  pickWinners()

