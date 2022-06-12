import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["leaders"]
  static values = { initial: String }

  connect() {
    const topThree = this.#leadersByCategory(this.initialValue).slice(0, 3)
    const leaders = topThree.map(team => `<b>${team}</b>`).join("<br>")
    this.leadersTarget.innerHTML = leaders
  }

  #leadersByCategory(initial) {
    const list = document.querySelectorAll(`#teams tr.${initial} td:nth-child(3)`)
    return Array.from(list).map(e => e.innerText)
  }
}


