import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "count", "team"]
  static values = {}

  connect() {
    this.buttonTargets[0].click()
  }

  select(event) {
    event.preventDefault()
    this.buttonTargets.forEach(e => e.classList.remove("current"))
    event.target.classList.add("current")
    this.#filterCategory(event.params.initial)
  }

  #filterCategory(initial) {
    let rows = this.teamTargets

    if(initial) {
      this.teamTargets.forEach(e => {
        e.style.display = "none"
        e.classList.remove("even")
      })
      rows = rows.filter(e => e.classList.contains(initial))
    }

    rows.forEach((e, index) => {
      e.style.display = "table-row"
      if(index % 2 === 1) { e.classList.add("even") }
    })

    this.countTarget.innerHTML = `${rows.length} Teams`
  }
}

