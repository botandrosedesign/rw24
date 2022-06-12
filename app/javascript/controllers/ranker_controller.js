import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []
  static values = {}

  connect() {
    this.initials = ["A","B","S","M","F","T"]
    this.pickLeaders()
    this.pickWinners()
  }

  pickLeaders() {
    this.initials.forEach(initial => {
      const leader = this.leadersByCategory(initial)[0]
      const leaderElement = this.element.querySelector(`#${initial.toLowerCase()}_leader`)
      if(leaderElement) { leaderElement.innerHTML = leader }
    })
  }

  pickWinners() {
    this.initials.forEach(initial => {
      const winningThree = this.leadersByCategory(initial).slice(0, 3)
      const winners = winningThree.map(winner => `<b>${winner}</b>`).join("<br>")
      const winnerElement = this.element.querySelector(`#${initial.toLowerCase()}_winners`)
      if(winnerElement) { winnerElement.innerHTML = winners }
    })
  }

  leadersByCategory(initial) {
    const list = document.querySelectorAll(`#teams tr.${initial} td:nth-child(3)`)
    return Array.from(list).map(e => e.innerText)
  }
}


