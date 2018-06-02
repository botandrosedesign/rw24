class window.Countdown
  constructor: (el) ->
    el = el || $('countdown')[0]
    @$el = $(el)

    @oneMinute = 60 * 1000
    @oneHour = @oneMinute * 60
    @oneDay = @oneHour * 24
    @oneYear = @oneDay * 365

    @now = new Date().valueOf()
    @start = new Date(@$el.attr("target")).valueOf()
    @finish = @start + @oneDay
    @next = @start + @oneYear

    setInterval =>
      @now += 1000
      @render()
    , 1000

    @render()

  render: ->
    if @now > @finish
      @start = @next

    diff = Math.abs(@start - @now)

    countdownDay = Math.floor(diff / @oneDay)
    countdownHrs = Math.floor(diff % @oneDay / @oneHour)
    countdownMin = Math.floor(diff % @oneHour / @oneMinute)
    countdownSec = Math.floor(diff % @oneMinute / 1000)

    current = @start < @now && @now < @finish

    @$el.find("days").html(doubleDigits(countdownDay))
    @$el.find("hours").html(doubleDigits(countdownHrs))
    @$el.find("minutes").html(doubleDigits(countdownMin))
    @$el.find("seconds").html(doubleDigits(countdownSec))
    @$el.find("waiting").toggle(!current)
    @$el.find("during").toggle(current)

  doubleDigits = (number) ->
    if number < 10 then "0"+number.toString() else number.toString()

$ ->
  $("countdown").each -> new Countdown(this)

