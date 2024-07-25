import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  static targets = [
    "field",
  ]

  connect() {
    useActions(this, {
      element: "submit:prevent",
    })
  }

  submit() {
    const value = this.fieldTarget.value
    this.fieldTarget.value = ""
    const element = document.getElementById(`team_${value}`)
    if(!element.checked) element.click()
  }
}

