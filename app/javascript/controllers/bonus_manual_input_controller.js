import { Controller } from "@hotwired/stimulus"
import { withActions } from "stimulus-use-actions"

export default class extends withActions(Controller) {
  static targets = [
    "field",
  ]

  static actions = {
    element: "submit:prevent",
  }

  submit() {
    const value = this.fieldTarget.value
    this.fieldTarget.value = ""
    const element = document.getElementById(`team_${value}`)
    if(!element.checked) element.click()
  }
}

