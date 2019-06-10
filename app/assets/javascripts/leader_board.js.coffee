class LegacyCategoryFilter
  constructor: ->
    $("#show a").click((event) => @selectlegacyCategory(event)).eq(0).click()

  selectlegacyCategory: (event) ->
    event.preventDefault()
    $el = $(event.target)
    $el.addClass("current").siblings().removeClass("current")
    @filterlegacyCategory $el.data("legacy-category")

  filterlegacyCategory: (legacyCategory) ->
    $rows = if legacyCategory
      $("#teams tr").hide()
      $("#teams tr.#{legacyCategory}")
    else
      $("#teams tr")

    $rows.show().removeClass("even").filter("tr:odd").addClass("even")
    $("#teams_count").html "#{$rows.length} Teams"

class Ranker
  constructor: (@legacyCategoryLetters) ->
    @pickLeaders()
    @pickWinners()

  pickLeaders: ->
    for letter in @legacyCategoryLetters
      leader = leadersByCategory(letter)[0]
      $("##{letter.toLowerCase()}_leader").html leader

  pickWinners: ->
    for letter in @legacyCategoryLetters
      winningThree = leadersByLegacyCategory(letter).slice(0, 3)
      winners = winningThree.map((winner)-> "<b>#{winner}</b>").join("<br>")
      $("##{letter.toLowerCase()}_winners").html winners

  leadersByLegacyCategory = (legacyCategory) ->
    $("#teams tr.#{legacyCategory}").find("td:nth-child(3)").map(-> $(this).text()).toArray()

$ ->
  new LegacyCategoryFilter()
  new Ranker(["A","B","S","M","F","T"])

