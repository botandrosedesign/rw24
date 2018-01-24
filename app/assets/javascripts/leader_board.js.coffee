class CategoryFilter
  constructor: ->
    $("#show a").click((event) => @selectCategory(event)).eq(0).click()

  selectCategory: (event) ->
    event.preventDefault()
    $el = $(event.target)
    $el.addClass("current").siblings().removeClass("current")
    @filterCategory $el.data("category")

  filterCategory: (category) ->
    $rows = if category
      $("#teams tr").hide()
      $("#teams tr.#{category}")
    else
      $("#teams tr")

    $rows.show().removeClass("even").filter("tr:odd").addClass("even")
    $("#teams_count").html "#{$rows.length} Teams"

class Ranker
  constructor: (@categoryLetters) ->
    @pickLeaders()
    @pickWinners()

  pickLeaders: ->
    for letter in @categoryLetters
      leader = leadersByCategory(letter)[0]
      $("##{letter.toLowerCase()}_leader").html leader

  pickWinners: ->
    for letter in @categoryLetters
      winningThree = leadersByCategory(letter).slice(0, 3)
      winners = winningThree.map((winner)-> "<b>#{winner}</b>").join("<br>")
      $("##{letter.toLowerCase()}_winners").html winners

  leadersByCategory = (category) ->
    $("#teams tr.#{category}").find("td:nth-child(3)").map(-> $(this).text()).toArray()

$ ->
  new CategoryFilter()
  new Ranker(["A","B","S","M","F","T"])

