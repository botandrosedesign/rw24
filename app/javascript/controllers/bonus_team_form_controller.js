import { Controller } from "@hotwired/stimulus"
import useActions from "stimulus-use-actions"

export default class extends Controller {
  static targets = [
    "field",
  ]

  connect() {
    useActions(this, {
      element: [
        "submit->submit",
        "ajax:success->success",
        "ajax:error->error",
      ],
      fieldTarget: "click",
    })
  }

  submit() {
    this.fieldTarget.indeterminate = true
    document.getElementById("flash_notice").innerText = ""
    document.getElementById("flash_alert").innerText = ""
  }

  success() {
    this.fieldTarget.indeterminate = false
    const verb = this.fieldTarget.checked ? "assigned to" : "removed from"
    const teamId = this.fieldTarget.id.split("_").at(-1)
    document.getElementById("flash_notice").innerText = `Bonus ${verb} team ${teamId}`
  }

  error() {
    const verb = this.fieldTarget.checked ? "assign bonus to" : "removed bonus from"
    const teamId = this.fieldTarget.id.split("_").at(-1)
    document.getElementById("flash_alert").innerText = `Couldn't ${verb} team ${teamId}! Check your internet connection?`
  }

  click() {
    this.element.requestSubmit()
  }
}

