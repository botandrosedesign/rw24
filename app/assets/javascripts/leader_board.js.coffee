class CategoryFilter
  constructor: ->
    $("#show a").click((event) => @selectCategory(event)).eq(0).click()

  selectCategory: (event) ->
    event.preventDefault()
    $el = $(event.target)
    $el.addClass("current").siblings().removeClass("current")
    @filterCategory $el.data("category-initial")

  filterCategory: (initial) ->
    $rows = if initial
      $("#teams tr").hide()
      $("#teams tr.#{initial}")
    else
      $("#teams tr")

    $rows.show().removeClass("even").filter("tr:odd").addClass("even")
    $("#teams_count").html "#{$rows.length} Teams"

class Ranker
  constructor: (@initials) ->
    @pickLeaders()
    @pickWinners()

  pickLeaders: ->
    for initial in @initials
      leader = leadersByCategory(initial)[0]
      $("##{initial.toLowerCase()}_leader").html leader

  pickWinners: ->
    for initial in @initials
      winningThree = leadersByCategory(initial).slice(0, 3)
      winners = winningThree.map((winner)-> "<b>#{winner}</b>").join("<br>")
      $("##{initial.toLowerCase()}_winners").html winners

  leadersByCategory = (initial) ->
    $("#teams tr.#{initial}").find("td:nth-child(3)").map(-> $(this).text()).toArray()

$ ->
  new CategoryFilter()
  new Ranker(["A","B","S","M","F","T"])

