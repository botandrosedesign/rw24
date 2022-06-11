class Countdown {
  constructor(el) {
    el = el || $('countdown')[0]
    this.$el = $(el)

    this.oneMinute = 60 * 1000
    this.oneHour = this.oneMinute * 60
    this.oneDay = this.oneHour * 24
    this.oneYear = this.oneDay * 365

    this.now = new Date().valueOf()
    this.start = new Date(this.$el.attr("target")).valueOf()
    this.finish = this.start + this.oneDay
    this.next = this.start + this.oneYear

    window.setInterval(() => {
      this.now += 1000
      this.render()
    }, 1000)

    this.render()
  }

  render() {
    if(this.now > this.finish) {
      this.start = this.next
    }

    const diff = Math.abs(this.start - this.now)

    const countdownDay = Math.floor(diff / this.oneDay)
    const countdownHrs = Math.floor(diff % this.oneDay / this.oneHour)
    const countdownMin = Math.floor(diff % this.oneHour / this.oneMinute)
    const countdownSec = Math.floor(diff % this.oneMinute / 1000)

    const current = this.start < this.now && this.now < this.finish

    this.$el.find("days").html(this.doubleDigits(countdownDay))
    this.$el.find("hours").html(this.doubleDigits(countdownHrs))
    this.$el.find("minutes").html(this.doubleDigits(countdownMin))
    this.$el.find("seconds").html(this.doubleDigits(countdownSec))
    this.$el.find("waiting").toggle(!current)
    this.$el.find("during").toggle(current)
  }

  doubleDigits(number) {
    return number < 10 ? "0"+number.toString() : number.toString()
  }
}

$(() => $("countdown").each(function() { new Countdown(this) }))

