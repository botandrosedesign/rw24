import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["leader", "winners"]
  static values = { initial: String }

  connect() {
    if(this.hasLeaderTarget) { this.pickLeader() }
    if(this.hasWinnersTarget) { this.pickWinners() }
  }

  pickLeader() {
    const leader = this.#leadersByCategory(this.initialValue)[0]
    this.leaderTarget.innerHTML = leader
  }

  pickWinners() {
    const winningThree = this.#leadersByCategory(this.initialValue).slice(0, 3)
    const winners = winningThree.map(winner => `<b>${winner}</b>`).join("<br>")
    this.winnersTarget.innerHTML = winners
  }

  #leadersByCategory(initial) {
    const list = document.querySelectorAll(`#teams tr.${initial} td:nth-child(3)`)
    return Array.from(list).map(e => e.innerText)
  }
}


