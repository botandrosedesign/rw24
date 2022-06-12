import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "waiting",
    "during",
    "days",
    "hours",
    "minutes",
    "seconds",
  ]

  static values = {
    startsAt: String,
  }

  connect() {
    this.oneMinute = 60 * 1000
    this.oneHour = this.oneMinute * 60
    this.oneDay = this.oneHour * 24
    this.oneYear = this.oneDay * 365

    this.now = new Date().valueOf()
    this.start = new Date(this.startsAtValue).valueOf()
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

    this.daysTarget.innerHTML = this.#doubleDigits(countdownDay)
    this.hoursTarget.innerHTML = this.#doubleDigits(countdownHrs)
    this.minutesTarget.innerHTML = this.#doubleDigits(countdownMin)
    this.secondsTarget.innerHTML = this.#doubleDigits(countdownSec)
    this.#toggleElement(this.waitingTarget, !current)
    this.#toggleElement(this.duringTarget, current)
  }

  #doubleDigits(number) {
    return number < 10 ? "0"+number.toString() : number.toString()
  }

  #toggleElement(element, bool) {
    element.style.display = bool ? 'inherit' : 'none'
  }
}
